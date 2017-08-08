//
//  WiFiTableViewCell.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/23.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WiFiTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *wifiimg;
@property (strong, nonatomic) UIView *bootmView;
@property (strong, nonatomic) UILabel *lab1;
@property (strong, nonatomic) UILabel *lab2;
@property (strong, nonatomic) UILabel *lab3;

@property (strong, nonatomic) NSString *selectStr;

@end
