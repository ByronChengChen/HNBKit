//
//  NSNumber+Computation.h
//  Test
//
//  Created by 王全金 on 2017/11/20.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Computation)

/**加*/
- (NSNumber* (^)(NSNumber *))add;
/**减*/
- (NSNumber* (^)(NSNumber *))subtract;
/**乘*/
- (NSNumber* (^)(NSNumber *))multiplying;
/**除*/
- (NSNumber* (^)(NSNumber *))dividing;

@end
