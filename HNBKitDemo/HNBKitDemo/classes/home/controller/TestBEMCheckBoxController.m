//
//  TestBEMCheckBoxController.m
//  HanabiNoKioku
//
//  Created by 开发 on 2017/6/8.
//  Copyright © 2017年 程康. All rights reserved.
//

#import "TestBEMCheckBoxController.h"
#import "BookCell.h"
static NSString *const g_listName = @"simpleListName";
static NSString *const g_hasMoreKey = @"hasMoreKey";

@interface TestBEMCheckBoxController ()
//1 多选
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, assign) BOOL multiplyCheck;
@end

@implementation TestBEMCheckBoxController

+ (void)load {
    hnbRouterRegistUrlForViewcontroller(HNB_TestBEMCheckBox,self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.multiplyCheck = YES;
    // Do any additional setup after loading the view.
}

- (void)loadData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *listName = g_listName;
        NSDictionary *dict = [self callApiGetResponse];
        [self handleResponseData:dict listName:listName noMoreInFooterText:nil moreKey:g_hasMoreKey];
    });
}

- (NSDictionary*)callApiGetResponse{
    if(self.currentPage == 0){
        self.lastSelectedIndex = -1;
    }
    NSMutableArray *responseArray = [NSMutableArray array];
    NSString *listName = g_listName;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSInteger i = self.currentPage * self.pageSize; i<(self.currentPage + 1)*self.pageSize ; i++) {
        [responseArray addObject:[self getModelByIndex:i]];
        dict[g_hasMoreKey] = i>=35? @(NO):@(YES);
    }
    
    dict[listName] = responseArray;
    return dict;
}

- (BaseTableModel*)getModelByIndex:(NSInteger)index{
    
    BookModel *model = [[BookModel alloc] init];
    model.price = index %2 == 0 ? 1 : 2;
    model.name = [NSString stringWithFormat:@"name%ld",index];
    model.index = index;
    return model;
}

- (Class)cellClass{
    return [BookCell class];
}

- (Class)modelClass{
    return [BookModel class];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    if([eventName isEqualToString:routeEventBookCheckChange]){
        BookModel *selectedModel = userInfo[BookCheckChangeUserInfoKey];
        if(!self.multiplyCheck){
            if(self.lastSelectedIndex >= 0){
                BookModel *model = (BookModel *)self.dataArray[self.lastSelectedIndex];
                model.selected = !model.selected;
            }
        }
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.lastSelectedIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];

        self.lastSelectedIndex = selectedModel.index;
    }
}

@end
