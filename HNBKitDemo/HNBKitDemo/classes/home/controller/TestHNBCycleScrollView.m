//
//  TestHNBCycleScrollView.m
//  HNBKitDemo
//
//  Created by 程康 on 2018/3/21.
//  Copyright © 2018年 开发. All rights reserved.
//

#import "TestHNBCycleScrollView.h"

@interface TestHNBCycleScrollView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger counter;
@end

@implementation TestHNBCycleScrollView

+ (void)load{
    hnbRouterRegistUrlForViewcontroller(HNB_TestHNBCycleScrollView,[self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.translucent=NO;
    [self designScrollView];

//    if (@available(iOS 11.0, *)) {
//        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }else{
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    // Do any additional setup after loading the view.
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

- (void)autoPlayAction{
    NSLog(@"%ld",self.counter++);
}

- (void)designScrollView{
    self.scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:scrollView];
        scrollView.backgroundColor = [UIColor redColor];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0 ));
            make.width.equalTo(self.view);
            make.height.equalTo(@(132));
        }];
        scrollView;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
