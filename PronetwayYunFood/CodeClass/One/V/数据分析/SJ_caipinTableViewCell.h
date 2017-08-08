//
//  SJ_caipinTableViewCell.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaiPsticsModel.h"
@interface SJ_caipinTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *shujuimg;
@property (strong, nonatomic) UILabel *lab1;
@property (strong, nonatomic) UILabel *lab2;
@property (strong, nonatomic) UILabel *lab3;
@property (strong, nonatomic) UILabel *lab4;
@property (strong, nonatomic) UILabel *lab5;

@property (strong, nonatomic)CaiPsticsModel *model;

-(void)loadModel:(CaiPsticsModel *)model index:(NSInteger)index;

@end
