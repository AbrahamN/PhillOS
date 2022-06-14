#ifndef SHELLFUNCTIONS_H
#define SHELLFUNCTIONS_H

#include "../Utils/Typedefs.h"

struct shellfunction{
    void (*fptr)(const char *);
    const char* alias;
    const char* help;
};

shellfunction* TryGetCMD(char* cmdbuf);
int GetCMDLength();

#endif
