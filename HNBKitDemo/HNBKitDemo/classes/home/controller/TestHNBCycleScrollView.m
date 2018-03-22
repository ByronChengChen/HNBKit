//
//  TestHNBCycleScrollView.m
//  HNBKitDemo
//
//  Created by 程康 on 2018/3/21.
//  Copyright © 2018年 开发. All rights reserved.
//

#import "TestHNBCycleScrollView.h"
#import "BannerModel.h"

@interface TestHNBCycleScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger counter;
@property (nonatomic, strong) NSMutableArray <BannerModel *>*bannerModelList;
@end

@implementation TestHNBCycleScrollView

+ (void)load{
    hnbRouterRegistUrlForViewcontroller(HNB_TestHNBCycleScrollView,[self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.tabBarItem.image = [UIImage imageNamed:@"tab_icon_1"];
    self.navigationController.tabBarItem.title = @"首页";
    [self loadData];
    [self designScrollView];
    [self designImagesInScrollView];
    [self startPlayHNBCycleView];
}

#pragma mark - 懒加载

- (NSArray<BannerModel *> *)bannerModelList
{
    if (!_bannerModelList) {
        _bannerModelList = [NSMutableArray array];
    }
    return  _bannerModelList;
}

- (void)startPlayHNBCycleView{
    if(self.timer)
        return;
    self.timer = ({
        NSTimer *timer;
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(autoPlayAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        timer;
    });
}

- (void)stopPlayHNBCycleView{
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)loadData{
    //测试数据
    NSData *testData = [NSData dataWithContentsOfFile:@"/Users/chengkang/Desktop/testHomeInit"];
    NSDictionary *testDict = [NSJSONSerialization JSONObjectWithData:testData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *testContentDict = testDict[@"Content"];
    NSMutableArray <BannerModel *>* tempBannerModelList = [NSMutableArray array];
    tempBannerModelList = [BannerModel mj_objectArrayWithKeyValuesArray:testContentDict[@"SliderList"]];
    if(tempBannerModelList.count > 0){
        [self.bannerModelList addObject:tempBannerModelList.lastObject];
        [self.bannerModelList addObjectsFromArray:tempBannerModelList];
        [self.bannerModelList addObject:tempBannerModelList.firstObject];
    }
}

- (void)designScrollView{
    self.scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.scrollsToTop = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        //TODO: chengk 轮播图 1 给scrollView一张默认的图片
        [self.view addSubview:scrollView];
        scrollView.backgroundColor = [UIColor redColor];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0 ));
            make.width.equalTo(self.view);
            make.height.equalTo(@(132));
        }];
        scrollView.contentSize = CGSizeMake(IPHONE_WIDTH*self.bannerModelList.count, 132);
        scrollView;
    });
}

- (void)designImagesInScrollView{
    NSMutableArray <UIImageView *>*imageViews = [NSMutableArray array];
    for (int i = 0; i<self.bannerModelList.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageViews addObject:imageView];
        imageView.backgroundColor = [UIColor randomColor];
        [self.scrollView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView);
            make.width.equalTo(@(IPHONE_WIDTH));
            make.height.equalTo(self.scrollView.mas_height);
            make.left.equalTo(self.scrollView).offset(i*IPHONE_WIDTH);
        }];
        NSURL *url = [NSURL URLWithString:self.bannerModelList[i].ImageUrl];
        [imageView sd_setImageWithPreviousCachedImageWithURL:url placeholderImage:[UIImage hnb_imageWithColor:[UIColor grayColor]] options:SDWebImageRetryFailed progress:nil completed:nil];
    }
}

- (void)autoPlayAction{
    NSLog(@"%ld",self.counter++);
    NSInteger counter = self.counter;
    [self.scrollView setContentOffset:CGPointMake((counter)*IPHONE_WIDTH, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(self.scrollView.contentOffset.x >= IPHONE_WIDTH * (self.bannerModelList.count-1)){
        self.counter = 1;
        [self.scrollView setContentOffset:CGPointMake(1*IPHONE_WIDTH, 0)];
    }
    if(self.scrollView.contentOffset.x <=0){
        if(self.bannerModelList.count -2 >0){
            [self.scrollView setContentOffset:CGPointMake(IPHONE_WIDTH * (self.bannerModelList.count-2),0)];
            self.counter = self.bannerModelList.count - 2;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopPlayHNBCycleView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startPlayHNBCycleView];
}

@end
