//
//  ServiceA.m
//  JFRouterDemo
//
//  Created by zz on 2019/1/3.
//  Copyright © 2019 zz. All rights reserved.
//

#import "ServiceA.h"
#import <UIKit/UIKit.h>
#import "JFRouterProtocol.h"
@implementation ServiceA
+ (void)initialize
{
    if (self == [ServiceA class]) {
    }
}
ROUTER_SYNC_METHOD(void, alert, arg){
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:arg.description preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}
ROUTER_ASYNC_METHOD(downloadXXX, arg) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (callback) {
            callback(@"下载好了");
        }
    });
}
ROUTER_SCHEME{
    return @"jfwallet";
}
@end
