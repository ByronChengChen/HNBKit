//
//  UIView+Extension.h
//  ByronWeiBo
//
//  Created by 程康 on 15/9/2.
//  Copyright (c) 2015年 程康. All rights reserved.
//

//引用自小码哥的UIView+Extension

#import <UIKit/UIKit.h>

typedef CGSize(^SizeBlock)();

@interface UIView (Extension)
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGPoint origin;

@end
