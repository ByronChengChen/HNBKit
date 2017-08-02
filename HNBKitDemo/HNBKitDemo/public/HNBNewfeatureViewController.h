//
//  HNBNewfeatureViewController.h
//  HanabiNoKioku
//
//  Created by 程康 on 16/3/3.
//  Copyright © 2016年 程康. All rights reserved.
//

#import "HNBBaseViewController.h"

@interface HNBNewfeatureViewController : HNBBaseViewController

typedef void(^FinishShowNewFeatureBlock)(void);

@property (nonatomic,copy) FinishShowNewFeatureBlock finishShowNewFeatureBlock;

@end
