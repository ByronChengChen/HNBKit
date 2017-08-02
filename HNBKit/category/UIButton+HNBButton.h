//
//  UIButton+HNBButton.h
//  HNBKitDemo
//
//  Created by 开发 on 2017/8/1.
//  Copyright © 2017年 开发. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (HNBButton)
+ (UIButton*)buttonWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor radius:(CGFloat)radius;
@end
