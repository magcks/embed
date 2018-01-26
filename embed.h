#ifndef __EMBED_H
#define __EMBED_H
#ifdef __cplusplus
#include <cstddef>
#define EMBED_DECL(NAME) extern "C" embed::Resource NAME(void)
namespace embed {
struct Resource {
	const char *data;
	std::size_t size;
};
}
#else
#include <stddef.h>
#define EMBED_DECL(NAME) extern struct embed_resource NAME(void)
typedef struct embed_resource {
	const char *data;
	size_t size;
} embed_resource_t;
#endif
#endif