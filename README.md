# Embed
This CMake module provides a macro to add binary files to your executable or library. It is similar to the [incbin](https://github.com/graphitemaster/incbin) project.

This module doesn't need any dependencies, code generators or `#include`s. It uses the assembly pseudo operation `INCBIN` and Resources Files (.rc) on windows.

## Quick install
```
wget https://raw.githubusercontent.com/magcks/embed/master/FindEmbed.cmake https://raw.githubusercontent.com/magcks/embed/master/embed.h
```

## How to use
Just copy the `FindEmbed.cmake` file into the module directory of your project and add the corresponding lines to your `CMakeLists.txt`:
```
find_package(Embed REQUIRED)
EMBED_TARGET(SHADER source.glsl)
add_executable(example main.cc ${EMBED_SHADER_OUTPUTS})
```

Then use it in your source file like this:
```
struct Res {
	const char *data;
	size_t size;
};
extern "C" Res SHADER(void);
// ...
Res vtx = SHADER(); // use vtx.data, vtx.size
```

Or if you don't care about an additional `#include`, copy the `embed.h` file to your project and use it like this:
```
#include "embed.h"
EMBED_DECL(SHADER);
// ...
embed::Resource vtx = SHADER(); // use vtx.data, vtx.size; EmbedResource for c
```

## Portability
This module is tested on the following platforms:
* GCC
* LLVM
* MSVC

## License
This software is licensed under the MIT license included as `LICENSE.md`.