//
//  JHTableViewCell.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/13.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "paidui_listModel.h"
@interface JHTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *lab1;
@property (strong, nonatomic) UILabel *lab2;
@property (strong, nonatomic) UILabel *lab3;
@property (strong, nonatomic) UILabel *lab4;
@property (strong, nonatomic) UILabel *lab5;


@property (strong, nonatomic) paidui_listModel *model;

@property (strong, nonatomic) UIView *cicrView;
@property (strong, nonatomic) UILabel * letterLab;//英文字母
@property (strong, nonatomic)UILabel *lab;

-(void)setSelected:(BOOL)selected animated:(BOOL)animated listModel:(paidui_listModel *)model;
@end
