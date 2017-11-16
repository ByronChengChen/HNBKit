//
//  TestHNBLabelController.m
//  HNBKitDemo
//
//  Created by 程康 on 2017/11/16.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "TestHNBLabelController.h"

@interface TestHNBLabelController ()
@property (nonatomic, weak) IBOutlet UILabel *edgeLabel;
@property (nonatomic, weak) IBOutlet UITextField *top;
@property (nonatomic, weak) IBOutlet UITextField *bottom;
@property (nonatomic, weak) IBOutlet UITextField *left;
@property (nonatomic, weak) IBOutlet UITextField *right;
@end

@implementation TestHNBLabelController
+ (void)load {
    hnbRouterRegistUrlForViewcontroller(HNB_TestHNBLabelController, self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSData *testData = [NSData dataWithContentsOfFile:@"/Users/chengkang/Desktop/productList"];
    NSDictionary *testDict = [NSJSONSerialization JSONObjectWithData:testData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *testContentDict = testDict[@"Content"];
    HNBEdgeInsets *edge = [HNBEdgeInsets mj_objectWithKeyValues:testContentDict];
    [self.edgeLabel setHNBEdgeInsets:UIEdgeInsetsMake(edge.top, edge.left, edge.bottom, edge.right)];
//    [self.edgeLabel setHNBEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)resetInsetAction:(id)sender {
    [self.edgeLabel setHNBEdgeInsets: UIEdgeInsetsMake(self.top.text.floatValue, self.left.text.floatValue, self.bottom.text.floatValue, self.right.text.floatValue)];
    [self.edgeLabel sizeToFit];
    [self.edgeLabel setNeedsLayout];
    [self.edgeLabel setNeedsDisplay];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.edgeLabel setNeedsDisplay];
//        [self.edgeLabel setNeedsLayout];
//    });
    
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
