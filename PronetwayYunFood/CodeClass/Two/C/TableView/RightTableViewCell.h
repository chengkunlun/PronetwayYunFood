//
//  RightTableViewCell.h
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Home_CaiPinModel.h"
@class FoodModel;

#define kCellIdentifier_Right @"RightTableViewCell"

@interface RightTableViewCell : UITableViewCell

@property (nonatomic, strong) FoodModel *model;

@property (strong, nonatomic) Home_CaiPinModel *caiPmodel;

@property (strong, nonatomic) Home_CaiPinModel *DCcaiPmodel;


@property (strong, nonatomic) UIButton *addBtn;
@property (strong, nonatomic) UIButton *reduceBtn;

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;


@property (nonatomic) UILabel *numberLab;


@end
