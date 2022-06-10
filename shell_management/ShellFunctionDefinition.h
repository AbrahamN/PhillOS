#ifndef SHELLFUNCTION_DEFINITION_H
#define SHELLFUNCTION_DEFINITION_H

#include "../utilities/TypeDefinition.h"

typedef struct ShellFunction{
    void (*fptr)(const char *);
    char* alias;
    char* help;
};

ShellFunction* TryGetCMD(char* cmdbuf);
int GetCMDLength();

#endif
