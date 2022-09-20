#include <stdio.h>

extern int func(void);

int main(void)
{
    puts("Hello, world!");
    return func();
}
