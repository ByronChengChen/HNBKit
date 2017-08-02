//
//  HNBMediator.h
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/13.
//  Copyright © 2017年 开发. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HNBMediator : NSObject

//TODO: chengk HNBURLRouter 远程调用放到sdk里面

/**
 *  远程调用 所有的参数都在url里面，但是远程调用有个缺陷，不支持非常规参数(对象类型)，对json和字典类型的支持不大友好
 */
+ (__kindof UIViewController *)viewControllerForRemoteCallUrl:(NSString *)url;

/**
 *  本地调用
 */
+ (__kindof UIViewController *)flowLayoutViewControllerSimple;


@end
