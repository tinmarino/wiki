```c
#define PI 3.14159265
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define ABS(x) ((x) < 0 ? -(x) : (x))
#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
#define UNUSED(x) (void)(x)
#define NULL ((void*)0)
#define offsetof(type, member) ((size_t)&((type*)0)->member)
#define offsetof(type, member) ((size_t)&((type*)0)->member)
#define TO_STRING(x) #x
#define CONCAT(a, b) a##b
#define IS_EVEN(x) ((x) % 2 == 0)
#define IS_ODD(x) ((x) % 2 != 0)
#define SWAP(a, b) do { typeof(a) temp = a; a = b; b = temp; } while (0)
#define ASSERT(condition) if (!(condition)) { fprintf(stderr, "Assertion failed: %s\n", #condition); exit(EXIT_FAILURE); }
#define offsetof(type, member) ((size_t)&((type*)0)->member)
#define STRLEN(s) (sizeof(s) - 1)
#define STRCMP(s1, s2) strcmp(s1, s2)
#define STRCPY(dest, src) strcpy(dest, src)
#define STRCAT(dest, src) strcat(dest, src)
#define STRNCMP(s1, s2, n) strncmp(s1, s2, n)
#define STRCHR(s, c) strchr(s, c)
#define STRSTR(s1, s2) strstr(s1, s2)
#define MEMCPY(dest, src, n) memcpy(dest, src, n)
#define MEMSET(dest, val, n) memset(dest, val, n)
#define MALLOC(size) malloc(size)
#define FREE(ptr) free(ptr)
#define REALLOC(ptr, size) realloc(ptr, size)
#define CALLOC(n, size) calloc(n, size)
#define FOPEN(filename, mode) fopen(filename, mode)
#define FCLOSE(file) fclose(file)
#define PRINTF(format, ...) printf(format, ##__VA_ARGS__)
#define SCANF(format, ...) scanf(format, ##__VA_ARGS__)
#define SPRINTF(buffer, format, ...) sprintf(buffer, format, ##__VA_ARGS__)
#define SNPRINTF(buffer, size, format, ...) snprintf(buffer, size, format, ##__VA_ARGS__)
#define EXIT(code) exit(code)
#define ABORT() abort()
#define RAND() rand()
#define SRAND(seed) srand(seed)
#define TIME(t) time(t)
#define CLOCK() clock()
#define SLEEP(seconds) sleep(seconds)
#define STR(x) #x
#define STR_CAT(x, y) STR(x) STR(y)
#define IS_BIT_SET(num, bit) ((num) & (1 << (bit)))
#define SET_BIT(num, bit) ((num) |= (1 << (bit)))
#define CLEAR_BIT(num, bit) ((num) &= ~(1 << (bit)))
#define TOGGLE_BIT(num, bit) ((num) ^= (1 << (bit)))
#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"
#define BYTE_TO_BINARY(byte)  \
  ((byte) & 0x80 ? '1' : '0'), \
  ((byte) & 0x40 ? '1' : '0'), \
  ((byte) & 0x20 ? '1' : '0'), \
  ((byte) & 0x10 ? '1' : '0'), \
  ((byte) & 0x08 ? '1' : '0'), \
  ((byte) & 0x04 ? '1' : '0'), \
  ((byte) & 0x02 ? '1' : '0'), \
  ((byte) & 0x01 ? '1' : '0')

#define STRING_TO_ARRAY(input) \
    char array_##input[] = { input, '\0' }

```
