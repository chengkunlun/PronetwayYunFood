//
//  ListTableViewCell.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/31.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Home_CaiPinModel.h"


@interface ListTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) Home_CaiPinModel *model;
@property (strong, nonatomic) UILabel *numberLab;
@property (strong, nonatomic) UIButton *reduceBtn;
@property (strong, nonatomic) UIButton *addBtn;
@property (strong, nonatomic) UILabel *priceLab;


@end
