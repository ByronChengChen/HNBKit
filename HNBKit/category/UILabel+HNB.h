//
//  UILabel+HNB.h
//  HNBKitDemo
//
//  Created by 程康 on 2017/8/17.
//  Copyright © 2017年 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNBEdgeInsets:NSObject
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
- (instancetype)edgeInsetWithUIEdgeInsets:(UIEdgeInsets)edgeInsets;
@end

@interface UILabel (HNB)
- (void)setHNBEdgeInsets:(UIEdgeInsets)edgeInsets;
- (void)setText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor radius:(CGFloat)radius;
@end
