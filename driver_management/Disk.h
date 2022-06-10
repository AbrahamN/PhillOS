#pragma once
#include "../utilities/TypeDefinition.h"
#include "./port_io.h"
#include "../CPU/Timer/timer.h"
#include "VGA_Text.h"
#include "../utilities/ConvertDefinition.h"

void lba28_read_sector(IntPositiveType block, IntPositiveType LBA, ByteType drive);
void lba28_write_sector(ByteType drive, IntPositiveType LBA, IntPositiveType* buffer);