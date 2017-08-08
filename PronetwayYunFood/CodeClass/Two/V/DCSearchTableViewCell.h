//
//  DCSearchTableViewCell.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/7.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchModel.h"
@interface DCSearchTableViewCell : UITableViewCell


@property (strong, nonatomic) UILabel *fenquLb;
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UILabel *desknumber;
@property (strong, nonatomic) UILabel *setnum;
@property (strong, nonatomic) searchModel *model;

@property (strong, nonatomic) UIImageView *img;

@end
