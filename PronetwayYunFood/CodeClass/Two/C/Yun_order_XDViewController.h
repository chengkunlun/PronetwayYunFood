//
//  Yun_order_XDViewController.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/15.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YunCalssViewController.h"
#import "kezhuoModel.h"
#import "XDModel.h"

@interface Yun_order_XDViewController : YunCalssViewController

@property (strong, nonatomic) NSString *AllPrice;
@property (strong, nonatomic) kezhuoModel *model;
@property (strong, nonatomic) NSMutableArray *selectArr;

@end
