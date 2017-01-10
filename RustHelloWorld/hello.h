#pragma once

#include <stdint.h>

struct RustByteSlice {
    const uint8_t *bytes;
    size_t len;
};

int32_t rust_hello_world(void);

uint16_t triple_a_uint16(uint16_t);
float return_float();
double average_two_doubles(double, double);
size_t sum_sizes(size_t, size_t);

void utf8_bytes_to_rust(const char*, size_t len);
void c_string_to_rust(const char*);

struct RustByteSlice get_string_from_rust(void);
