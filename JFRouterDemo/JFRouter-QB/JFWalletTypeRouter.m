//
//  JFWalletTypeRouter.m
//  JFRouterDemo
//
//  Created by zz on 2019/1/2.
//  Copyright © 2019 zz. All rights reserved.
//


#import "JFWalletTypeRouter.h"
 /*
 scheme://[target]/[action]?[params]
 url sample:
 jfwallet://targetA/actionB?id=1234
 */

@implementation JFWalletTypeRouter

+ (nonnull NSString *)scheme {
    return @"jfwallet";
}

+ (nullable id)objectForURL:(nonnull NSString *)URL {
    return [self objectForURL:URL withUserInfo:nil];
}

+ (nullable id)objectForURL:(nonnull NSString *)URL withUserInfo:(nullable NSDictionary *)userInfo {
    NSURL *aURL = [NSURL URLWithString:URL];
    if (!aURL.host.length) {
        return nil;
    }
    Class cls = NSClassFromString(aURL.host);
    if (!cls) {
        return nil;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:[self parametersWithURL:aURL] ?: @{}];
    [parameters addEntriesFromDictionary:userInfo ?: @{}];
    NSString *fName = [self funcNameWithURL:aURL];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    SEL sel = !fName.length ? ROUTER_INITIALIZE_SEL : NSSelectorFromString([ROUTER_PRE_OC stringByAppendingFormat:@"_%@", fName]);
#pragma clang diagnostic pop
    
    return [self safePerformSelector:sel target:cls parameters:parameters callback:nil];
}


+ (void)openURL:(nonnull NSString *)URL {
    [self openURL:URL completion:nil];
}

+ (void)openURL:(nonnull NSString *)URL completion:(nullable void (^)(id _Nonnull))completion {
    [self openURL:URL withUserInfo:nil completion:completion];
}

+ (void)openURL:(nonnull NSString *)URL withUserInfo:(nullable NSDictionary *)userInfo completion:(nullable void (^)(id _Nonnull))completion {
    NSURL *aURL = [NSURL URLWithString:URL];
    if (!aURL.host.length) {
        return;
    }
    Class cls = NSClassFromString(aURL.host);
    if (!cls) {
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:[self parametersWithURL:aURL] ?: @{}];
    [parameters addEntriesFromDictionary:userInfo ?: @{}];
    NSString *fName = [self funcNameWithURL:aURL];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    SEL sel = !fName.length ? ROUTER_INITIALIZE_SEL : NSSelectorFromString([ROUTER_PRE_OC stringByAppendingFormat:@"_%@callback:", fName]);
#pragma clang diagnostic pop
    
    [self safePerformSelector:sel target:cls parameters:parameters callback:completion];
}

// 解决如果返回值为非OC对象时Crash
+ (id)safePerformSelector:(SEL)sel target:(Class)cls parameters:(NSDictionary *)parameters callback:(void(^)(id data))callback {
    NSMethodSignature* methodSig = [cls methodSignatureForSelector:sel];
    if(methodSig == nil) {
        return nil;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    [invocation setSelector:sel];
    !parameters?:[invocation setArgument:&parameters atIndex:2];
    !callback?:[invocation setArgument:&callback atIndex:3];
    [invocation invokeWithTarget:cls];
    
#define RETURN_VALUE(type) \
    do { \
        type val = 0; \
        [invocation getReturnValue:&val]; \
        return @(val); \
    } while (0)

    // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1

    const char* returnType = [methodSig methodReturnType];
    // const
    if (returnType[0] == 'r') {
        returnType++;
    }
    if (strcmp(returnType, @encode(id)) == 0 || strcmp(returnType, @encode(Class)) == 0 || strcmp(returnType, @encode(void (^)(void))) == 0) {
        __autoreleasing id returnObj;
        [invocation getReturnValue:&returnObj];
        return returnObj;
    }else if (strcmp(returnType, @encode(char)) == 0) {
        RETURN_VALUE(char);
    } else if (strcmp(returnType, @encode(int)) == 0) {
        RETURN_VALUE(int);
    } else if (strcmp(returnType, @encode(short)) == 0) {
        RETURN_VALUE(short);
    } else if (strcmp(returnType, @encode(long)) == 0) {
        RETURN_VALUE(long);
    } else if (strcmp(returnType, @encode(long long)) == 0) {
        RETURN_VALUE(long long);
    } else if (strcmp(returnType, @encode(unsigned char)) == 0) {
        RETURN_VALUE(unsigned char);
    } else if (strcmp(returnType, @encode(unsigned int)) == 0) {
        RETURN_VALUE(unsigned int);
    } else if (strcmp(returnType, @encode(unsigned short)) == 0) {
        RETURN_VALUE(unsigned short);
    } else if (strcmp(returnType, @encode(unsigned long)) == 0) {
        RETURN_VALUE(unsigned long);
    } else if (strcmp(returnType, @encode(unsigned long long)) == 0) {
        RETURN_VALUE(unsigned long long);
    } else if (strcmp(returnType, @encode(float)) == 0) {
        RETURN_VALUE(float);
    } else if (strcmp(returnType, @encode(double)) == 0) {
        RETURN_VALUE(double);
    } else if (strcmp(returnType, @encode(BOOL)) == 0) {
        RETURN_VALUE(BOOL);
    } else if (strcmp(returnType, @encode(char *)) == 0) {
        RETURN_VALUE(const char *);
    } else if (strcmp(returnType, @encode(void)) == 0) {
        return nil;
    } else {
        NSUInteger valueSize = 0;
        NSGetSizeAndAlignment(returnType, &valueSize, NULL);
        unsigned char valueBytes[valueSize];
        [invocation getReturnValue:valueBytes];
        
        return [NSValue valueWithBytes:valueBytes objCType:returnType];
    }
    return nil;
}

/**
 * path 转 SEL
 * eg: /setName   ===> setName:
 *     /setName/andAge   ===> setNameAndAge:
 */
+ (NSString *)funcNameWithURL:(NSURL *)URL {
    if (!URL.path) {
        return nil;
    }
    NSMutableString *funcName = [NSMutableString string];
    [funcName appendString:[URL.path stringByReplacingOccurrencesOfString:@"/" withString:@""]];
    if (funcName.length) {
        [funcName appendString:@":"];
    }
    return [funcName copy];
}

+ (NSDictionary *)parametersWithURL:(NSURL *)URL {
    NSMutableDictionary *parametersDictionary = [NSMutableDictionary dictionary];
    NSArray *queryComponents = [URL.query componentsSeparatedByString:@"&"];
    for (NSString *queryComponent in queryComponents) {
        NSString *key = [queryComponent componentsSeparatedByString:@"="].firstObject;
        NSString *value = [queryComponent substringFromIndex:(key.length + 1)];
        [parametersDictionary setObject:value forKey:key];
    }
    return parametersDictionary;
}

@end
