bootloader
===========

A simple bootloader that runs on qemu-system-i386, inspired from
the project  https://tuhdo.github.io/os01/

Building and running:

    make
    make qemu


To debug:

    make qemu-dbg   # QEMU will pause and wait for the debugger to attach
    gdb -ix gdb-settings.txt bootloader.elf


