//
//  HNBEmitterAnimationView.m
//  HanabiNoKioku
//
//  Created by 开发 on 2017/5/22.
//  Copyright © 2017年 程康. All rights reserved.
//

#import "HNBEmitterAnimationView.h"

@interface HNBEmitterAnimationView()
@property (nonatomic, assign) HNBEmitterAnimationType emitterAnimationType;
@property (nonatomic, strong) UIImage *image;

@end

@implementation HNBEmitterAnimationView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        
    }
    return self;
}

- (void)setEmitterAnimationType:(HNBEmitterAnimationType)type andImage:(UIImage *)image{
    self.emitterAnimationType = type;
    self.image = image;
    switch (type) {
        case HNBEmitterAnimationSnow:
        {
            [self addSnow];
        }
            break;
        case HNBEmitterAnimationRain:
        {
            [self addRain];
        }
            break;
        case HNBEmitterAnimationFireWork:
        {
            [self addFireWork];
        }
            break;
        default:
            break;
    }
}

- (void)addSnow{
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    self.backgroundColor  = [UIColor blackColor];
    // 创建粒子Layer
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    // 粒子发射位置
    snowEmitter.emitterPosition = CGPointMake(self.sizeWidth/2,0);
    // 发射源的尺寸大小
    snowEmitter.emitterSize = self.bounds.size;
    // 发射模式
    snowEmitter.emitterMode = kCAEmitterLayerSurface;
    // 发射源的形状
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    // 创建雪花类型的粒子
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    // 粒子的名字
    snowflake.name = @"snow";
    // 粒子参数的速度乘数因子
    snowflake.birthRate = 100.0;  //每秒生成数量
    snowflake.lifetime = 60;        //生存时间
    // 粒子速度
    snowflake.velocity =10.0;
    // 粒子的速度范围
    snowflake.velocityRange = 10;
    // 粒子y方向的加速度分量
    snowflake.yAcceleration = 8;
    // 周围发射角度
    snowflake.emissionRange = 0.5 * M_PI;
    // 子旋转角度范围
    snowflake.spinRange = 0.25 * M_PI;
    snowflake.contents = (id)self.image.CGImage;
    // 设置雪花形状的粒子的颜色
    snowflake.color = [[UIColor whiteColor] CGColor];
    //缩放范围
    snowflake.scaleRange = 0.3f;
    snowflake.scale = 0.1f;
    
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius = 0.0;
    snowEmitter.shadowOffset = CGSizeMake(0.0, 0.0);
    // 粒子边缘的颜色
    snowEmitter.shadowColor = [[UIColor whiteColor] CGColor];
    // 添加粒子
    snowEmitter.emitterCells = @[snowflake];
    
    // 将粒子Layer添加进图层中
    [self.layer addSublayer:snowEmitter];
}

