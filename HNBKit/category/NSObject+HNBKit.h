//
//  NSObject+HNBKit.h
//  HNBKitDemo
//
//  Created by 程康 on 2017/11/16.
//  Copyright © 2017年 开发. All rights reserved.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <objc/runtime.h>
#import <objc/message.h>
#else
#import <objc/objc-class.h>
#endif

@interface NSObject (HNBKit)
/**
 *  方法交叉,替换系统方法实现
 *
 *  @param originalSelector 原方法SEL
 *  @param swizzledSelector 自己实现的SEL
 */
+ (void)hnbkit_swizzleMethod:(SEL)originalSelector andAnotherSelecor:(SEL)swizzledSelector ;

@end
