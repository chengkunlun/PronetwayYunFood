//
//  Yun_MyView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MycommenView.h"
#import "ZLTimeView.h"
@interface Yun_MyView : UIView

@property (strong, nonatomic) UIView *my_topView;
@property (strong, nonatomic) MycommenView *my_leftView;
@property (strong, nonatomic) MycommenView *my_RightView;
@property (strong, nonatomic) MycommenView *my_top_leftView;
@property (strong, nonatomic) MycommenView *my_top_RightView;
@property (strong, nonatomic) MycommenView *my_middleView;


@property (strong, nonatomic) UIImageView *my_top_img;
@property (strong, nonatomic) UILabel *my_top_lb1;
@property (strong, nonatomic) UIButton *My_top_tixianBtn;

@property (strong, nonatomic) UIView *headerView;

@property (strong, nonatomic) UIView *historyView;
@property (strong, nonatomic) ZLTimeView *ckltime;

@end
