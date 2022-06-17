export PATH=$PATH:/usr/local/i386elfgcc/bin

drivers_path="Drivers"
utilities_path="Utils"
cpu_path="CPU"
kernel_path="Kernel"
shell_path="Shell"
misceallaneous_path="Misc"
memory_path="Memory"

build_path="WeeBins"
bootloader_path="Bootloader"

echo Boot:
nasm "$bootloader_path/boot.asm" -f bin -o "$build_path/boot.bin" -i $bootloader_path
nasm "$kernel_path/empty_end.asm" -f bin -o "$build_path/empty_end.bin"

echo $kernel_path:
i386-elf-gcc -ffreestanding -m32 -g -c "$kernel_path/kernel.cpp" -o "$build_path/kernel.o" -I $kernel_path
nasm "$kernel_path/kernel_entry.asm" -f elf -o "$build_path/kernel_entry.o" -i $kernel_path

echo $drivers_path + $utilities_path:
i386-elf-gcc -ffreestanding -m32 -g -c "$drivers_path/port_io.cpp" -o "$build_path/$drivers_path/port_io.o" -I $drivers_path
i386-elf-gcc -ffreestanding -m32 -g -c "$drivers_path/VGA_Text.cpp" -o "$build_path/$drivers_path/VGA_Text.o" -I $drivers_path
i386-elf-gcc -ffreestanding -m32 -g -c "$drivers_path/Keyboard.cpp" -o "$build_path/$drivers_path/Keyboard.o" -I $drivers_path
i386-elf-gcc -ffreestanding -m32 -g -c "$drivers_path/Floppy.cpp" -o "$build_path/$drivers_path/Floppy.o" -I $drivers_path

i386-elf-gcc -ffreestanding -m32 -g -c "$utilities_path/Conversions.cpp" -o "$build_path/$utilities_path/Conversions.o" -I $utilities_path
i386-elf-gcc -ffreestanding -m32 -g -c "$utilities_path/string.cpp" -o "$build_path/$utilities_path/string.o" -I $utilities_path
i386-elf-gcc -ffreestanding -m32 -g -c "$utilities_path/dataStructures.cpp" -o "$build_path/$utilities_path/dataStructures.o" -I $utilities_path
echo $cpu_path:
echo ----GDT:
i386-elf-gcc -ffreestanding -m32 -g -c "$cpu_path/GDT/gdt.cpp" -o "$build_path/$cpu_path/gdt.o" -I GDT
nasm "$cpu_path/GDT/gdt_loader.asm" -f elf -o "$build_path/$cpu_path/gdt_loader.o"
echo ----Interrupts:
i386-elf-gcc -ffreestanding -m32 -g -c "$cpu_path/Interrupts/idt.cpp" -o "$build_path/$cpu_path/idt.o"
i386-elf-gcc -ffreestanding -m32 -g -c "$cpu_path/Interrupts/isr.cpp" -o "$build_path/$cpu_path/isr.o" -I Interrupts
i386-elf-gcc -ffreestanding -m32 -g -c "$cpu_path/Interrupts/irq.cpp" -o "$build_path/$cpu_path/irq.o" -I Interrupts
echo ----Timer:
i386-elf-gcc -ffreestanding -m32 -g -c "$cpu_path/Timer/timer.cpp" -o "$build_path/$cpu_path/timer.o" -I Timer

echo MEMORY:
i386-elf-gcc -ffreestanding -m32 -g -c "$memory_path/mem.cpp" -o "$build_path/$memory_path/mem.o" -I $memory_path 

echo MISC:
i386-elf-gcc -ffreestanding -m32 -g -c "$misceallaneous_path/CmdMode.cpp" -o "$build_path/$misceallaneous_path/CmdMode.o" -I $misceallaneous_path
i386-elf-gcc -ffreestanding -m32 -g -c "$misceallaneous_path/CodeMode.cpp" -o "$build_path/$misceallaneous_path/CodeMode.o" -I $misceallaneous_path

echo SHELL:
i386-elf-gcc -ffreestanding -m32 -g -c "$shell_path/shell.cpp" -o "$build_path/$shell_path/shell.o" -I $shell_path
i386-elf-gcc -ffreestanding -m32 -g -c "$shell_path/shellFunctions.cpp" -o "$build_path/$shell_path/shellFunctions.o" -I $shell_path 

echo SHELL Functions:
i386-elf-gcc -ffreestanding -m32 -g -c "$shell_path/functions/text.cpp" -o "$build_path/$shell_path/functions/text.o" -I "$shell_path/functions"
i386-elf-gcc -ffreestanding -m32 -g -c "$shell_path/functions/memory.cpp" -o "$build_path/$shell_path/functions/memory.o" -I "$shell_path/functions"
i386-elf-gcc -ffreestanding -m32 -g -c "$shell_path/functions/floppy.cpp" -o "$build_path/$shell_path/functions/floppy.o" -I "$shell_path/functions"
i386-elf-gcc -ffreestanding -m32 -g -c "$shell_path/functions/misc.cpp" -o "$build_path/$shell_path/functions/misc.o" -I "$shell_path/functions"
i386-elf-gcc -ffreestanding -m32 -g -c "$shell_path/functions/calculator.cpp" -o "$build_path/$shell_path/functions/calculator.o" -I "$shell_path/functions"

echo Linking:
i386-elf-ld \
    -o "$build_path/kernel.bin" \
    -Ttext 0x1000 -e main \
    "$build_path/kernel_entry.o" "$build_path/kernel.o" \
    "$build_path/$drivers_path/VGA_Text.o" \
    "$build_path/$drivers_path/port_io.o" \
    "$build_path/$drivers_path/Keyboard.o" \
    "$build_path/$drivers_path/Floppy.o" \
    "$build_path/$memory_path/mem.o" \
    "$build_path/$cpu_path/idt.o" \
    "$build_path/$cpu_path/isr.o" \
    "$build_path/$cpu_path/irq.o" \
    "$build_path/$cpu_path/timer.o" \
    "$build_path/$cpu_path/gdt.o" \
    "$build_path/$cpu_path/gdt_loader.o" \
    "$build_path/$misceallaneous_path/CmdMode.o" \
    "$build_path/$misceallaneous_path/CodeMode.o" \
    "$build_path/$utilities_path/string.o" \
    "$build_path/$utilities_path/Conversions.o" \
    "$build_path/$utilities_path/dataStructures.o" \
    "$build_path/$shell_path/shell.o" \
    "$build_path/$shell_path/shellFunctions.o" \
    "$build_path/$shell_path/functions/text.o" \
    "$build_path/$shell_path/functions/memory.o" \
    "$build_path/$shell_path/functions/floppy.o" \
    "$build_path/$shell_path/functions/misc.o" \
    "$build_path/$shell_path/functions/calculator.o" \
    --oformat binary


cat "$build_path/boot.bin" "$build_path/kernel.bin" > "$build_path/short.bin"
cat "$build_path/short.bin" "$build_path/empty_end.bin" > os_image.bin



#qemu-system-x86_64 -s -S -drive format=raw,file=os_image.bin,index=0,if=floppy		# GDB
qemu-system-x86_64 -drive format=raw,file=os_image.bin,index=0,if=floppy,  -m 128M			# RUN EMULATOR