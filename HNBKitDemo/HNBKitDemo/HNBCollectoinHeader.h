//
//  HNBCollectoinHeader.h
//  UICollectionViewHeaderFooter
//
//  Created by 开发 on 2017/7/12.
//  Copyright © 2017年 开发. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const keyLeftMargin = @"keyLeftMargin";
static NSString * const keyColumnSpace = @"keyColumnSpace";

@interface HNBCollectoinHeader : UIView


@property (nonatomic,copy) void (^collectionReloadBlock)(NSDictionary *);
@property (nonatomic,copy) void (^btnBlock)(UIButton *btn);
@end
