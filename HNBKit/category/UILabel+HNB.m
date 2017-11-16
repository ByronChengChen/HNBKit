//
//  UILabel+HNB.m
//  HNBKitDemo
//
//  Created by 程康 on 2017/8/17.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "UILabel+HNB.h"
#import "NSObject+HNBKit.h"

typedef CGRect (^TextBoundsBlock)(CGRect rect, NSInteger numberOfLines);
typedef void (^DrawTextInRectBlock)(CGRect rect);

static char *kPropertyTextBoundsBlock = "kPropertyTextBoundsBlock";
static char *kPropertyDrawTextInRectWithBlock = "kPropertyDrawTextInRectWithBlock";

@implementation HNBEdgeInsets
- (instancetype)edgeInsetWithUIEdgeInsets:(UIEdgeInsets)edgeInsets{
    HNBEdgeInsets *edge = [HNBEdgeInsets new];
    edge.left = edgeInsets.left;
    edge.right = edgeInsets.right;
    edge.top = edgeInsets.top;
    edge.bottom = edgeInsets.bottom;
    return edge;
}
@end

@interface UILabel()
@property (nonatomic, strong) HNBEdgeInsets *edgeInsets;
@end

@implementation UILabel (HNB)

+ (void)load{
    [self hnbkit_swizzleMethod:@selector(textRectForBounds:limitedToNumberOfLines:) andAnotherSelecor:@selector(hnbkit_textRectForBounds:limitedToNumberOfLines:)];
    [self hnbkit_swizzleMethod:@selector(drawTextInRect:) andAnotherSelecor:@selector(hnbkit_drawTextInRect:)];
}

- (void)setHNBEdgeInsets:(UIEdgeInsets)edgeInsets{
    HNBEdgeInsets *hnbEdgeInsets = [[HNBEdgeInsets new] edgeInsetWithUIEdgeInsets:edgeInsets];
    objc_setAssociatedObject(self, @selector(edgeInsets), hnbEdgeInsets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HNBEdgeInsets *)edgeInsets{
    return objc_getAssociatedObject(self, _cmd);
}

//将text的范围扩大，但是需要调整text的位置
- (CGRect)hnbkit_textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    CGRect oldRect = [self hnbkit_textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    if(!self.edgeInsets){
        return oldRect;
    }
    CGRect newRect = CGRectMake(oldRect.origin.x - self.edgeInsets.left, oldRect.origin.y - self.edgeInsets.top, oldRect.size.width + self.edgeInsets.left + self.edgeInsets.right, oldRect.size.height + self.edgeInsets.top + self.edgeInsets.bottom);
    return newRect;
}

- (void)hnbkit_drawTextInRect:(CGRect)rect{
    CGRect oldRect = rect;
    if(!self.edgeInsets){
        [self hnbkit_drawTextInRect:rect];
        return;
    }
    CGFloat top = self.edgeInsets.top;
    [self hnbkit_drawTextInRect:CGRectMake(oldRect.origin.x + self.edgeInsets.left, /*oldRect.origin.y+*/ top, oldRect.size.width - (self.edgeInsets.left + self.edgeInsets.right), oldRect.size.height - (self.edgeInsets.top + self.edgeInsets.bottom))];
}

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
