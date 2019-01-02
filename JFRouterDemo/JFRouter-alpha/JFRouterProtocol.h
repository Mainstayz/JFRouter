//
//  RouterProtocol.h
//  RouterDemo
//
//  Created by zz on 2019/1/2.
//  Copyright © 2019 zz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// sel
#define _SEL_MACRO(A) @selector(A)
#define SEL_MACRO(A) _SEL_MACRO(A)

#define ROUTER_PRE routerHandle
#define ROUTER_PRE_OC @"routerHandle"

#define __ROUTER_INITIALIZE_NAME(A) A ## _ ## initialize:
#define _ROUTER_INITIALIZE_NAME(A) __ROUTER_INITIALIZE_NAME(A)

// routerHandle_initialize:
#define ROUTER_INITIALIZE_NAME _ROUTER_INITIALIZE_NAME(ROUTER_PRE)
// @selector(routerHandle_initialize:)
#define ROUTER_INITIALIZE_SEL SEL_MACRO(ROUTER_INITIALIZE_NAME)

#define _ROUTER_INITIALIZE_METHOD(A, B)\
+ (instancetype)A(nullable NSDictionary *)B
#define ROUTER_INITIALIZE_METHOD(arg) _ROUTER_INITIALIZE_METHOD(ROUTER_INITIALIZE_NAME,arg)

#define __ROUTER_SYNC_NAME(A, B) A ## _ ## B:
#define _ROUTER_SYNC_NAME(A, B) __ROUTER_SYNC_NAME(A,B)
// routerHandle_#name:
#define ROUTER_SYNC_NAME(name) _ROUTER_SYNC_NAME(ROUTER_PRE,name)
// @selector(routerHandle_#name:)
#define ROUTER_SYNC_SEL(name) SEL_MACRO(ROUTER_SYNC_NAME(name))

#define __ROUTER_SYNC_METHOD(return_type, pre, name, arg) \
+ (return_type)pre##_##name:(nullable NSDictionary *)arg
#define _ROUTER_SYNC_METHOD(return_type, pre, name, arg) __ROUTER_SYNC_METHOD(return_type,pre,name,arg)
// + (return_type)pre##_##name:(NSDictionary *)arg
#define ROUTER_SYNC_METHOD(return_type, name, arg) _ROUTER_SYNC_METHOD(return_type,ROUTER_PRE,name,arg)

#define __ROUTER_ASYNC_NAME(A, B) A ## _ ## B:callback:
#define _ROUTER_ASYNC_NAME(A, B) __ROUTER_ASYNC_NAME(A,B)
// routerHandle_#name:callback:
#define ROUTER_ASYNC_NAME(name) _ROUTER_ASYNC_NAME(ROUTER_PRE,name)
// @selector(routerHandle_#name:)callback:
#define ROUTER_ASYNC_SEL(name) SEL_MACRO(ROUTER_ASYNC_NAME(name))

#define __ROUTER_ASYNC_METHOD(pre, name, arg) \
+ (void) pre##_##name:(NSDictionary *)arg callback:(nullable void(^)(id value))callback
#define _ROUTER_ASYNC_METHOD(pre, name, arg) __ROUTER_ASYNC_METHOD(pre,name,arg)
#define ROUTER_ASYNC_METHOD(name, arg) _ROUTER_ASYNC_METHOD(ROUTER_PRE,name,arg)

#define ROUTER_SCHEME \
+ (nonnull NSString *)scheme
#define ROUTER_CUSTOM_HOST \
+ (nonnull NSString *)customHost

@protocol JFRouterMapProtocol <NSObject>
ROUTER_SCHEME;

@optional
ROUTER_CUSTOM_HOST;
@end

@protocol JFRouterTypeProtocol <JFRouterMapProtocol>
+ (nullable id)objectForURL:(nonnull NSString *)URL;

+ (nullable id)objectForURL:(nonnull NSString *)URL withUserInfo:(nullable NSDictionary *)userInfo;

+ (void)openURL:(nonnull NSString *)URL;

+ (void)openURL:(nonnull NSString *)URL completion:(nullable void (^)(id result))completion;

+ (void)openURL:(nonnull NSString *)URL withUserInfo:(nullable NSDictionary *)userInfo completion:(nullable void (^)(id result))completion;
@end

@protocol JFRouterProtocol <JFRouterTypeProtocol>
@end

NS_ASSUME_NONNULL_END
