//
//  main.c
//  MacroCCC
//
//  Created by zz on 2019/1/2.
//  Copyright © 2019 zz. All rights reserved.
//

#include <stdio.h>

#define ROUTER_PRE routerHandle
#define __ROUTER_INITIALIZE_SEL(A) A ## _ ## initialize
#define _ROUTER_INITIALIZE_SEL(A) __ROUTER_INITIALIZE_SEL(A)
#define ROUTER_INITIALIZE_SEL _ROUTER_INITIALIZE_SEL(ROUTER_PRE)

int main(int argc, const char * argv[]) {
    int ROUTER_INITIALIZE_SEL = 1;
    
    printf("Hello, World!\n");
    return 0;
}
