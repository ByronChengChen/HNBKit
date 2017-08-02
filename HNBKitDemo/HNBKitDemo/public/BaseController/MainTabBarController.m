//
//  MainTabBarController.m
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/20.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (instancetype)init{
    if([super init]){
        self.tabBar.tintColor = [UIColor redColor];
        self.tabBar.translucent = NO;
        self.tabBar.opaque = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
