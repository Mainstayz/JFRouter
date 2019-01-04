//
//  MainTableViewController.m
//  JFRouterDemo
//
//  Created by zz on 2019/1/3.
//  Copyright © 2019 zz. All rights reserved.
//

#import "MainTableViewController.h"
#import "JFRouter.h"
#import "JFRouterDemo-Swift.h"

@implementation MainTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            UIViewController *vc = [JFRouter objectForURL:@"jfwallet://ViewController" withUserInfo:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            [JFRouter objectForURL:@"jfwallet://ServiceA/alert?y=x!"];
        }
            break;
        case 2:{
            [JFRouter openURL:@"jfwallet://ServiceA/downloadXXX" completion:^(id  _Nonnull result) {
                NSLog(@"%@",result);
            }];
        }
            //            [ServiveSwift foo];
            //            NSLog(@"+++%@",NSClassFromString(@"JFRouterDemo.ServiveSwift"));
            //            NSLog(@"---%@",NSClassFromString(@"ServiveSwift"));

        case 3:{
            [JFRouter objectForURL:@"jfwallet://JFRouterDemo.ServiveSwift"];
        }
            break;
        case 4:{
            [JFRouter objectForURL:@"jfwallet://JFRouterDemo.ServiveSwift/foo?y=x!"];
        }
            break;
        case 5:{
            [JFRouter openURL:@"jfwallet://JFRouterDemo.ServiveSwift/xxxx" completion:^(id  _Nonnull result) {
                NSLog(@"%@",result);
            }];

        }
            break;
        case 6:{
            [JFRouter objectForURL:@"jfwallet://ServiveSwift/foo?y=x!"];
        }
            break;

            
        default:
            break;
    }
}
@end
