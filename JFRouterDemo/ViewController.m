//
//  ViewController.m
//  JFRouterDemo
//
//  Created by zz on 2019/1/1.
//  Copyright © 2019 zz. All rights reserved.
//

#import "ViewController.h"
#import "JFRouterProtocol.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"哈哈";
    self.view.backgroundColor = [UIColor grayColor];

}
ROUTER_INITIALIZE_METHOD(arg){
    NSLog(@"%@",arg);
    return [ViewController new];
}
ROUTER_SCHEME {
    return @"jfwallet";
}
@end
