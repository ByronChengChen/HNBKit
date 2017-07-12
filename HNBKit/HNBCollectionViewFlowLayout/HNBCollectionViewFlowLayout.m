//
//  HNBCollectionViewFlowLayout.m
//  UICollectionViewHeaderFooter
//
//  Created by 开发 on 2017/7/11.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "HNBCollectionViewFlowLayout.h"
#define iphone_width ([UIScreen mainScreen].bounds.size.width)
static CGFloat const InvalidlastY = (-10000);

@interface HNBCollectionViewFlowLayout()
@property (nonatomic, assign) CellAlignType cellAlignType;

@end

@implementation HNBCollectionViewFlowLayout

- (instancetype)initWithCellAlignType:(CellAlignType)cellAlignType{
    if(self = [super init]){
        self.leftMargin = 10;
        self.columnSpace = 10;
        self.cellAlignType = cellAlignType;
    }
    return self;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray * layoutAttributes_t = [super layoutAttributesForElementsInRect:rect];
    [self updateCellFrame:(layoutAttributes_t)];
    return layoutAttributes_t;
}

- (void)updateCellFrame:( NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributes{
    CGFloat lastY = InvalidlastY;
    CGFloat currentX = 0;
    CGRect lastCellFrame = CGRectZero;
    for (UICollectionViewLayoutAttributes *attributes in layoutAttributes) {
        CGRect originFrame = attributes.frame;
        if(originFrame.size.width == [UIScreen mainScreen].bounds.size.width){
            continue;
        }
        CGFloat currentY = originFrame.origin.y;
        //第一个cell
        if(InvalidlastY == lastY){
            lastY = currentY;
            currentX = [self getCurrentLineFirstXByCurrentY:currentY allLayoutAttributes:layoutAttributes];
            attributes.frame = CGRectMake(currentX, originFrame.origin.y, originFrame.size.width, originFrame.size.height);
            lastCellFrame = attributes.frame;
        }else{
            //已经换行
            if(lastY != currentY){
                lastY = currentY;
                NSLog(@"currentLineFirstFrame:%@",NSStringFromCGRect(attributes.frame));
                currentX = [self getCurrentLineFirstXByCurrentY:currentY allLayoutAttributes:layoutAttributes];
                attributes.frame = CGRectMake(currentX, originFrame.origin.y, originFrame.size.width, originFrame.size.height);
                lastCellFrame = attributes.frame;
            }
            //未换行
            else{
                currentX = lastCellFrame.origin.x + lastCellFrame.size.width + self.columnSpace;
                attributes.frame = CGRectMake(currentX, originFrame.origin.y, originFrame.size.width, originFrame.size.height);
                lastCellFrame = attributes.frame;
            }
        }
    }
}

//根据当前的行获取最左边的,使用到这个的时候，cell的个数肯定大于0
- (CGFloat)getCurrentLineFirstXByCurrentY:(CGFloat)currentY allLayoutAttributes:( NSArray<UICollectionViewLayoutAttributes *> *)allLayoutAttributes{
    CGFloat firstX = 0;
    NSMutableArray *currentLineWidths = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in allLayoutAttributes) {
        CGRect attributeFrame = attributes.frame;
        if(currentY == attributeFrame.origin.y){
            [currentLineWidths addObject:@(attributeFrame.size.width)];
        }
    }
    switch (self.cellAlignType) {
        case CellAlignLeft:
            firstX = self.leftMargin;
            break;
        case CellAlignCenter:{
            firstX = fabs((iphone_width - [[currentLineWidths valueForKeyPath:@"@sum.floatValue"] floatValue] - (currentLineWidths.count - 1) * self.columnSpace)/2);
        }
            break;
        case CellAlignRight:{
            firstX = fabs((iphone_width - [[currentLineWidths valueForKeyPath:@"@sum.floatValue"] floatValue] - (currentLineWidths.count - 1) * self.columnSpace - self.leftMargin));
        }
            break;
            
        default:
            break;
    }
    
    return firstX;
}

@end
