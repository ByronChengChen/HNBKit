//
//  HNBCollectionViewFlowLayout.h
//  UICollectionViewHeaderFooter
//
//  Created by 开发 on 2017/7/11.
//  Copyright © 2017年 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CellAlignType) {
    /**
     *  靠左
     */
    CellAlignLeft,
    /**
     *  居中
     */
    CellAlignCenter,
    /**
     *  靠右
     */
    CellAlignRight
};

@interface HNBCollectionViewFlowLayout : UICollectionViewFlowLayout
//注意这里的leftMargin和columnSpace 不宜取得太大
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat columnSpace;

- (instancetype)initWithCellAlignType:(CellAlignType)cellAlignType;

@end
