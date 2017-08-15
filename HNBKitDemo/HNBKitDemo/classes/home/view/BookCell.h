//
//  BookCell.h
//  HanabiNoKioku
//
//  Created by 开发 on 2017/6/8.
//  Copyright © 2017年 程康. All rights reserved.
//


#import <BEMCheckBox.h>
static NSString *routeEventBookCheckChange = @"routeEventBookCheckChange";
static NSString *BookCheckChangeUserInfoKey = @"BookModel";

@interface BookModel:BaseTableModel
@property (nonatomic, assign) BOOL selected;
@property (nonatomic,strong) NSString *name;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSNumber *pages;
@end

@interface BookCell : BaseTableCell
@property (nonatomic,strong) BEMCheckBox *checkBox;
@property (nonatomic,strong) UILabel *nameLB;
@property (nonatomic,strong) UILabel *priceLB;
@end
