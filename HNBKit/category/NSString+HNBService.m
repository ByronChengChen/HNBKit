//
//  NSString+HNBService.m
//  HNBKitDemo
//
//  Created by 程康 on 2018/3/21.
//  Copyright © 2018年 开发. All rights reserved.
//

#import "NSString+HNBService.h"

@implementation NSString (HNBService)

- (NSString *)eliminateZeroWithDouble:(NSInteger)integer {
    NSString *str = [self copy];
    double fdouble = [str doubleValue];
    NSString *ftotal;
    switch (integer) {
        case 1:
            ftotal = [NSString stringWithFormat:@"%.1f", fdouble];
            break;
        case 2:
            ftotal = [NSString stringWithFormat:@"%.2f", fdouble];
            break;
        case 3:
            ftotal = [NSString stringWithFormat:@"%.3f", fdouble];
            break;
        case 4:
            ftotal = [NSString stringWithFormat:@"%.4f", fdouble];
            break;
        case 5:
            ftotal = [NSString stringWithFormat:@"%.5f", fdouble];
            break;
        default:
            break;
    }
    while ([ftotal hasSuffix:@"0"]) {
        ftotal = [ftotal substringToIndex:[ftotal length]-1];
    }
    
    if ([ftotal hasSuffix:@"."]) {
        ftotal = [ftotal substringToIndex:[ftotal length]-1];
    }
    return ftotal;
}

@end
