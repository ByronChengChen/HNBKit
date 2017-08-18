//
//  HNBBaseTableViewController+HeadCircleChangeScale.m
//  HNBKitDemo
//
//  Created by 程康 on 2017/8/17.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "HNBBaseTableViewController+HeadCircleChangeScale.h"
#import "RZHellowCircleView.h"

@implementation HNBBaseTableViewController (HeadCircleChangeScale)

- (void)customerNavigationBarTitleViewWithView:(UIView*)view length:(CGFloat)length titleText:(NSString *)titleText titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont innerCircleSpace:(CGFloat)circleSpace circleWidth:(CGFloat)circleWith circleColor:(UIColor *)circleColor{
    self.titleImageLength = length;
    CGFloat titleImageLength = self.titleImageLength;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleImageLength, titleImageLength/2)];
    
    RZHellowCircleView *circleView = [RZHellowCircleView new];
    circleView.backgroundColor = [UIColor clearColor];
    //y值是计算出来的，画图计算
    view.frame = CGRectMake(0, 22 + 16 - titleImageLength/4, titleImageLength, titleImageLength);
    
    UIView *imageView = view;
    circleView.frame =CGRectMake(0,0,view.width,view.height);
    [imageView addSubview:circleView];
    //TODO: chengk 产品详情页头部 2 这里的imageView应该放在RZHellowCircleView 的里面，并且在RZHellowCircleView 的drawRect方法改变imageView的位置
    self.imageView = (UIImageView *)imageView;
    [titleView addSubview:imageView];
    
    self.navigationItem.titleView = titleView;
    self.circleView = circleView;
    self.titleViewLB = ({
        UILabel *titleViewLB = [UILabel new];
        titleViewLB.frame = CGRectMake(0, 0, IPHONE_WIDTH, 20);
        titleViewLB.center = titleView.center;
        if(titleText && titleFont && titleFont){
            [titleViewLB setText:titleText textColor:titleColor font:titleFont backgroundColor:nil radius:0];
        }
        titleViewLB.textAlignment = NSTextAlignmentCenter;
        [titleView addSubview:titleViewLB];
        titleViewLB.hidden = YES;
        titleViewLB;
    });
    CGFloat space = circleSpace;
    [((RZHellowCircleView *)circleView) addCircleAtFrame:CGRectMake(space, space, length - 2 * space, length - 2 * space) circleWidth:circleWith color:circleColor];
    [circleView setNeedsDisplay];

}

- (void)updateScaleWithPrecent:(CGFloat)precent{
    CGFloat titleViewY = self.navigationItem.titleView.frame.origin.y;
    CGFloat titleImageLength = self.titleImageLength;
    CGFloat length = (1 - precent) * titleImageLength;
    LogYellow(@"length%f",length);
    if(length <= titleImageLength * 0.2){
        length = 0;
        self.titleViewLB.hidden = NO;
    }else if(length > titleImageLength * 0.95){
        length = titleImageLength;
        self.titleViewLB.hidden = YES;
    }
    self.imageView.frame = CGRectMake((titleImageLength - length)/2, titleImageLength/2 - (length/2 - titleViewY) + 16, length, length);
    self.circleView.frame = CGRectMake(0, 0, length, length);
}

- (void)setCurrentOffset:(CGFloat)currentOffset limitY:(CGFloat)limitY{
    if(currentOffset > limitY){
        self.circleView.hidden = YES;
        self.titleViewLB.hidden = NO;
    }else{
        self.circleView.hidden = NO;
        self.titleViewLB.hidden = YES;
    }
}

- (void)setTitleViewLB:(UILabel *)titleViewLB{
    objc_setAssociatedObject(self, @selector(titleViewLB), titleViewLB, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)titleViewLB{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setImageView:(UIImageView *)imageView{
    objc_setAssociatedObject(self, @selector(imageView), imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)imageView{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCircleView:(UIView *)circleView{
    objc_setAssociatedObject(self, @selector(circleView), circleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)circleView{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTitleImageLength:(CGFloat)titleImageLength{
    objc_setAssociatedObject(self, @selector(titleImageLength), @(titleImageLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)titleImageLength{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}


@end
