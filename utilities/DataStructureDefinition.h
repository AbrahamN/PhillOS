#ifndef DATASTRUCTURE_DEFINITION_H
#define DATASTRUCTURE_DEFINITION_H

#include "../utilities/TypeDefinition.h"

struct Node {
    int val;
    struct Node* next;
    
}__attribute__((packed));

struct LinkedList {
    struct Node* head;
    
}__attribute__((packed));

struct LinkedListQueue {
    struct LinkedList* list;
    struct Node* head;
    struct Node* tail;
    
}__attribute__((packed));

struct LinkedList* LinkedListCreate();
void LinkedListAdd(struct LinkedList* myList, int val);
void LinkedListPrint(LinkedList* list);

struct LinkedListQueue* LinkedListQueueCreate();
void LinkedListQueueEnqueue (LinkedListQueue* queue, int k);
void LinkedListQueueDequeue (LinkedListQueue* queue);
int LinkedListQueueFirst (LinkedListQueue* queue);
int LinkedListQueueLast (LinkedListQueue* queue);
#endif
