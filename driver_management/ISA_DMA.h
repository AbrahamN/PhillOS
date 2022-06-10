#ifndef ISA_DMA
#define ISA_DMA

#include "../utilities/TypeDefinition.h"

void maskChannel(ByteType channel, int masked);
void initFloppyDMA(IntPositiveType address);
void prepare_for_floppyDMA_write();


#endif
