//
//  RouterProtocol.h
//  RouterDemo
//
//  Created by zz on 2019/1/2.
//  Copyright © 2019 zz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFRouterMacroDefine.h"
NS_ASSUME_NONNULL_BEGIN

@protocol JFRouterMapProtocol <NSObject>
@required
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
