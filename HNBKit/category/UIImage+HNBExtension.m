//
//  UIImage+HNBExtension.m
//  HanabiNoKioku
//
//  Created by 开发 on 2017/7/4.
//  Copyright © 2017年 程康. All rights reserved.
//

#import "UIImage+HNBExtension.h"


@implementation UIImage (HNBExtension)

+ (UIImage *) hnb_imageWithColor:(UIColor *)color {
    return [UIImage hnb_imageWithColor:color Size:CGSizeMake(4.0f, 4.0f)];
}

+ (UIImage *) hnb_imageWithColor:(UIColor *)color Size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image mm_stretched];
}

- (UIImage *) mm_stretched
{
    CGSize size = self.size;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(truncf(size.height-1)/2, truncf(size.width-1)/2, truncf(size.height-1)/2, truncf(size.width-1)/2);
    
    return [self resizableImageWithCapInsets:insets];
}

@end
