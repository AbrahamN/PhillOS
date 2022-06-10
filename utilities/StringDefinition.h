
#ifndef STRING_DEFINITION_H
#define STRING_DEFINITION_H

#include "../utilities/TypeDefinition.h"

StringType StringReverse(StringType str, char* buffer, int len);
int StringLength(StringType s);
bool StringsAreEqual(StringType s, StringType t);
bool StringStartsWith(StringType s, StringType t);
int StringFindCharacterIndex(StringType s, char c);
StringType StringTrimFromStart(StringType s, int n);

#endif
