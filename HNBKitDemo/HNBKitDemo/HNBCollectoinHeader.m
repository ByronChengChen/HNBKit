//
//  HNBCollectoinHeader.m
//  UICollectionViewHeaderFooter
//
//  Created by 开发 on 2017/7/12.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "HNBCollectoinHeader.h"
#import <Masonry/Masonry.h>

static CGFloat const btnSpacing = 30;

@interface HNBCollectoinHeader()
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UITextField *leftMarginTF;
@property (nonatomic, strong) UITextField *columnSpacingTF;
@property (nonatomic, strong) UIButton *reloadCollectionBtn;

@end

@implementation HNBCollectoinHeader
- (instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        [self setButtons];
        [self setMarginAndSpacing];
        [self setReloadBtn];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)]];
    }
    return self;
}

- (void)endEditing{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)setMarginAndSpacing{
    self.leftMarginTF = ({
        UITextField *leftMarginTF = [UITextField new];
        leftMarginTF.placeholder = @"leftMargin";
        leftMarginTF.font = [UIFont systemFontOfSize:13];
        leftMarginTF.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:leftMarginTF];
        [leftMarginTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftBtn);
            make.top.equalTo(self.leftBtn.mas_bottom).offset(20);
            make.width.equalTo(self.leftBtn);
            make.height.equalTo(self.leftBtn);
        }];
        leftMarginTF;
    });
    
    self.columnSpacingTF = ({
        UITextField *columnSpacingTF = [UITextField new];
        columnSpacingTF.placeholder = @"columnSpacing";
        columnSpacingTF.font = [UIFont systemFontOfSize:13];
        columnSpacingTF.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:columnSpacingTF];
        [columnSpacingTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftMarginTF.mas_right).offset(40);
            make.top.equalTo(self.leftMarginTF);
            make.width.equalTo(self.leftBtn);
            make.height.equalTo(self.leftBtn);
        }];
        columnSpacingTF;
    });

}

- (void)setReloadBtn{
    self.reloadCollectionBtn = ({
        UIButton *reloadCollectionBtn = [UIButton new];
        reloadCollectionBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [reloadCollectionBtn setTitle:@"collectionViewReload" forState:UIControlStateNormal];
        [self addSubview:reloadCollectionBtn];
        [reloadCollectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftMarginTF.mas_bottom).offset(20);
            make.centerX.equalTo(self);
            make.width.equalTo(@(100));
            make.height.equalTo(@(44));
        }];
        [reloadCollectionBtn addTarget:self action:@selector(reloadAction:) forControlEvents:UIControlEventTouchDown];
        reloadCollectionBtn;
    });
}

- (void)setButtons{
    CGFloat iphone_width = [UIScreen mainScreen].bounds.size.width;
    CGFloat btnWidth = (iphone_width - btnSpacing * (3+1))/3;
    UIButton *lastBtn = nil;
    for (int i = 0; i<3; i++) {
        UIButton *btn = [UIButton new];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.tag = 1000 + 1 + i;
        [self addSubview:btn];
        if(i == 0){
            [btn setTitle:@"left" forState:UIControlStateNormal];
            self.leftBtn = btn;
        }else if(1 == i){
            [btn setTitle:@"center" forState:UIControlStateNormal];
        }else{
            [btn setTitle:@"right" forState:UIControlStateNormal];
        }
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            if(lastBtn){
                make.left.equalTo(lastBtn.mas_right).offset(btnSpacing);
            }else{
                make.left.equalTo(self).offset(btnSpacing);
            }
            make.width.equalTo(@(btnWidth));
            make.height.equalTo(@(44));
        }];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
        lastBtn = btn;
    }
}

- (void)reloadAction:(id)sender {
    if(self.collectionReloadBlock){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if(self.leftMarginTF.text){
            dict[keyLeftMargin] = self.leftMarginTF.text;
        }else{
            dict[keyLeftMargin] = @(0);
        }
        if(self.columnSpacingTF.text){
            dict[keyColumnSpace] = self.columnSpacingTF.text;
        }else{
            dict[keyColumnSpace] = @(0);
        }
        
        self.collectionReloadBlock(dict);
    }
}

- (void)btnAction:(id)sender {
    if(self.btnBlock){
        self.btnBlock(sender);
    }
}

@end
