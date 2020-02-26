#########################
# Makefile for NanoOS #
#########################

ENTRYPOINT	= 0x1000

ENTRYOFNafsET	=   0x400

ASM		= nasm
DASM		= objdump
CC		= gcc
LD		= ld
ASMBFLAGS	= -I boot/include/
ASMKFLAGS	= -I include/ -I include/sys/ -f elf
CFLAGS		= -I include/ -I include/sys/ -m32 -c -fno-builtin -Wall -fno-stack-protector
#CFLAGS		= -I include/ -c -fno-builtin -fno-stack-protector -fpack-struct -Wall
LDFLAGS		= -m elf_i386 -s -Ttext $(ENTRYPOINT) -Map krnl.map
DASMFLAGS	= -D
ARFLAGS		= rcs

# This Program
NANOBOOT	= boot/boot.bin boot/loader.bin
NANOCOREKernel	= kernel.bin
LIB		= lib/NDKcore.a

OBJS		= NanoCore/kernel.o NanoCore/start.o NanoCore/main.o\
			NanoCore/clock.o NanoCore/keyboard.o NanoCore/tty.o NanoCore/console.o\
			NanoCore/i8259.o NanoCore/global.o NanoCore/protect.o NanoCore/proc.o\
			NanoCore/systask.o NanoCore/hd.o\
			NanoCore/kliba.o NanoCore/klib.o\
			lib/syslog.o\
			mm/main.o mm/forkexit.o mm/exec.o\
			Nafs/main.o Nafs/open.o Nafs/misc.o Nafs/read_write.o\
			Nafs/link.o\
			Nafs/disklog.o\
			lib/color.o
LOBJS		=  lib/syscall.o\
			lib/printf.o lib/vsprintf.o\
			lib/string.o lib/misc.o\
			lib/open.o lib/read.o lib/write.o lib/close.o lib/unlink.o\
			lib/getpid.o lib/stat.o\
			lib/fork.o lib/exit.o lib/wait.o lib/exec.o\
			lib/color.o\

DASMOUTPUT	= kernel.bin.asm

# All Phony Targets
.PHONY : everything final image clean realclean disasm all buildimg

# Default starting position
nop :
	@echo "why not \`make image' huh? :)"

everything : $(NANOBOOT) $(NANOCOREKernel)

all : realclean everything

image : realclean everything clean buildimg

clean :
	rm -f $(OBJS) $(LOBJS)

realclean :
	rm -f $(OBJS) $(LOBJS) $(LIB) $(NANOBOOT) $(NANOCOREKernel)

disasm :
	$(DASM) $(DASMFLAGS) $(NANOCOREKernel) > $(DASMOUTPUT)

# We assume that "a.img" exists in current folder
buildimg :
	dd if=boot/boot.bin of=a.img bs=512 count=1 conv=notrunc
	sudo mount -o loop a.img /mnt/floppy/
	sudo cp -fv boot/loader.bin /mnt/floppy/
	sudo cp -fv NanoCore.bin /mnt/floppy
	sudo umount /mnt/floppy

boot/boot.bin : boot/boot.asm boot/include/load.inc boot/include/fat12hdr.inc
	$(ASM) $(ASMBFLAGS) -o $@ $<

boot/loader.bin : boot/loader.asm boot/include/load.inc boot/include/fat12hdr.inc boot/include/pm.inc
	$(ASM) $(ASMBFLAGS) -o $@ $<

$(NANOCOREKernel) : $(OBJS) $(LIB)
	$(LD) $(LDFLAGS) -o $(NANOCOREKernel) $^

$(LIB) : $(LOBJS)
	$(AR) $(ARFLAGS) $@ $^

NanoCore/kernel.o : NanoCore/kernel.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<

lib/syscall.o : lib/syscall.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<

NanoCore/start.o: NanoCore/start.c
	$(CC) $(CFLAGS) -o $@ $<

