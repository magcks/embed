#include <iostream>
#include <string>

#include "embed.h"

EMBED_DECL(SHADER_VTX);
EMBED_DECL(SHADER_FRAG);

int main(int argc, const char **argv)
{
	embed::Resource vtx = SHADER_VTX();
	embed::Resource frag = SHADER_FRAG();
	std::cout << "Vertex shader soruce: " << std::string(vtx.data, vtx.size) << std::endl;
	std::cout << "Fragment shader source: " << std::string(frag.data, frag.size) << std::endl;
}