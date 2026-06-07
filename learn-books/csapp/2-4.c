#include <stdio.h>

// unsigned char *byte_pointer;
// ではなく
// byte_pointer
// ↓
// unsigned char * の別名
// byte_pointer p;はunsigned char *p;と同じ意味
typedef unsigned char *byte_pointer;

void show_bytes(byte_pointer start, size_t len) {
    int i;

    for (i = 0; i < len; i++)
        printf(" %.2x", start[i]);
    printf("\n");
}

void show_int(int x) {
    show_bytes((byte_pointer) &x, sizeof(int));
}

void show_float(float x) {
    show_bytes((byte_pointer) &x, sizeof(float));
}

void show_pointer(void *x) {
    show_bytes((byte_pointer) &x, sizeof(void *));
}

int main(int argc, char const *argv[]) {
    int x = 12345;
    show_bytes((byte_pointer)&x, sizeof(int));

    float y = 12345.0;
    show_float(y);
    show_pointer(&x);
    show_pointer(&y);
    show_int(0x12345678);

    return 0;
}
