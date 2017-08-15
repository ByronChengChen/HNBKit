//
//  AppDelegate+HNBShowStartAnimation.m
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/20.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "AppDelegate+HNBShowStartAnimation.h"
#import "UIView+HNBAVPlayer.h"

#define AnimationTag 0x1111
#define AnimationViewFadeTime 3

@implementation AppDelegate (HNBShowStartAnimation)
- (void)showStartAnimation{
    UIView *animationiView = [[UIView alloc] initWithHNBAVPlayerWithFadeTime:AnimationViewFadeTime];
    animationiView.frame = [[UIScreen mainScreen] bounds];
    animationiView.tag = AnimationTag;
    //TODO: chengk 启动动画
//    [[UIApplication sharedApplication].keyWindow addSubview:animationiView];
//    [self removeAnimationView];
}

- (void)removeAnimationView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:(AnimationViewFadeTime) animations:^{
            [[UIApplication sharedApplication].keyWindow viewWithTag:AnimationTag].alpha = 0;
        } completion:^(BOOL finished) {
            if(finished){
                [[[UIApplication sharedApplication].keyWindow viewWithTag:AnimationTag] removeFromSuperview];
            }
        }];
    });
}
@end
