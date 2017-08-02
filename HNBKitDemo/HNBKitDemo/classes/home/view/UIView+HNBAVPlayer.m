//
//  UIView+HNBAVPlayer.m
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/20.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "UIView+HNBAVPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <objc/runtime.h>

@interface UIView()
@property (nonatomic,strong)AVPlayer *avPlayer;
@property (nonatomic, strong) AVPlayerLayer *avLayer;
@property (nonatomic, assign) CGFloat fadeTime;

@end

@implementation UIView (HNBAVPlayer)

- (AVPlayer*)avPlayer{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAvPlayer:(AVPlayer *)avPlayer{
    objc_setAssociatedObject(self, @selector(avPlayer), avPlayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AVPlayerLayer *)avLayer{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAvLayer:(AVPlayerLayer *)avLayer{
    objc_setAssociatedObject(self, @selector(avLayer), avLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)fadeTime{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setFadeTime:(CGFloat)fadeTime{
    objc_setAssociatedObject(self, @selector(fadeTime), @(fadeTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (instancetype)initWithHNBAVPlayerWithFadeTime:(CGFloat)fadeTime{
    if([self init]){
        [self playHNBVedio];
        self.fadeTime = fadeTime;
    }
    return self;
}



- (void)playHNBVedio{
    
    UILabel *welcomLB = [UILabel new];
    welcomLB.frame = CGRectMake(46, 4, 190, 70);
    welcomLB.text = @"welcom to";
    welcomLB.textColor = [UIColor whiteColor];
    welcomLB.font = [UIFont systemFontOfSize:35];
    [self addSubview:welcomLB];
    
    UILabel *hnbLB = [UILabel new];
    hnbLB.frame = CGRectMake(210, 160, 80, 40);
    hnbLB.text = @"花火";
    hnbLB.font = [UIFont systemFontOfSize:20];
    hnbLB.textColor = [UIColor whiteColor];
    [self addSubview:hnbLB];
    
    NSString *urlPath = [[NSBundle mainBundle] pathForResource:@"fireWork" ofType:@"mov"];
    NSURL *url = [NSURL fileURLWithPath:urlPath];
    //设置播放的项目
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    //初始化player对象
    self.avPlayer = [[AVPlayer alloc] initWithPlayerItem:item];
    //设置播放页面DDD
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    
    self.avLayer = layer;
    //设置播放页面的大小
    layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    layer.videoGravity = AVLayerVideoGravityResize;
    layer.backgroundColor = [UIColor clearColor].CGColor;
    //设置播放窗口和当前视图之间的比例显示内容
    /* AVLayerVideoGravityResizeAspect, AVLayerVideoGravityResizeAspectFill
     and AVLayerVideoGravityResize. AVLayerVideoGravityResizeAspect*/
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //添加播放视图到self.view
    [self.layer addSublayer:layer];
    //设置播放进度的默认值
    //设置播放的默认音量值
    self.avPlayer.volume = 1.0f;
    [self.avPlayer play];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
        opacityAnimation.duration = self.fadeTime;
        //设置
        opacityAnimation.fillMode = kCAFillModeForwards;
        opacityAnimation.removedOnCompletion = NO;
        [layer addAnimation:opacityAnimation forKey:@"opacity"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.fadeTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.avPlayer pause];
            layer.hidden = YES;
            [layer removeFromSuperlayer];
        });
    });
}

@end
