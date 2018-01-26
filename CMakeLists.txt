project(Example)
cmake_minimum_required(VERSION 3.0)
set(CMAKE_MODULE_PATH
	${CMAKE_MODULE_PATH}
	${CMAKE_SOURCE_DIR}
)
find_package(Embed REQUIRED)
if(NOT CMAKE_BUILD_TYPE)
	message(STATUS "Setting build type to \"RELEASE\" as none was specified.")
	set(CMAKE_BUILD_TYPE RELEASE)
endif()
set(CMAKE_CXX_STANDARD 11)
EMBED_TARGET(SHADER_VTX "shader.vtx.glsl")
EMBED_TARGET(SHADER_FRAG "shader.frag.glsl")
add_executable(example
	example.cc
	${EMBED_SHADER_VTX_OUTPUTS}
	${EMBED_SHADER_FRAG_OUTPUTS}
)
add_executable(example_inc_c
	example_include.c
	${EMBED_SHADER_VTX_OUTPUTS}
	${EMBED_SHADER_FRAG_OUTPUTS}
)
add_executable(example_inc_cpp
	example_include.cc
	${EMBED_SHADER_VTX_OUTPUTS}
	${EMBED_SHADER_FRAG_OUTPUTS}
)