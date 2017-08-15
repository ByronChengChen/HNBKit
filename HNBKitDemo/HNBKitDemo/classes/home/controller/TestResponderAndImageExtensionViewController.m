//
//  TestResponderAndImageExtensionViewController.m
//  HNBKitDemo
//
//  Created by 开发 on 2017/8/1.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "TestResponderAndImageExtensionViewController.h"
#import "UIImage+HNBExtension.h"
#import "UIColor+HNBColor.h"

static NSString * const routerButtonAction = @"routerButtonAction";

@interface TestResponderAndImageExtensionViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *routerButton;
@end

@implementation TestResponderAndImageExtensionViewController

+ (void)load {
    hnbRouterRegistUrlForViewcontroller(HNB_TestResponderAndImageExtension,self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *changeImageColorBtn = [UIButton buttonWithText:@"changeColor" textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:12] backgroundColor:nil radius:5];
    [self.view addSubview:changeImageColorBtn];
    [changeImageColorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, 20, 80, 0));
        make.height.equalTo(@(44));
        make.width.equalTo(@(80));
    }];
    [changeImageColorBtn addTarget:self action:@selector(imageChangeColor) forControlEvents:UIControlEventTouchDown];

    self.imageView = ({
        UIImageView *imageView = [UIImageView new];
        [self.view addSubview:imageView];
        imageView.image = [UIImage hnb_imageWithColor:[UIColor greenColor]];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(changeImageColorBtn);
            make.bottom.equalTo(changeImageColorBtn.mas_top).offset(-40);
            make.width.height.equalTo(@(80));
        }];
        imageView;
    });
    
    self.routerButton = ({
        UIButton *routerButton = [UIButton buttonWithText:@"responder" textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:12] backgroundColor:nil radius:5];
        [self.view addSubview:routerButton];
        [routerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 80, 20));
            make.height.equalTo(@(44));
            make.width.equalTo(@(80));
        }];
        [routerButton addTarget:self action:@selector(buttonResponder) forControlEvents:UIControlEventTouchDown];
        routerButton;
    });
    
}

- (void)imageChangeColor{
    self.imageView.image = [UIImage hnb_imageWithColor:[UIColor randomColor]];
}

- (void)buttonResponder{
    [self.routerButton routerEventWithName:routerButtonAction userInfo:@{@"userInfo":@(1)}];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    NSLog(@"%@:%@",eventName,userInfo);
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
