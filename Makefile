NASM = nasm

all: disk.img

bootloader.o: bootloader.s
	$(NASM) -f elf32 -g3 -F dwarf $< -o $@

bootloader.elf: bootloader.o
	ld -Ttext=0x7c00 -melf_i386 $< -o $@

disk.img : bootloader.elf
	objcopy -O binary bootloader.elf temp.img
	dd if=/dev/zero of=$@ bs=512 count=2800
	dd conv=notrunc if=temp.img of=$@ bs=512 count=1 seek=0
	rm temp.img

clean:
	rm -f *.o
	rm -f bootloader
	rm -f bootloader.elf
	rm -f disk.img

# Runs qemu with the disk image
qemu: disk.img 
	qemu-system-i386 -fda disk.img -gdb tcp::26000

# Runs qemu with the disk image but waits for a remote gdb connection
qemu-dbg: disk.img 
	@echo "Run 'gdb -ix gdb-settings.txt bootloader.elf' to debug"
	qemu-system-i386 -fda disk.img -s -S


