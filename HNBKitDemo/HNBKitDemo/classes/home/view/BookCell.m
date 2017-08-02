//
//  BookCell.m
//  HanabiNoKioku
//
//  Created by 开发 on 2017/6/8.
//  Copyright © 2017年 程康. All rights reserved.
//

#import "BookCell.h"

@implementation BookModel

@end

@interface BookCell()<BEMCheckBoxDelegate>


@end

@implementation BookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.checkBox = ({
        BEMCheckBox *checkBox = [[BEMCheckBox alloc] init];
        checkBox.delegate = self;
        [self.contentView addSubview:checkBox];
        [checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.centerY.equalTo(self.contentView);
            make.width.height.equalTo(@30);
        }];
        checkBox;
    });
    
    self.nameLB = ({
        UILabel *nameLB = [UILabel new];
        [self.contentView addSubview:nameLB];
        [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
        }];
        nameLB.backgroundColor = [UIColor redColor];
        nameLB;
    });
    
    self.priceLB = ({
        UILabel *priceLB = [UILabel new];
        [self.contentView addSubview:priceLB];
        [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-20);
            make.centerY.equalTo(self.contentView);
        }];
        priceLB.backgroundColor = [UIColor redColor];
        priceLB;
    });
}

- (void)setModel:(BookModel *)model{
    super.model = model;
    self.checkBox.on = model.selected;
    self.nameLB.text = model.name;
    self.priceLB.text = @(model.price).stringValue;
}

#pragma mark -BEMCheckBoxDelegate

- (void)didTapCheckBox:(BEMCheckBox*)checkBox{
    BookModel *model = (BookModel *)self.model;
    if(checkBox.on){
        (model.selected = YES);
    }else{
        model.selected = NO;
    }
    [self routerEventWithName:routeEventBookCheckChange userInfo:@{BookCheckChangeUserInfoKey:self.model}];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
