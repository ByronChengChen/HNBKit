//
//  HNBFlowLayoutViewController.m
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/21.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "HNBFlowLayoutViewController.h"

#import <Masonry/Masonry.h>
#import "ChooseMonthCollectionCell.h"
#import "SimpleCollectionHeaderView.h"
#import "SimpleCollectionFooterView.h"

#import "HNBCollectoinHeader.h"

#define IPHONE_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define IPHONE_HEIGHT ([UIScreen mainScreen].bounds.size.height)


static NSString *g_collectionCell = @"g_collectionCell";
static NSString *g_simpleHeader = @"g_simpleHeader";
static NSString *g_simpleFooter = @"g_simpleFooter";


@interface HNBFlowLayoutViewController ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *monthStatisticsDataArray;
@property (nonatomic, assign) CGFloat columnSpactin;
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation HNBFlowLayoutViewController

+ (void)load {
    hnbRouterRegistUrlForViewcontroller(HNB_flowLayoutViewController,self);
}

//同一方法优先级： 子类方法>分类方法>父类方法
//+ (instancetype)instanceHNBViewController{
//    NSLog(@"file:%s,fun:%s,line:%d",__FILE__ ,__func__,__LINE__);
//    //这里是模拟用xib或者storyboard生成vc的情况，如果不是使用xib或者storyboard则可以将这个方法重写删除，使用分类UIViewController+HNBURLRouter的instanceHNBViewController方法就行了
//    ViewController *vc = [ViewController new];
//    vc.view.backgroundColor = [UIColor greenColor];
//    return vc;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self getCollectionView:CellAlignLeft];
    self.navigationController.navigationBar.translucent = NO;
}

- (UICollectionView *)getCollectionView:(CellAlignType)cellAlignType leftMargin:(CGFloat)leftMargin collectionColumnSpacing:(CGFloat)collectionColumnSpacing{
    CGFloat columnSpacing = 0;
    CGFloat itemWidth = 0;
    //4寸及以下屏幕
    if(IPHONE_WIDTH<=320){
        columnSpacing = 12;
        itemWidth = (IPHONE_WIDTH - 4*columnSpacing)/3;
    }else{
        itemWidth = 110;
        columnSpacing = (IPHONE_WIDTH - 3*itemWidth)/4;
    }
    self.columnSpactin = columnSpacing;
    HNBCollectionViewFlowLayout *flowLayout = [[HNBCollectionViewFlowLayout alloc] initWithCellAlignType:cellAlignType];
    if(collectionColumnSpacing >= 0 && leftMargin >= 0){
        flowLayout.leftMargin = leftMargin;
        flowLayout.columnSpace = collectionColumnSpacing;
    }
    // 设置最小行间距
    flowLayout.minimumLineSpacing = 12;
    // 设置布局的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide);
    }];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[ChooseMonthCollectionCell class] forCellWithReuseIdentifier:g_collectionCell];
    [collectionView registerClass:[SimpleCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:g_simpleHeader];
    
    [collectionView registerClass:[SimpleCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:g_simpleFooter];
    self.collectionView = collectionView;
    
    CGFloat headerHeight = 188;
    HNBCollectoinHeader *header = [[HNBCollectoinHeader alloc] init];
    [self.collectionView addSubview:header];
    header.backgroundColor = [UIColor grayColor];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView).offset(-headerHeight);
        make.left.equalTo(self.collectionView);
        make.width.equalTo(@(IPHONE_WIDTH));
        make.height.equalTo(@(headerHeight));
    }];
    header.btnBlock = ^(UIButton *btn) {
        [self.collectionView removeFromSuperview];
        if(1001 == btn.tag){
            self.collectionView = [self getCollectionView:CellAlignLeft];
            
//            UIViewController *vc = [HNBMediator flowLayoutViewControllerSimple];
//            [self.navigationController pushViewController:vc animated:YES];
        }else if(1002 == btn.tag){
            self.collectionView = [self getCollectionView:CellAlignCenter];
            
//            if(self.navigationController.viewControllers.count >= 2){
//                [self.navigationController popViewControllerAnimated:YES];
//            }
        }else{
            self.collectionView = [self getCollectionView:CellAlignRight];
        }
        [self.collectionView reloadData];
    };
    self.collectionView.contentInset = UIEdgeInsetsMake(headerHeight, 0, 0, 0);
    
    header.collectionReloadBlock = ^(NSDictionary *dict){
        [self.collectionView removeFromSuperview];
        
        [self getCollectionView:cellAlignType leftMargin:[dict[keyLeftMargin] floatValue] collectionColumnSpacing:[dict[keyColumnSpace] floatValue]];
    };
    if(!self.closeBtn){
        UIButton *closeBtn = [UIButton new];
        [closeBtn setTitle:@"close" forState:UIControlStateNormal];
        [self.view addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom).offset(-44);
            make.centerX.equalTo(self.view);
        }];
        
        [closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchDown];
        self.closeBtn = closeBtn;
    }
    [self.view bringSubviewToFront:self.closeBtn];
    return collectionView;
    
}

- (void)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UICollectionView *)getCollectionView:(CellAlignType)cellAlignType{
    return [self getCollectionView:cellAlignType leftMargin:-1 collectionColumnSpacing:-1];
}

- (void)loadData{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<10; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[kChooseMonthCount] = @(i+100).stringValue;
        NSInteger n = arc4random() % 10 + 1;
        dic[kCellWidth] = @(n*5 + 50);
        [array addObject:dic];
    }
    self.monthStatisticsDataArray = array;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.monthStatisticsDataArray.count;
    //    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ChooseMonthCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:g_collectionCell forIndexPath:indexPath];
    cell.dic = self.monthStatisticsDataArray[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = nil;
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:g_simpleHeader forIndexPath:indexPath];
    }else{
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:g_simpleFooter forIndexPath:indexPath];
    }
    return view;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={IPHONE_WIDTH,60};
    return size;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGSize size={IPHONE_WIDTH,130};
    return size;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.monthStatisticsDataArray[indexPath.row];
    return CGSizeMake([dic[kCellWidth] floatValue], 44);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
