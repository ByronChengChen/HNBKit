//
//  RZHellowCircleView.m
//  Rongzi_iOS
//
//  Created by 程康 on 2017/8/17.
//  Copyright © 2017年 rongzi. All rights reserved.
//

#import "RZHellowCircleView.h"
# define kBorderWith 20

@interface RZHellowCircleView()
@property (nonatomic, assign) CGFloat circleRadius;
@property (nonatomic, assign) CGFloat circleWidth;
@property (nonatomic, strong) UIColor *circleColor;
@property (nonatomic, assign) CGRect circleFrame;
@end

@implementation RZHellowCircleView

- (void)addCircleAtFrame:(CGRect)frame circleWidth:(CGFloat)circleWidth color:(UIColor *)color{
    self.circleFrame = frame;
    self.circleWidth = circleWidth;
    self.circleColor = color;
}

// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if(self.circleFrame.size.width > 0 && self.circleWidth > 0 && self.circleColor){
        /** * 画空心圆 */
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [self.circleColor set];
        CGRect bigRect = self.circleFrame;
        //设置空心圆的线条宽度
        CGContextSetLineWidth(ctx, self.circleWidth);
        //以矩形bigRect为依据画一个圆
        CGContextAddEllipseInRect(ctx, bigRect);
        //填充当前绘画区域的颜色 [[UIColor greenColor] set];
        //(如果是画圆会沿着矩形外围描画出指定宽度的（圆线）空心圆)/（根据上下文的内容渲染图层）
        CGContextStrokePath(ctx);
    }
}


@end
