//
//  HomeCell.m
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/31.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeModel


@end

@implementation HomeCell

- (void)setModel:(HomeModel *)model{
    self.textLabel.text = model.name;
}

@end
