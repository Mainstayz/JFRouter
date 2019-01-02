//
//  MainTableViewController.m
//  JFRouterDemo
//
//  Created by zz on 2019/1/3.
//  Copyright © 2019 zz. All rights reserved.
//

#import "MainTableViewController.h"
#import "JFRouter.h"

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
            break;
            
        default:
            break;
    }
}
@end
