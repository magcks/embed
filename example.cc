#include <iostream>
#include <string>

// Rename this structs or its member variables however you want.
struct Res {
	const char *data;
	unsigned int size;
};

// The resource functions are defined elsewhere...
extern "C" Res SHADER_VTX(void);
extern "C" Res SHADER_FRAG(void);

int main(int argc, const char **argv)
{
	Res vtx = SHADER_VTX();
	Res frag = SHADER_FRAG();
	std::cout << "Vertex shader soruce: " << std::endl << std::string(vtx.data, vtx.size) << std::endl;
	std::cout << "Fragment shader source: " << std::endl << std::string(frag.data, frag.size) << std::endl;
}