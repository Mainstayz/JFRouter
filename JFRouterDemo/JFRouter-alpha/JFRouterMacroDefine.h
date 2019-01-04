//
//  JFRouterMacroDefine.h
//  JFRouterDemo
//
//  Created by zz on 2019/1/3.
//  Copyright © 2019 zz. All rights reserved.
//

#define _SEL_MACRO(A) @selector(A)
#define _CONCAT_(A, B) A ## B

#define SEL_MACRO(A) \
        _SEL_MACRO(A)
#define CONCAT(A, B) \
        _CONCAT_(A, B)

#define ROUTER_PRE routerHandle
#define ROUTER_INITIALIZE initialize:
#define ROUTER_PRE_OC @"routerHandle"

// routerHandle_initialize
#define ROUTER_INITIALIZE_NAME CONCAT(CONCAT(ROUTER_PRE,_),ROUTER_INITIALIZE)

// @selector(routerHandle_initialize:)
#define ROUTER_INITIALIZE_SEL SEL_MACRO(ROUTER_INITIALIZE_NAME)

// initialize OC version
#define _ROUTER_INITIALIZE_METHOD(A, B) \
        + (instancetype)A(nullable NSDictionary *)B
#define ROUTER_INITIALIZE_METHOD(arg) _ROUTER_INITIALIZE_METHOD(ROUTER_INITIALIZE_NAME,arg)

// sync method - OC version
#define __ROUTER_SYNC_METHOD(return_type, pre, name, arg) \
        + (return_type)pre ## _ ## name:(nullable NSDictionary *)arg
#define _ROUTER_SYNC_METHOD(return_type, pre, name, arg) __ROUTER_SYNC_METHOD(return_type,pre,name,arg)
#define ROUTER_SYNC_METHOD(return_type, name, arg) _ROUTER_SYNC_METHOD(return_type,ROUTER_PRE,name,arg)

// aync method - OC version
#define __ROUTER_ASYNC_METHOD(pre, name, arg) \
        + (void) pre ## _ ## name:(NSDictionary *)arg callback:(nullable void(^)(id value))callback
#define _ROUTER_ASYNC_METHOD(pre, name, arg) __ROUTER_ASYNC_METHOD(pre,name,arg)
#define ROUTER_ASYNC_METHOD(name, arg) _ROUTER_ASYNC_METHOD(ROUTER_PRE,name,arg)

#define ROUTER_SCHEME \
        + (nonnull NSString *)scheme

#define ROUTER_CUSTOM_HOST \
        + (nonnull NSString *)customHost

