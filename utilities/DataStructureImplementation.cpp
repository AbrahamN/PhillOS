#include "../utilities/DataStructureDefinition.h"
#include "../memory_management/MemoryDefinition.h"
#include "../Drivers/VGA_Text.h"


/************************************ LINKED LIST ******************************************/
struct LinkedList* LinkedListCreate()
{
    struct LinkedList* nList = (struct LinkedList*)kmalloc(sizeof(struct LinkedList));
    nList -> head = (struct Node*)kmalloc(sizeof(struct Node));
    nList -> head -> val = 0;
    return nList;
}

void LinkedListAdd(struct LinkedList* list, int val)
{
    struct Node* nNode = (struct Node*)kmalloc(sizeof(struct Node));
    nNode -> val = val;
    if(list -> head -> next)
        nNode -> next = list -> head -> next;
    nNode -> next = list -> head;
    list -> head = nNode;
}

void LinkedListPrint(LinkedList* list)
{
    struct Node* tmp = (struct Node*)kmalloc(sizeof(struct Node));
    tmp = list -> head;
    while(tmp -> next)
    {
        kprintChar(tmp -> val, 0);
        tmp = tmp -> next;
    }
    kprintChar(tmp -> val, 0);
    memcut(sizeof(struct Node));    //removing temporary node
    return;
}


/************************************ QUEUE ******************************************/
struct LinkedListQueue* LinkedListQueueCreate()
{
    struct LinkedListQueue* nQueue = (struct LinkedListQueue*)kmalloc(sizeof(struct LinkedListQueue));
    struct LinkedList* list = LinkedListCreate();
    nQueue->list = list;
    return nQueue;
}

void LinkedListQueueEnqueue (LinkedListQueue* queue, int k)
{
    if(queue->tail) 
    {
        struct Node* nNode = (struct Node*)kmalloc(sizeof(struct Node));
        nNode -> val = k;
        queue->tail->next = nNode;
        queue->tail = nNode;
    }
    else
    {   // first enqueue
        LinkedListAdd(queue->list, k);
        queue -> tail = queue->list->head;
        queue -> head = queue->list->head;
    }
}

void LinkedListQueueDequeue (LinkedListQueue* queue)
{
    if(queue->head)
    {
        queue->head = queue->head->next;
    }
}

int LinkedListQueueFirst (LinkedListQueue* queue)
{
    return queue->head->val;
}

int LinkedListQueueLast (LinkedListQueue* queue)
{
    return queue->tail->val;
}
