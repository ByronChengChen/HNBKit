//
//  NSString+HNBService.h
//  HNBKitDemo
//
//  Created by 程康 on 2018/3/21.
//  Copyright © 2018年 开发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HNBService)
/**
 * 传入需要保留的小数位，返回字符串。并且去掉末尾的0.
 */
- (NSString *)eliminateZeroWithDouble:(NSInteger)integer;
@end
