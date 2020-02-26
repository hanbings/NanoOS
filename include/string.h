/*Hanbings 3219065882@qq.com*/

PUBLIC	void*	memcpy(void* p_dst, void* p_src, int size);
PUBLIC	void	memset(void* p_dst, char ch, int size);
PUBLIC	int	strlen(const char* p_str);
PUBLIC	int	memcmp(const void * s1, const void *s2, int n);
PUBLIC	int	strcmp(const char * s1, const char *s2);
PUBLIC	char*	strcat(char * s1, const char *s2);

#define	phys_copy	memcpy
#define	phys_set	memset

