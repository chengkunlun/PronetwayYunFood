//
//  My_TableViewCell.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "my_listModel.h"
#import "my_retchModel.h"
@interface My_TableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *my_lb1;
@property (strong, nonatomic) UILabel *my_lb2;
@property (strong, nonatomic) UILabel *my_lb3;

@property (strong, nonatomic) my_listModel *cashModel;
@property (strong, nonatomic) my_listModel *onlinModel;
@property (strong, nonatomic) my_retchModel *retachModel;

@end
