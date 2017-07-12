//
//  SimpleCollectionFooterView.m
//  UICollectionViewHeaderFooter
//
//  Created by 开发 on 2017/7/10.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "SimpleCollectionFooterView.h"
#import <Masonry/Masonry.h>

@interface SimpleCollectionFooterView()
@property (nonatomic, strong) UILabel *simpleLB;

@end

@implementation SimpleCollectionFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.simpleLB = ({
            UILabel *simpleLB = [UILabel new];
            [self addSubview:simpleLB];
            simpleLB.text = @"simpleFooter";
            [simpleLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.right.equalTo(self).insets(UIEdgeInsetsMake(10, 10, 10, 10));
            }];
            simpleLB;
        });
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

@end
