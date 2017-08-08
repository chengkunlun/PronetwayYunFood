//
//  ShaixuanTableViewCell.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/21.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShaixuanTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *shaixuanimg;
@property (nonatomic, strong)UIButton *SelectIconBtn;
@property (nonatomic,assign)BOOL isSelected;
-(void)UpdateCellWithState:(BOOL)select;
@end
