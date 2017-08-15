//
//  RouteConfigBtnActionController.m
//  HNBKitDemo
//
//  Created by 程康 on 2017/8/15.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "RouteConfigBtnActionController.h"

@interface RouteConfigBtnActionController ()
@property (nonatomic, weak) IBOutlet UITextField *textField;
@end

@implementation RouteConfigBtnActionController

+ (void)load {
    hnbRouterRegistUrlForViewcontroller(HNB_TestRouteConfigBtn,self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.vcTitle;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(id)sender {
    NSString *urlStr = self.textField.text;
    //通过配置的url打开页面,url可以是h5页面地址，也可以是native注册的界面
    if([urlStr containsString:@"http"]){
        NSLog(@"file:%s,fun:%s,line:%d,open a web page",__FILE__ ,__func__,__LINE__);
    }else{
        //远程调用打开本地vc
    }
    //urlStr = @"hnb://test/route/config/btn?vcTitle=hnbTitle";
    UIViewController *vc = [HNBBaseURLRouter viewControllerForRemoteUrl:urlStr];
    if(vc){
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)endEdit{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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
