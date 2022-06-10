#ifndef CONVERT_DEFINITION_H
#define CONVERT_DEFINITION_H

#include "../utilities/TypeDefinition.h"

StringType ConvertToString(int n, int base);
int OctalToBinary(unsigned char *str, int size);
int HexToBinary(unsigned char *str, int size);

#endif
