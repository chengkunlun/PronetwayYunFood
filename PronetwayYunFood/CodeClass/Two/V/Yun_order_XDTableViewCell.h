//
//  Yun_order_XDTableViewCell.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/15.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDModel.h"
#import "incomeModel.h"
#import "mycountModel.h"
@interface Yun_order_XDTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *yunxdimg;

@property (strong, nonatomic) UILabel *lb1;
@property (strong, nonatomic) UILabel *lb2;
@property (strong, nonatomic) UILabel *lb3;
@property (strong, nonatomic) UILabel *lb4;

@property (strong, nonatomic) UIButton *jiabtn;
@property (strong, nonatomic) UIButton *jianBtn;

@property (strong, nonatomic) UIButton *xiadanbtn;

@property (strong, nonatomic) XDModel *model;

@property (strong, nonatomic) incomeModel *incModel;
@property (strong, nonatomic) mycountModel *mycountmodel;

@end
