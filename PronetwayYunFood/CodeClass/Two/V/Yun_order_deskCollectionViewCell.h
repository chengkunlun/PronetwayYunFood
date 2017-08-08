//
//  Yun_order_deskCollectionViewCell.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/15.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "kezhuoModel.h"
@interface Yun_order_deskCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic)UILabel *deskNumber;
@property (strong, nonatomic)UILabel *deskPeople;

@property (strong, nonatomic) kezhuoModel *model;

@property (strong, nonatomic) kezhuoModel *mangerModel;

@property (strong, nonatomic) kezhuoModel *dcsearchModel;

@property (strong, nonatomic) kezhuoModel *incomeModel;

@property (strong, nonatomic) kezhuoModel *incomeSearchModel;

@property (strong, nonatomic) UIImageView *okimage;

@end
