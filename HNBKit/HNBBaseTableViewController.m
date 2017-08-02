//
//  HNBBaseTableViewController.m
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/31.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "HNBBaseTableViewController.h"
static NSString *baseTableCellId = @"baseTableCell";

@interface BaseTableModel()
@end
@implementation BaseTableModel
@end


@interface BaseTableCell()
@end
@implementation BaseTableCell
@end



@interface HNBBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HNBBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp{
    self.currentPage = 0;
    self.pageSize = 20;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self lastPage];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self nextPage];
    }];
    //如果首次禁止加载被设置了，则首次不会加载，默认情况下是加载的
    if(!self.tableViewShouldNotLoadFirstTimeFlag){
        [self.tableView.mj_header beginRefreshing];
    }
}

#pragma mark -lazy load
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self.view);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return  _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return  _dataArray;
}

- (void)lastPage{
    self.currentPage = 0;
    [self loadData];
}

- (void)nextPage{
    [self loadData];
}

- (void)loadData{
    
}

#pragma mark - UIScrollViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSString *cellId = [self cellId];
    BaseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[self.cellClass alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.model = self.dataArray[row];
    return cell;
}

- (NSString*)cellId{
    return [NSString stringWithFormat:@"%@%@",baseTableCellId,[[self.cellClass class] description]];
}

#pragma mark -ck  处理数据
//服务器返回的content 转换成model数组
- (void)handleResponseData:(NSDictionary*)contentData listName:(NSString*)listName noMoreInFooterText:(NSString*)noMoreInFooterText moreKey:(NSString*)moreKey{
    [self tableViewEndRefresh];
    if(0 == self.currentPage){
        [self.dataArray removeAllObjects];
    }
    NSArray *newModelArray = [self.modelClass mj_objectArrayWithKeyValuesArray:contentData[listName]];
    [self.dataArray addObjectsFromArray:newModelArray];
    if(newModelArray && newModelArray.count > 0){
        self.currentPage ++;
        [self.tableView reloadData];
    }
    if(self.dataArray.count <= 0){
        self.tableView.mj_footer.hidden = YES;
        //TODO: chengk 这里将空白显示的动作抽出来，自定义。
//        [self showBlankPageNoData];
    }
    //TODO: chengk 这里面就必须要服务器传一个hasMore字段过来，没有必要这样强制要求，这里应该先判断是否有关键字moreKey，如果有moreKey的时候，就判断下value的真假，如果没有，判断list是否为空，为空就显示提示，同时中止掉index++的操作
    if(moreKey != nil){
        if(noMoreInFooterText == nil){
            self.tableView.mj_footer.hidden = ![contentData[moreKey] boolValue];
        }else{
            self.tableView.mj_footer.hidden = NO;
            if(![contentData[moreKey] boolValue]){
                [((MJRefreshAutoStateFooter*)(self.tableView.mj_footer)) setTitle:noMoreInFooterText forState:MJRefreshStateNoMoreData];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
    }
}

- (void)tableViewEndRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
