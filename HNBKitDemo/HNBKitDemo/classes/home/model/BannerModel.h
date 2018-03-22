//
//  BannerModel.h
//  HNBKitDemo
//
//  Created by 程康 on 2018/3/21.
//  Copyright © 2018年 开发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject
@property (nonatomic, strong) NSString *ImageUrl;
@property (nonatomic, assign) BOOL *NeedLogin;
@property (nonatomic, strong) NSString *LinkUrl;
@property (nonatomic, strong) NSString *CityIds;
@property (nonatomic, strong) NSString *Title;

@end
