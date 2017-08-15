//
//  UIColor+HNBColor.h
//  HNBKitDemo
//
//  Created by 开发 on 2017/8/1.
//  Copyright © 2017年 开发. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (Extension)

// 将十六进制的颜色值转为objective-c的颜色
+ (UIColor *)getColor:(NSString *) hexColor;

+ (UIColor *)colorWithString:(NSString *) hexColor;

+ (UIColor *)randomColor;

@end