- (void)addRain{
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    self.backgroundColor =[UIColor blackColor];
    //发射器
    CAEmitterLayer *rainEmitter =[CAEmitterLayer layer];
    
    rainEmitter.emitterShape    = kCAEmitterLayerLine;
    rainEmitter.emitterMode     = kCAEmitterLayerOutline;
    rainEmitter.emitterSize     = self.bounds.size;
    rainEmitter.renderMode      = kCAEmitterLayerAdditive;
    rainEmitter.emitterPosition = CGPointMake(self.sizeWidth/2, 20);
    //水滴
    CAEmitterCell *rainflake    = [CAEmitterCell emitterCell];
    rainflake.birthRate         = 50;   //每秒发出的数量
    
    //rainflake.speed             = 10;   //速度
    rainflake.velocity          = 300;   //加速度
    //rainflake.velocityRange     = 75;   //加速度范围
    rainflake.yAcceleration     = 500;  //重力
    
    rainflake.contents          = (id)self.image.CGImage;
    rainflake.color             = [UIColor whiteColor].CGColor;
    rainflake.lifetime          = 2;   //生命周期
    rainflake.scale             = 0.3;  //缩放
    rainflake.scaleRange        = 0.2;
    
    //水花
    CAEmitterCell *rainSpark =[CAEmitterCell emitterCell];
    
    rainSpark.birthRate         = 1;
    rainSpark.velocity          = 0;
    //rainSpark.emissionRange     = M_PI;//180度
    //rainSpark.yAcceleration     = 40;
    rainSpark.scale             = 0.5;
    rainSpark.contents          = (id)self.image.CGImage;
    rainSpark.color=[UIColor whiteColor].CGColor;
    rainSpark.lifetime          =  0.3;
    
    //
    
    // and finally, the sparks
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
    spark.birthRate            = 50;       //炸开后产生40花
    spark.velocity             = 50;       //速度
    spark.velocityRange        = 20;
    spark.emissionRange        = M_PI;   // 360 度
    spark.yAcceleration        = 40;         // 重力
    spark.lifetime             = 0.5;
    
    spark.contents          = (id) [self.image CGImage];
    spark.scaleSpeed        = 0.2;
    spark.scale             = 0.2;
    spark.color =[UIColor whiteColor].CGColor;
    spark.alphaSpeed        =- 0.25;
    spark.spin              = 2* M_PI;
    spark.spinRange         = 2* M_PI;
    
    rainEmitter.emitterCells    = @[rainflake];
    rainflake.emitterCells      = @[rainSpark];
    rainSpark.emitterCells      = @[spark];
    
    [self.layer addSublayer:rainEmitter];
}
- (void)addFireWork{
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    self.backgroundColor  = [UIColor blackColor];
    
    //cell产生在底部,向上移动
    CAEmitterLayer *fireworkdEmitter =[CAEmitterLayer layer];
    CGRect viewBounds = self.layer.bounds;
    
    fireworkdEmitter.emitterPosition =CGPointMake(viewBounds.size.width/2, viewBounds.size.height);
    fireworkdEmitter.emitterMode = kCAEmitterLayerOutline;
    fireworkdEmitter.emitterShape = kCAEmitterLayerLine;
    fireworkdEmitter.renderMode = kCAEmitterLayerAdditive;
    fireworkdEmitter.seed = (arc4random()%100)+1;
    
    //创建火箭cell
    CAEmitterCell *rocket = [CAEmitterCell emitterCell];
    rocket.birthRate = 1;
    rocket.emissionRange = 0.25 *M_PI;
    rocket.velocity = 300;
    rocket.velocityRange = 75;
    rocket.lifetime =1.02;
    
    rocket.contents = (id)self.image.CGImage;
    rocket.scale = 0.5;
    rocket.scaleRange =0.5;
    rocket.color = [UIColor redColor].CGColor;
    rocket.greenRange = 1.0;
    rocket.redRange = 1.0;
    rocket.blueRange = 1.0;
    rocket.spinRange =M_PI;
    
    //破裂对象不能被看到,但会产生火花
    //这里我们改变颜色,因为火花继承它的值
    CAEmitterCell *fireCell =[CAEmitterCell emitterCell];
    
    fireCell.birthRate          = 1;
    fireCell.velocity           = 0;
    fireCell.scale              = 1;
    fireCell.redSpeed           =- 1.5;
    fireCell.blueSpeed          =+ 1.5;
    fireCell.greenSpeed         =+ 1.5;        // shifting
    fireCell.lifetime           = 0.34;
    
    
    // and finally, the sparks
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
    spark.birthRate            = 400;       //炸开后产生400个小烟花
    spark.velocity             = 125;       //速度
    spark.emissionRange        = 2* M_PI;   // 360 度
    spark.yAcceleration        = 40;         // 重力
    spark.lifetime             = 3;
    
    spark.contents          = (id)self.image.CGImage;
    spark.scaleSpeed        =- 0.2;
    
    spark.greenSpeed        =- 0.1;
    spark.redSpeed          =+ 0.1;
    spark.blueSpeed         =- 0.1;
    
    spark.alphaSpeed        =- 0.25;
    
    spark.spin              = 2* M_PI;
    spark.spinRange         = 2* M_PI;
    
    fireworkdEmitter.emitterCells        = [NSArray arrayWithObject:rocket];
    rocket.emitterCells                  = [NSArray arrayWithObject:fireCell];
    fireCell.emitterCells                = [NSArray arrayWithObject:spark];
    
    [self.layer addSublayer:fireworkdEmitter];
}

- (CGFloat)sizeWidth{
    return self.bounds.size.width;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
