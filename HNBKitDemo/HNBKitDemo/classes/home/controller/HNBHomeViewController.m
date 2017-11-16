//
//  HNBHomeViewController.m
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/31.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "HNBHomeViewController.h"
#import "HomeCell.h"

static NSString *const g_listName = @"simpleListName";
static NSString *const g_hasMoreKey = @"hasMoreKey";

@interface HNBHomeViewController ()<UITableViewDelegate>
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, assign) BOOL multiplyCheck;
@property (nonatomic, assign) NSInteger sourceDataCount;
@end

@implementation HNBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *listName = g_listName;
        NSDictionary *dict = [self callApiGetResponse];
        [self handleResponseData:dict listName:listName noMoreInFooterText:nil moreKey:g_hasMoreKey];
    });
}

- (NSDictionary*)callApiGetResponse{
    self.sourceDataCount = 5;
    if(self.currentPage == 0){
        self.lastSelectedIndex = -1;
    }
    NSMutableArray *responseArray = [NSMutableArray array];
    NSString *listName = g_listName;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i<self.sourceDataCount ; i++) {
        [responseArray addObject:[self getModelByIndex:i]];
        dict[g_hasMoreKey] = i>=self.sourceDataCount-1? @(NO):@(YES);
    }
    dict[listName] = responseArray;
    return dict;
}

- (BaseTableModel*)getModelByIndex:(NSInteger)index{
    HomeModel *model = [[HomeModel alloc] init];
    switch (index) {
        case 0:
            model.name = [NSString stringWithFormat:@"%ld: %@",index,HNB_flowLayoutViewController];
            break;
        case 1:
            model.name = [NSString stringWithFormat:@"%ld: %@",index,HNB_TestResponderAndImageExtension];
            break;
        case 2:
            model.name = [NSString stringWithFormat:@"%ld: %@",index,@"远程调用的方式实现按钮动态化"];
            break;
        case 3:
            model.name = [NSString stringWithFormat:@"%ld: %@",index,@"头部圆球拉伸效果"];
            break;
        case 4:
            model.name = [NSString stringWithFormat:@"%ld: %@",index,@"hnbkit label"];
            break;
        default:
            break;
    }
    
    return model;
}

- (Class)cellClass{
    return [HomeCell class];
}

- (Class)modelClass{
    return [HomeModel class];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    UIViewController *vc = nil;
    switch (row) {
        case 0:{
            vc = [HNBBaseURLRouter viewControllerForUrl:HNB_flowLayoutViewController];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            vc = [HNBBaseURLRouter viewControllerForUrl:HNB_TestResponderAndImageExtension];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            vc = [HNBMediator testRouteConfigBtnVCForTitle:@"按钮动态化"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            vc = [HNBBaseURLRouter viewControllerForUrl:HNB_TestHeadCircleChangeScale];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:{
            [self.navigationController pushViewController:[HNBBaseURLRouter viewControllerForUrl:HNB_TestHNBLabelController] animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
