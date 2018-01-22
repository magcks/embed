# - Provide a macro to embed binary files into the executable.
#
# This file is part of the Embed project: https://github.com/magcks/embed
#
# The module defines the macros:
#
#  EMBED_TARGET(<Name> <BinFile>)
#
# which will create  a custom rule to a assembly file. <BinFile> is
# the path to the binary file.
#
# The macro defines a set of variables:
#  EMBED_${Name}_DEFINED       - true is the macro ran successfully
#  EMBED_${Name}_INPUT         - The input source file, an alias for <BinFile>
#  EMBED_${Name}_OUTPUT        - The source file generated
#
#  ====================================================================
#  Example:
#
#   find_package(Embed REQUIRED)
#   EMBED_TARGET(SHADER source.glsl)
#   add_executable(example main.cc ${EMBED_SHADER_OUTPUTS})
#  ====================================================================


cmake_minimum_required(VERSION 3.0)

set(RESID 256)
set(STRUCT "struct Res { const char *data\; unsigned int size\; }\;")

macro(EMBED_TARGET Name Input)
	get_filename_component(InputAbs "${Input}" REALPATH BASE_DIR "${CMAKE_SOURCE_DIR}")
	if(WIN32)
		set(OutputRC "${CMAKE_CURRENT_BINARY_DIR}/${Name}.rc")
		set(OutputC "${CMAKE_CURRENT_BINARY_DIR}/${Name}.c")
		set(Outputs ${OutputRC} ${OutputC})
		set(RCCODE "#define ${Name} ${RESID}\n${Name} RCDATA \"${InputAbs}\"\n")
		set(CODE "#include \"windows.h\"\n${STRUCT} struct Res ${Name}() { HMODULE handle = GetModuleHandle(NULL)\; HRSRC res = FindResource(handle, MAKEINTRESOURCE(${RESID}), RT_RCDATA)\; struct Res r = { (const char*)LockResource(LoadResource(handle, res)), SizeofResource(handle, res) }\; return r\; }\n")
		file(WRITE ${OutputRC} ${RCCODE})
		file(WRITE ${OutputC} ${CODE})
		math(EXPR RESID "${RESID}+1")
	else()
		if(APPLE)
			set(Section ".const_data")
		else()
			set(Section ".section .rodata")
		endif()
		set(CODE "asm(\"${Section}\\n.align ${CMAKE_SIZEOF_VOID_P}\\ndata: .incbin \\\"${InputAbs}\\\"\\nenddata:\\n\")\; ${STRUCT} extern const char data[]\; extern const char enddata[]\; struct Res ${Name}() { struct Res r = { data, enddata - data }\; return r\; }\n")
		set(OutputC "${CMAKE_CURRENT_BINARY_DIR}/${Name}.c")
		set(Outputs ${OutputC})
		file(WRITE ${OutputC} ${CODE})

		add_custom_command(
			OUTPUT ${OutputC}
			COMMAND ${CMAKE_COMMAND} -E touch ${OutputC}
			DEPENDS ${Input}
		)
	endif()
	set(EMBED_${Name}_DEFINED TRUE)
	set(EMBED_${Name}_INPUT ${Input})
	set(EMBED_${Name}_OUTPUTS ${Outputs})
endmacro()