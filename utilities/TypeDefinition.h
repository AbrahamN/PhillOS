#ifndef TYPE_DEFINITION_H
#define TYPE_DEFINITION_H

typedef unsigned char ByteType;
typedef unsigned short ShortPositiveType;
typedef unsigned int IntPositiveType;
typedef const char* StringType;

#define RightMost16Bits(address) (ShortPositiveType)((address) & 0xFFFF)
#define LeftMost16Bits(address) (ShortPositiveType)(((address) >> 16) & 0xFFFF)
#define RightMost8Bits(address) (ByteType)((address) &  0xFF)
#define LeftMost8Bits(address) (ByteType)(((address) >> 8) & 0xFF)

#endif
