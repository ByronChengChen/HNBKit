//
//  UIWindow+HNBSwitchRootConroller.m
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/20.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "UIWindow+HNBSwitchRootConroller.h"
#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "HNBNewfeatureViewController.h"
#import "AppDelegate.h"
#import "TestBEMCheckBoxController.h"

@implementation UIWindow (HNBSwitchRootConroller)
- (void)switchRootViewController{
    NSString *key = @"CFBundleVersion";
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) { // 版本号相同：这次打开和上次打开的是同一个版本
        self.rootViewController = nil;
        MainTabBarController *mainTabBarController = [[MainTabBarController alloc] init];
        UIViewController *home = [self getNavigationByViewControllerName:@"HNBHomeViewController" title:@"首页" imageName:@"tab_icon_1"];
        UIViewController *chat = [self getNavigationByViewControllerName:@"ChatViewController" title:@"聊天" imageName:@"tab_icon_2"];
        UIViewController *media = [self getNavigationByViewControllerName:@"MediaViewController" title:@"娱乐" imageName:@"tab_icon_3"];
        UIViewController *personCenter = [self getNavigationByViewControllerName:@"PersonCenterViewController" title:@"个人中心" imageName:@"tab_icon_4"];
        
        mainTabBarController.selectedIndex = 0;
        mainTabBarController.viewControllers = @[home,chat,media,personCenter];
        self.rootViewController = mainTabBarController;
        ApplicationDelegate.mainTabBarController = mainTabBarController;
    } else { // 这次打开的版本和上一次不一样，显示新特性
        __weak typeof(self) weakSelf = self;
        HNBNewfeatureViewController *newFeatureVC = [[HNBNewfeatureViewController alloc] init];
        newFeatureVC.finishShowNewFeatureBlock = ^(void){
            [weakSelf switchRootViewController];
        };
        self.rootViewController = newFeatureVC;
        // 将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
//
    }

}

- (UIViewController*)getNavigationByViewControllerName:(NSString *)viewControllerName title:(NSString *)titleName imageName:(NSString *)imageName{
    Class vcClass = NSClassFromString(viewControllerName);
    if(vcClass){
        UIViewController *viewController = [vcClass instanceHNBViewController];
        viewController.tabBarItem.image = [UIImage imageNamed:imageName];
        viewController.tabBarItem.title = titleName;
        // [[UITabBarItem alloc] initWithTitle:titleName image:[UIImage imageNamed:imageName] selectedImage:[UIImage imageNamed:selectedImageName]];
        return [[BaseNavigationController alloc] initWithRootViewController:viewController];
    }else{
        return nil;
    }
}

@end
