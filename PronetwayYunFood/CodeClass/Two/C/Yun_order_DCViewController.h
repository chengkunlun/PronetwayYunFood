//
//  Yun_order_DCViewController.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/15.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YunCalssViewController.h"
#import "kezhuoModel.h"
#import "searchModel.h"
@interface Yun_order_DCViewController : YunCalssViewController

@property (nonatomic) NSInteger index;
@property (strong, nonatomic) kezhuoModel *model;
@property (strong, nonatomic) searchModel *searchModel;
@property (strong, nonatomic) NSString *selectStr;

@end
