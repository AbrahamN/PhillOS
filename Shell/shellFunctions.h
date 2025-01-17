#ifndef SHELLFUNCTIONS_H
#define SHELLFUNCTIONS_H

#include "../Utils/Typedefs.h"

typedef struct shellfunction{
    void (*fptr)(const char *);
    char* alias;
    char* help;
};

shellfunction* TryGetCMD(char* cmdbuf);
int GetCMDLength();

#endif
