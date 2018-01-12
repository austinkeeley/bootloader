NASM = nasm

all: disk.img

bootloader: bootloader.s
	$(NASM) -f bin $< -o $@

disk.img : bootloader
	dd if=/dev/zero of=$@ bs=512 count=2800
	dd conv=notrunc if=bootloader of=disk.img bs=512 count=1 seek=0

clean: 
	rm -f bootloader
	rm -f disk.img

qemu: disk.img 
	qemu-system-i386 -fda disk.img -gdb tcp::26000 -S


