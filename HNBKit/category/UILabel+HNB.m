//
//  UILabel+HNB.m
//  HNBKitDemo
//
//  Created by 程康 on 2017/8/17.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "UILabel+HNB.h"

@implementation UILabel (HNB)
- (void)setText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor radius:(CGFloat)radius{
    self.text = text;
    self.font = font;
    self.textColor = textColor;
    if(backgroundColor){
        self.backgroundColor = backgroundColor;
    }
    if(radius > 0){
        self.layer.cornerRadius = radius;
    }
}
@end
