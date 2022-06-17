#include "../../Drivers/VGA_Text.h"
//#include "text.h"
#include "../../Utils/string.h"

#define FDEF(name) void name(const char* s)

extern uint16_t CursorPos;

FDEF (calculator){
    kprint("Starting calculator");
    const char* arguments = s;
    int index = 0;
    
    kprint("you entered these details: ");
    kprint(arguments);
    kprint("\nIndividual values: ");
    // while(*arguments != 0){
    //     //const char* arg = &arguments[index];
    //     kprintChar(arguments[index], false);
    //     index++;
    // }
    while (strLen(arguments) > index){
        kprintChar(arguments[index], false);
        index++;
    }
    
    for (int i = 0; i < 10; i++)
    {
        kprintCol("aaa\n", i);
        scrollPageUp();
        ColScreen(i);
    }
    
}