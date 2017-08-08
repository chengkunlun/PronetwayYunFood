//
//  HuiyuanTableViewCell.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/17.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HorizonGap 15
#define TilteBtnGap 10
#define ColorRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface HuiyuanTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *sectionimgView;
@property (strong, nonatomic) UILabel *lb1;
@property (strong, nonatomic) UILabel *lb2;
@property (strong, nonatomic) UILabel *lb3;
@property (strong, nonatomic) UILabel *lb4;
@property (strong, nonatomic) UILabel *lb5;
@property (strong, nonatomic) UILabel *lb6;
@property (strong, nonatomic) UILabel *lb7;
@property (strong, nonatomic) UILabel *lb8;
@property (strong, nonatomic) UILabel *lb9;
@property (strong, nonatomic) UILabel *lb10;
@property (strong, nonatomic) UILabel *lb11;
@property (strong, nonatomic) UILabel *lb12;

@property (strong, nonatomic) UIButton *changkeBtn;
@property (strong, nonatomic) UIButton *huiyuanBtn;
@property (strong, nonatomic) UIButton *vipBtn;


@property (nonatomic, strong)UIButton *SelectIconBtn;
@property (nonatomic,assign)BOOL isSelected;
-(void)UpdateCellWithState:(BOOL)select;

@end
