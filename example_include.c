#include <stdio.h>

#include "embed.h"

EMBED_DECL(SHADER_VTX);
EMBED_DECL(SHADER_FRAG);

int main(int argc, const char **argv)
{
	embed_resource_t vtx = SHADER_VTX();
	embed_resource_t frag = SHADER_FRAG();
	printf("Vertex shader soruce: %.*s\nFragment shader source: %.*s\n", vtx.size, vtx.data, frag.size, frag.data);
}