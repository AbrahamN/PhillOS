#ifndef VGA_TEXT_H
#define VGA_TEXT_H
#include "../utilities/TypeDefinition.h"
void SetCursorPosRaw(ShortPositiveType pos);
void SetCursorPos(int x, int y);
//ShortPositiveType GetCursorPos();
//void disable_cursor();
//void enable_cursor(ByteType cursor_start, ByteType cursor_end);
void kprint(const char* s);
void kprintChar(const char c, bool caps);
void MoveCursorLR(int i);
void MoveCursorUD(int i);
void ClearScreen(int col);
void ColLine(int line, int col);
void kprintCol(const char* s, int col);
void printError(const char* s);
void ClrLine(int line);
void ColScreen(int col);
void scrollPageUp();
#endif
