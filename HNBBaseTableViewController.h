//
//  HNBBaseTableViewController.h
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/31.
//  Copyright © 2017年 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

//引用到masonry,mjrefresh,mjextension

@protocol HNBBaseTableViewControllerDelegate <NSObject>

@required
- (Class)cellClass;
- (Class)modelClass;
- (void)loadData;
@end

@interface BaseTableModel:NSObject

@end

@interface BaseTableCell : UITableViewCell
@property (nonatomic, strong) BaseTableModel *model;
@end

@interface HNBBaseTableViewController : UIViewController
//使用代理的request指定model和cell的样式
@property (nonatomic, strong) Class cellClass;
@property (nonatomic, strong) Class modelClass;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) NSMutableArray <BaseTableModel*>*dataArray;
//首次禁止加载
@property (nonatomic, assign) BOOL tableViewShouldNotLoadFirstTimeFlag;

- (void)handleResponseData:(NSDictionary*)contentData listName:(NSString*)listName noMoreInFooterText:(NSString*)noMoreInFooterText moreKey:(NSString*)moreKey;
- (void)tableViewEndRefresh;
@end
