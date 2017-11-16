//
//  NSObject+HNBKit.m
//  HNBKitDemo
//
//  Created by 程康 on 2017/11/16.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "NSObject+HNBKit.h"

@implementation NSObject (HNBKit)

+ (void)hnbkit_swizzleMethod:(SEL)originalSelector andAnotherSelecor:(SEL)swizzledSelector {
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
