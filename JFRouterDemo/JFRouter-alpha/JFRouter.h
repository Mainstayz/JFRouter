//
//  JFRouter.h
//  JFRouterDemo
//
//  Created by zz on 2019/1/1.
//  Copyright © 2019 zz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFRouterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface JFRouter : NSObject <JFRouterProtocol>
+ (BOOL)registerClass:(Class <JFRouterTypeProtocol>)protocolClass;

+ (void)unregisterClass:(Class <JFRouterTypeProtocol>)protocolClass;
@end

NS_ASSUME_NONNULL_END
