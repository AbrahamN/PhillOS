#ifndef PORT_IO_H
#define PORT_IO_H
void outb(ShortPositiveType port, ByteType data);
void outw(ShortPositiveType port, ShortPositiveType value);
void outl(ShortPositiveType port, IntPositiveType value);
ByteType inb(ShortPositiveType port);
ShortPositiveType inw(ShortPositiveType port);
IntPositiveType inl(ShortPositiveType port);
#endif
