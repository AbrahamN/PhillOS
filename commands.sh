export PATH=$PATH:/usr/local/i386elfgcc/bin
echo Boot:
nasm "Bootloader/boot.asm" -f bin -o "phillos_binary/boot.bin" -i Bootloader
nasm "kernel_management/empty_end.asm" -f bin -o "phillos_binary/empty_end.bin"

echo Kernel:
i386-elf-gcc -ffreestanding -m32 -g -c "kernel_management/KernelImplementation.cpp" -o "phillos_binary/kernel.o" -I Kernel
nasm "kernel_management/kernel_entry.asm" -f elf -o "phillos_binary/kernel_entry.o" -i Kernel

echo Drivers + Utils:
i386-elf-gcc -ffreestanding -m32 -g -c "driver_management/port_io.cpp" -o "phillos_binary/driver_management/port_io.o" -I Drivers
i386-elf-gcc -ffreestanding -m32 -g -c "driver_management/VGA_Text.cpp" -o "phillos_binary/driver_management/vga_text.o" -I Drivers
i386-elf-gcc -ffreestanding -m32 -g -c "driver_management/Keyboard.cpp" -o "phillos_binary/driver_management/keyboard.o" -I Drivers
i386-elf-gcc -ffreestanding -m32 -g -c "driver_management/Floppy.cpp" -o "phillos_binary/driver_management/floppy.o" -I Drivers

i386-elf-gcc -ffreestanding -m32 -g -c "utilities/ConvertImplementation.cpp" -o "phillos_binary/utilities/convert.o" -I Utils
i386-elf-gcc -ffreestanding -m32 -g -c "utilities/StringImplementation.cpp" -o "phillos_binary/utilities/string.o" -I Utils
i386-elf-gcc -ffreestanding -m32 -g -c "utilities/DataStructureImplementation.cpp" -o "phillos_binary/utilities/datastructure.o" -I Utils
echo CPU:
echo ----GDT:
i386-elf-gcc -ffreestanding -m32 -g -c "cpu_management/GDT/gdt.cpp" -o "phillos_binary/cpu_management/gdt.o" -I GDT
nasm "cpu_management/GDT/gdt_loader.asm" -f elf -o "phillos_binary/cpu_management/gdt_loader.o"
echo ----Interrupts:
i386-elf-gcc -ffreestanding -m32 -g -c "cpu_management/Interrupts/idt.cpp" -o "phillos_binary/cpu_management/idt.o"
i386-elf-gcc -ffreestanding -m32 -g -c "cpu_management/Interrupts/isr.cpp" -o "phillos_binary/cpu_management/isr.o" -I Interrupts
i386-elf-gcc -ffreestanding -m32 -g -c "cpu_management/Interrupts/irq.cpp" -o "phillos_binary/cpu_management/irq.o" -I Interrupts
echo ----Timer:
i386-elf-gcc -ffreestanding -m32 -g -c "cpu_management/Timer/timer.cpp" -o "phillos_binary/cpu_management/timer.o" -I Timer

echo MEMORY:
i386-elf-gcc -ffreestanding -m32 -g -c "memory_management/MemoryImplementation.cpp" -o "phillos_binary/memory_management/memory.o"

echo MISC:
i386-elf-gcc -ffreestanding -m32 -g -c "Misc/CmdMode.cpp" -o "phillos_binary/Misc/CmdMode.o" -I Misc
i386-elf-gcc -ffreestanding -m32 -g -c "Misc/CodeMode.cpp" -o "phillos_binary/Misc/CodeMode.o" -I Misc

echo SHELL:
i386-elf-gcc -ffreestanding -m32 -g -c "shell_management/shell.cpp" -o "phillos_binary/shell_management/shell.o" -I Shell
i386-elf-gcc -ffreestanding -m32 -g -c "shell_management/ShellFunctionImplementation.cpp" -o "phillos_binary/shell_management/shellfunction.o" -I Shell

echo Linking:
i386-elf-ld -o "phillos_binary/kernel.bin" -Ttext 0x1000 "phillos_binary/kernel_entry.o" "phillos_binary/kernel.o" "phillos_binary/driver_management/vga_text.o" "phillos_binary/driver_management/port_io.o" "phillos_binary/utilities/convert.o" "phillos_binary/memory_management/memory.o" "phillos_binary/cpu_management/idt.o" "phillos_binary/cpu_management/isr.o" "phillos_binary/cpu_management/irq.o" "phillos_binary/cpu_management/timer.o" "phillos_binary/driver_management/keyboard.o" "phillos_binary/Misc/CmdMode.o" "phillos_binary/utilities/string.o" "phillos_binary/Misc/CodeMode.o" "phillos_binary/utilities/dataStructures.o" "phillos_binary/shell_management/shell.o" "phillos_binary/driver_management/Floppy.o" "phillos_binary/shell_management/shellfunction.o" "phillos_binary/cpu_management/gdt_loader.o" "phillos_binary/cpu_management/gdt.o" --oformat binary


cat "phillos_binary/boot.bin" "phillos_binary/kernel.bin" > "phillos_binary/short.bin"
cat "phillos_binary/short.bin" "phillos_binary/empty_end.bin" > os_image.bin



#qemu-system-x86_64 -s -S -drive format=raw,file=os_image.bin,index=0,if=floppy		# GDB
qemu-system-x86_64 -drive format=raw,file=os_image.bin,index=0,if=floppy,  -m 128M			# RUN EMULATOR