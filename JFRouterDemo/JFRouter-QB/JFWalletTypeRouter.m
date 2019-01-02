//
//  JFWalletTypeRouter.m
//  JFRouterDemo
//
//  Created by zz on 2019/1/2.
//  Copyright © 2019 zz. All rights reserved.
//

#import "JFWalletTypeRouter.h"

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
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [cls performSelector:sel withObject:parameters];
#pragma clang diagnostic pop

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
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [cls performSelector:sel withObject:parameters withObject:completion];
#pragma clang diagnostic pop

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
    NSArray *components = [URL.path componentsSeparatedByString:@"/"];
    __block NSMutableString *funcName = [NSMutableString string];
    [components enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if (obj.length) {
            [funcName appendString:obj];
        }
    }];
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
