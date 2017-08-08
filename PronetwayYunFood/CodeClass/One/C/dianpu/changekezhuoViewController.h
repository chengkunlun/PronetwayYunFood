//
//  changekezhuoViewController.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YunCalssViewController.h"
#import "kezhuoModel.h"
#import "kezhuofenquModel.h"
@interface changekezhuoViewController : YunCalssViewController

@property (strong, nonatomic) UIView *bootmVC;
@property (strong, nonatomic) UIButton *dybtn;
@property (strong, nonatomic) RedBtn *kezhuobtn;
@property (strong, nonatomic) UILabel *lab;

@property (strong, nonatomic) NSMutableArray *kezhuoArr;
@property (strong, nonatomic) NSString *selectStr;
@property (strong, nonatomic) kezhuoModel *kezhuoModel;
@property (strong, nonatomic) kezhuofenquModel *model;


@end