NanoCore/main.o: NanoCore/main.c
	$(CC) $(CFLAGS) -o $@ $<

NanoCore/clock.o: NanoCore/clock.c
	$(CC) $(CFLAGS) -o $@ $<

NanoCore/keyboard.o: NanoCore/keyboard.c
	$(CC) $(CFLAGS) -o $@ $<

NanoCore/tty.o: NanoCore/tty.c
	$(CC) $(CFLAGS) -o $@ $<

NanoCore/console.o: NanoCore/console.c
	$(CC) $(CFLAGS) -o $@ $<

NanoCore/i8259.o: NanoCore/i8259.c
	$(CC) $(CFLAGS) -o $@ $<

NanoCore/global.o: NanoCore/global.c
	$(CC) $(CFLAGS) -o $@ $<

NanoCore/protect.o: NanoCore/protect.c
	$(CC) $(CFLAGS) -o $@ $<

NanoCore/proc.o: NanoCore/proc.c
	$(CC) $(CFLAGS) -o $@ $<

lib/printf.o: lib/printf.c
	$(CC) $(CFLAGS) -o $@ $<

lib/vsprintf.o: lib/vsprintf.c
	$(CC) $(CFLAGS) -o $@ $<

NanoCore/systask.o: NanoCore/systask.c
	$(CC) $(CFLAGS) -o $@ $<

NanoCore/hd.o: NanoCore/hd.c
	$(CC) $(CFLAGS) -o $@ $<

NanoCore/klib.o: NanoCore/klib.c
	$(CC) $(CFLAGS) -o $@ $<

lib/misc.o: lib/misc.c
	$(CC) $(CFLAGS) -o $@ $<

NanoCore/kliba.o : NanoCore/kliba.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<

lib/string.o : lib/string.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<

lib/open.o: lib/open.c
	$(CC) $(CFLAGS) -o $@ $<

lib/read.o: lib/read.c
	$(CC) $(CFLAGS) -o $@ $<

lib/write.o: lib/write.c
	$(CC) $(CFLAGS) -o $@ $<

lib/close.o: lib/close.c
	$(CC) $(CFLAGS) -o $@ $<

lib/unlink.o: lib/unlink.c
	$(CC) $(CFLAGS) -o $@ $<

lib/getpid.o: lib/getpid.c
	$(CC) $(CFLAGS) -o $@ $<

lib/syslog.o: lib/syslog.c
	$(CC) $(CFLAGS) -o $@ $<

lib/fork.o: lib/fork.c
	$(CC) $(CFLAGS) -o $@ $<

lib/exit.o: lib/exit.c
	$(CC) $(CFLAGS) -o $@ $<

lib/wait.o: lib/wait.c
	$(CC) $(CFLAGS) -o $@ $<

lib/exec.o: lib/exec.c
	$(CC) $(CFLAGS) -o $@ $<

lib/stat.o: lib/stat.c
	$(CC) $(CFLAGS) -o $@ $<

mm/main.o: mm/main.c
	$(CC) $(CFLAGS) -o $@ $<

mm/forkexit.o: mm/forkexit.c
	$(CC) $(CFLAGS) -o $@ $<

mm/exec.o: mm/exec.c
	$(CC) $(CFLAGS) -o $@ $<

Nafs/main.o: Nafs/main.c
	$(CC) $(CFLAGS) -o $@ $<

Nafs/open.o: Nafs/open.c
	$(CC) $(CFLAGS) -o $@ $<

Nafs/read_write.o: Nafs/read_write.c
	$(CC) $(CFLAGS) -o $@ $<

Nafs/link.o: Nafs/link.c
	$(CC) $(CFLAGS) -o $@ $<

Nafs/disklog.o: Nafs/disklog.c
	$(CC) $(CFLAGS) -o $@ $<

lib/color.o: lib/color.c
	$(CC) $(CFLAGS) -o $@ $<