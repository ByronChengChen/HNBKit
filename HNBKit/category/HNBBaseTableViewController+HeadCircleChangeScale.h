//
//  HNBBaseTableViewController+HeadCircleChangeScale.h
//  HNBKitDemo
//
//  Created by 程康 on 2017/8/17.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "HNBBaseTableViewController.h"

@interface HNBBaseTableViewController (HeadCircleChangeScale)
- (void)customerNavigationBarTitleViewWithView:(UIView*)view length:(CGFloat)length titleText:(NSString *)titleText titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont innerCircleSpace:(CGFloat)circleSpace circleWidth:(CGFloat)circleWith circleColor:(UIColor *)circleColor;
- (void)updateScaleWithPrecent:(CGFloat)precent;
- (void)setCurrentOffset:(CGFloat)currentOffset limitY:(CGFloat)limitY;
@end
