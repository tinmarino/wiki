
# File
rustc --print=sysroot
cargo rustc --release -- -C prefer-dynamic
export LD_LIBRARY_PATH+=:$(rustc --print=sysroot)/lib

# Wasm

```rust
// A macro to provide `println!(..)`-style syntax for `console.log` logging.
#[macro_export]
macro_rules! log {
    ( $( $t:tt )* ) => {
        web_sys::console::log_1(&format!( $( $t )* ).into());
    }
}
```




* strictly enforcing safe borrowing of data
* functions, methods and closures to operate on data
* tuples, structs and enums to aggregate data
* pattern matching to select and destructure data
* traits to define behaviour on data
