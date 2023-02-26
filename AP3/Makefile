# target ... : prerequisites ...
# 			command to generate target
# 

# 1. create a all-zero file with blocksize=512 and 1440KB
# 2. write boot.bin into the file skip 0 (seek attribute) blocks
myos.img : AP3.bin
	dd if=/dev/zero of=myos.img bs=1024 count=2880 &&\
	dd if=AP3.bin of=myos.img seek=0 count=1 conv=notrunc

AP3.bin : AP3.asm
	nasm -f bin -o AP3.bin AP3.asm

run : myos.img
	qemu-system-x86_64 -fda myos.img

.PHONY : clean # .PHONY means clean is not a file or an object
clean: 
	rm *.bin *.img 