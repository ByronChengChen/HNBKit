//
//  UIButton+HNBButton.m
//  HNBKitDemo
//
//  Created by 开发 on 2017/8/1.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "UIButton+HNBButton.h"

@implementation UIButton (HNBButton)

+ (UIButton*)buttonWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor radius:(CGFloat)radius{
    UIButton *btn = [UIButton new];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setBackgroundColor:backgroundColor];
    btn.layer.cornerRadius = radius;
    return btn;
}

@end
