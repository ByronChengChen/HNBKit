//
//  HNBEmitterAnimationView.h
//  HanabiNoKioku
//
//  Created by 开发 on 2017/5/22.
//  Copyright © 2017年 程康. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, HNBEmitterAnimationType) {
    /**
     *  雪花
     */
    HNBEmitterAnimationSnow,
    /**
     *  下雨
     */
    HNBEmitterAnimationRain,
    /**
     *  烟花
     */
    HNBEmitterAnimationFireWork,
    /**
     *  default
     */
    HNBEmitterAnimationNo
};

@interface HNBEmitterAnimationView : UIView
- (void)setEmitterAnimationType:(HNBEmitterAnimationType)type andImage:(UIImage *)image;
@end
