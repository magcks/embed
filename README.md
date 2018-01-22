# Embed
This CMake module provides a macro to add binary files to your executable or library. It is similar to the (incbin)[https://github.com/graphitemaster/incbin] project.

This module doesn't need any dependencies and code generators. It uses the assembly INCBIN pseudo operation and Resources Files (.rc) on windows.

## How to use
Just copy the `FindEmbed.cmake` file into the module directory of your project and add the corresponding lines to your `CMakeLists.txt`:
```
find_package(Embed REQUIRED)
EMBED_TARGET(SHADER source.glsl)
add_executable(example main.cc ${EMBED_SHADER_OUTPUTS})
```

## Portability
This module is tested on the following platforms:
* GCC
* LLVM
* MSVC

## License
This software is licensed under the MIT license included as `LICENSE.md`.