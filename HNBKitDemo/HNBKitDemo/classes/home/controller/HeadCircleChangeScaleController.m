//
//  HeadCircleChangeScaleController.m
//  HNBKitDemo
//
//  Created by 程康 on 2017/8/17.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "HeadCircleChangeScaleController.h"
#import "HNBBaseTableViewController+HeadCircleChangeScale.h"

@interface HeadCircleChangeScaleController ()
@property (nonatomic, strong) UIView *headView;
@end

@implementation HeadCircleChangeScaleController

+ (void)load {
    hnbRouterRegistUrlForViewcontroller(HNB_TestHeadCircleChangeScale,self);
}

- (void)viewDidLoad {
    self.tableViewShouldNotLoadFirstTimeFlag = YES;
    [super viewDidLoad];
    self.tableView.tableHeaderView = [self createHeadView];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circleImage"]];
//    [self customerNavigationBarTitleViewWithView:imageView length:120];
    [self customerNavigationBarTitleViewWithView:imageView length:120 titleText:@"titleName" titleColor:[UIColor redColor] titleFont:[UIFont boldSystemFontOfSize:14] innerCircleSpace:6 circleWidth:1 circleColor:[UIColor greenColor]];
    // Do any additional setup after loading the view from its nib.
}

- (UIView *)createHeadView{
    self.headView = ({
        UIView *headView = [UIView new];
        headView.backgroundColor = [UIColor greenColor];
        headView.frame = CGRectMake(0, 0, IPHONE_WIDTH, 100);
        headView;
    });
    self.navigationController.navigationBar.translucent = NO;
    return self.headView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    NSLog(@"scrollView.contentOffset.y:%f\n",scrollView.contentOffset.y);
    NSLog(@"currentOffsetY:%f",currentOffsetY);
    if(currentOffsetY > 0){
        if(currentOffsetY <= 100 && currentOffsetY >= 0){
            CGFloat precent = (currentOffsetY - 0)/100;
            [self updateScaleWithPrecent:precent];
        }
    }
    [self setCurrentOffset:scrollView.contentOffset.y limitY:80];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
