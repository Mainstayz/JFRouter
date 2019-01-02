//
//  JFRouterProtocol.h
//  JFRouterDemo
//
//  Created by zz on 2019/1/2.
//  Copyright © 2019 zz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define JFROUTER_INITIALIZE_METHOD() \
+ (instancetype)routerHandle_initialize:(NSDictionary *)params
#define JFROUTER_SYNC_METHOD(return_type,name) \
+ (return_type)routerHandle_##name:(NSDictionary *)params
#define JFROUTER_ASYNC_METHOD(name,arg) \
+ (void)routerHandle_##name:(NSDictionary *)arg callback:(id)callback

@protocol JFRouterMapProtocol <NSObject>
+ (NSString *)scheme;
@optional
+ (NSString *)customHost;
@end

@protocol JFRouterTypeProtocol <JFRouterMapProtocol>
+ (nullable id)objectForURL:(NSString *)URL;
+ (nullable id)objectForURL:(NSString *)URL withUserInfo:(nullable NSDictionary *)userInfo;
+ (void)openURL:(NSString *)URL;
+ (void)openURL:(NSString *)URL completion:(nullable void (^)(id result))completion;
+ (void)openURL:(NSString *)URL withUserInfo:(nullable NSDictionary *)userInfo completion:(nullable void (^)(id result))completion;
@end

@protocol JFRouterProtocol <JFRouterTypeProtocol>
@end

NS_ASSUME_NONNULL_END
