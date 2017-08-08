//
//  IncomeListViewController.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/14.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YunCalssViewController.h"

#import "kezhuoModel.h"
@interface IncomeListViewController : YunCalssViewController

@property (strong, nonatomic) kezhuoModel *model;
@property (strong, nonatomic) NSString *selectStr;
@property (strong, nonatomic) NSString *order;
@property (strong, nonatomic) NSString *allMoney;

@end
