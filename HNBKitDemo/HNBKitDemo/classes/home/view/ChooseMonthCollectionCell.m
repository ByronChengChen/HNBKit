//
//  ChooseMonthCollectionCell.m
//  HanabiNoKioku
//
//  Created by 开发 on 16/5/27.
//  Copyright © 2016年 程康. All rights reserved.
//

#import "ChooseMonthCollectionCell.h"
#import <Masonry/Masonry.h>

@interface ChooseMonthCollectionCell()
@property (nonatomic, strong) UILabel *countLabel;
@end

@implementation ChooseMonthCollectionCell


- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.countLabel = ({
            UILabel *countLabel = [UILabel new];
            [self.contentView addSubview:countLabel];
            [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 0, 10, 10));
            }];
            countLabel;
        });
        self.contentView.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

-(void)setDic:(NSDictionary *)dic{
    self.countLabel.text = dic[kChooseMonthCount];
}

@end
