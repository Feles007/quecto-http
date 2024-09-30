# quecto-http
A single HTTP response at the speed of syscalls!

One NASM file that listens for connections and sends back an embedded HTTP response.

Currently, it's mostly just a test. More optimizations are possible:
* Remove the unnecessary exit, it loops forever
* Custom linker script
* Strip the executable
* Manually construct the ELF file
