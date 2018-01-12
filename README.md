bootloader
===========

A simple bootloader that runs on qemu-system-i386.

From the project at https://tuhdo.github.io/os01/

    make
    make qemu


Start gdb

    (gdb) set architecture i8086
    (gdb) target remote localhost:26000
    (gdb) b *0x7c00
    (gdb) layout asm
    (gdb) layout reg
    (gdb) c

Use `stepi` to step through the bootloader.
