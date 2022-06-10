#include "../memory_management/MemoryDefinition.h"
#include "../utilities/StringDefinition.h"
#include "../utilities/ConvertDefinition.h"

#include "../Drivers/VGA_Text.h"
#include "../Drivers/Floppy.h"

#include "../Shell/ShellFunctionDefinition.h"

#include "./functions/functions.h"

extern StringType currentTask;

extern ShortPositiveType CursorPos;

static const char *  const helpList[5] = {                  // find better (dynamic) way
    "  help: shows command list\n",
    "  echo [text]: prints text\n",
    "  usedmem: shows dynamic memory usage\n",
    "  floppy:\n         list: shows list of connected floppy drives\n         []: shows floppy help\n",
    "  clear: clears the screen\n"
    
};

// Bind this to CMDs and use the help texts for each command (that's the better way ^)
void helpCMD(StringType s){
    if(StringLength(s) == 0){
        currentTask = "help";
        kprint("List of commands:\n");
        for(int i = 0; i < sizeof(helpList)/sizeof(char*); i++)
            kprint(helpList[i]);
    }
    else{
        kprint("Invalid option: \"");
        if(s[0] == ' ') kprint((StringType)((int)s + 1));
        else kprint(s);
        kprint("\"");
    }
   
}

ShellFunction shellf(void (*Fptr)(const char *), char* Alias, char* Help){
    ShellFunction f;
    f.fptr = Fptr;
    kprint("<<");
    kprint(Alias);
    kprint(">>");
    f.alias = Alias;
    kprint("[[");
    kprint(f.alias);
    kprint("]]");
    f.help = Help;
    return f;
}

#define CMDENTRY(fptr, alias, help) {   \
    fptr,                               \
    alias,                              \
    help                                \
}

ShellFunction CMDs[] = {
    CMDENTRY(&helpCMD,  "help",     "Shows command list"),
    CMDENTRY(&echo,     "echo",     "Prints text"),
    CMDENTRY(&usedmem,  "usedmem",  "Shows dynamic memory usage"),
    CMDENTRY(&floppy,   "floppy",   "Shows list of connected floppy drives"),
    CMDENTRY(&clear,    "clear",    "Clears the screen"),
    CMDENTRY(&hcf,      "hcf",      "Crashes your system")
};

ShellFunction* TryGetCMD(char* cmdbuf){
    for(int x = 0; x < sizeof(CMDs)/sizeof(ShellFunction); x++){
        if(StringStartsWith(cmdbuf, CMDs[x].alias)){
            return &CMDs[x];
        }
    }
    return 0;
}
