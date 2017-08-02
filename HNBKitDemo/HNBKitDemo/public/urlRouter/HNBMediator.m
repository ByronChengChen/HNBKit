//
//  HNBMediator.m
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/13.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "HNBMediator.h"
#import "HNBBaseURLRouter.h"

@implementation HNBMediator

+ (__kindof UIViewController *)viewControllerForRemoteCallUrl:(NSString *)url{
    UIViewController *vc = [HNBBaseURLRouter viewControllerForUrl:url];
    return vc;
}

//TODO: chengk urlRouter 2 拿到vc并且赋参到url，如有需要，可以指定vc的打开方式
+ (__kindof UIViewController *)flowLayoutViewControllerSimple{
    UIViewController *vc = [HNBBaseURLRouter viewControllerForUrl:HNB_flowLayoutViewController];
    return vc;
}

@end
