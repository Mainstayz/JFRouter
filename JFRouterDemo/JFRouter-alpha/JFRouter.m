//
//  JFRouter.m
//  JFRouterDemo
//
//  Created by zz on 2019/1/1.
//  Copyright © 2019 zz. All rights reserved.
//

#import "JFRouter.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>

static NSMutableDictionary*globalRouterMapTable(){
    static NSMutableDictionary *routerMapTable;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        routerMapTable = [NSMutableDictionary dictionary];
    });
    return routerMapTable;
}

static NSMutableDictionary*globalCustomHostMapTable(){
    static NSMutableDictionary *customHostMapTable;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        customHostMapTable = [NSMutableDictionary dictionary];
    });
    return customHostMapTable;
}


@implementation JFRouter

+ (void)load {
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
         dispatch_async(dispatch_queue_create("com.jfrouter.initialize", DISPATCH_QUEUE_CONCURRENT), ^{
             [self setup];
         });
         [[NSNotificationCenter defaultCenter] removeObserver:observer];
     }];
}

+ (void)setup {
    unsigned int count = 0;
    const char **classes = nil;
    NSString *executablePath = [[NSBundle mainBundle] executablePath];
    classes = objc_copyClassNamesForImage([executablePath UTF8String], &count);
    NSLog(@"类：%d个",count);
    Protocol * protocol = @protocol(JFRouterMapProtocol);
    for (int idx = 0; idx < count; idx++) {
        Class cls = NSClassFromString([NSString stringWithUTF8String:classes[idx]]);
        if (class_getClassMethod(cls, @selector(conformsToProtocol:)) && [cls conformsToProtocol:protocol]){
            if ([cls respondsToSelector:@selector(customHost)]) {
                NSString *customHost = [cls customHost];
                if (customHost) {
                    globalCustomHostMapTable()[customHost] = cls;
                }
            }
        }
    }
    free(classes);

}
+ (BOOL)registerClass:(Class<JFRouterTypeProtocol>)protocolClass {
    if ([protocolClass respondsToSelector:@selector(scheme)]) {
        NSString *scheme = [protocolClass scheme];
        if (scheme.length) {
            globalRouterMapTable()[scheme] = protocolClass;
            return YES;
        }
    }
    return NO;
}
+ (void)unregisterClass:(Class<JFRouterTypeProtocol>)protocolClass {
    if ([globalRouterMapTable().allValues containsObject:protocolClass]) {
        NSString *scheme = [protocolClass scheme];
        [globalRouterMapTable() removeObjectForKey:scheme];
    }
}
+ (NSString *)scheme {
    return nil;
}

+ (id)objectForURL:(NSString *)URL {
    return [self objectForURL:URL withUserInfo:nil];
}

+ (id)objectForURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo {
    NSString *scheme = [self schemeForURL:URL];
    if (scheme.length) {
        Class<JFRouterTypeProtocol> cls = globalRouterMapTable()[scheme];
        if (cls) {
            return [cls objectForURL:[self replaceCustomHostWithURL:URL] withUserInfo:userInfo];
        }
    }
    return nil;

}

+ (void)openURL:(NSString *)URL {
    [self openURL:URL completion:nil];
}

+ (void)openURL:(NSString *)URL completion:(void (^)(id _Nonnull))completion {
    [self openURL:URL withUserInfo:nil completion:completion];
}

+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id))completion {
    NSString *scheme = [self schemeForURL:URL];
    if (scheme.length) {
        Class<JFRouterTypeProtocol> cls = globalRouterMapTable()[scheme];
        if (cls) {
            [cls openURL:[self replaceCustomHostWithURL:URL] withUserInfo:userInfo completion:completion];
        }
    }
}

+ (NSString *)schemeForURL:(NSString *)URL {
    URL = [URL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSRange schemeRange = [URL rangeOfString:@"://"];
    if (schemeRange.location != NSNotFound) {
        return [URL substringWithRange:NSMakeRange(0, schemeRange.location)];
    } else {
        return nil;
    }
}
+ (NSString *)replaceCustomHostWithURL:(NSString *)URL{
    NSString *host = [NSURL URLWithString:URL].host;
    if (host) {
        NSRange range = [URL rangeOfString:host];
        if (range.location != NSNotFound) {
            Class cls = globalCustomHostMapTable()[host];
            if (cls ) {
                URL = [URL stringByReplacingCharactersInRange:range withString:NSStringFromClass(cls)];
            }
        }
    }
    return URL;
}
@end
