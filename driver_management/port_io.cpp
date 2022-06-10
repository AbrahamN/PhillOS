#include "../Utils/Typedefs.h"
/**************** SEND/RECEIVE BYTE ******************/
void outb(ShortPositiveType port, ByteType data){
	asm volatile("outb %0, %1" : : "a"(data), "Nd"(port));
	return;
}

ByteType inb(ShortPositiveType port){
	ByteType res;
	asm volatile("inb %1, %0" : "=a"(res) : "Nd"(port));
	return res;
}

/**************** SEND/RECEIVE WORD ******************/

void outw(ShortPositiveType port, ShortPositiveType value)
{
	asm volatile ("outw %w0, %1" : : "a" (value), "id" (port) );
}

ShortPositiveType inw(ShortPositiveType port){
   ShortPositiveType ret;
   asm volatile ("inw %1, %0" : "=a" (ret) : "dN" (port));
   return ret;
} 

/**************** SEND/RECEIVE LONG (32-BIT) ******************/

void outl(ShortPositiveType port, IntPositiveType value){
	asm volatile ("outl %%eax, %%dx" :: "d" (port), "a" (value));
}

IntPositiveType inl(ShortPositiveType port){
   IntPositiveType ret;
   asm volatile ("inl %1, %0" : "=a" (ret) : "dN" (port));
   return ret;
} 
