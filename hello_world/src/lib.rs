extern crate libc;

use libc::{c_char, size_t};
use std::{slice, str};
use std::ffi::CStr;

#[repr(C)]
pub struct RustByteSlice {
    pub bytes: *const u8,
    pub len: size_t,
}

#[no_mangle]
pub extern fn rust_hello_world() -> i32 {
    println!("Hello world from Rust!");
    10
}

#[no_mangle]
pub extern fn triple_a_uint16(x: u16) -> u16 {
    x * 3
}

#[no_mangle]
pub extern fn return_float() -> f32 {
    10.0
}

#[no_mangle]
pub extern fn average_two_doubles(x: f64, y: f64) -> f64 {
    (x + y) / 2.0
}

#[no_mangle]
pub extern fn sum_sizes(x: size_t, y: size_t) -> size_t {
    let x_usize = x as usize;
    let y_usize = y as usize;
    (x_usize + y_usize) as size_t
}

fn print_byte_slice_as_utf8(bytes: &[u8]) {
    match str::from_utf8(bytes) {
        Ok(s) => println!("got {}", s),
        Err(err) => println!("invalid utf-8 data: {}", err),
    };
}

#[no_mangle]
pub extern fn utf8_bytes_to_rust(bytes: *const u8, len: size_t) {
    let byte_slice = unsafe { slice::from_raw_parts(bytes, len as usize)};
    print_byte_slice_as_utf8(byte_slice);
}

#[no_mangle]
pub extern fn c_string_to_rust(null_terminated_string: *const c_char) {
    let c_str: &CStr = unsafe { CStr::from_ptr(null_terminated_string)};
    let byte_slice: &[u8] = c_str.to_bytes();
    print_byte_slice_as_utf8(byte_slice);
}

#[no_mangle]
pub extern fn get_string_from_rust() -> RustByteSlice {
    let s = "This string is from Rust.";
    RustByteSlice {
        bytes: s.as_ptr(),
        len: s.len() as size_t,
    }
}
