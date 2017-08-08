//
//  ShujuView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleView.h"
@interface ShujuView : UIView

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *bootmView;
@property (strong, nonatomic) CircleView *circleView_one;
@property (strong, nonatomic) CircleView *circleView_two;
@property (strong, nonatomic) UILabel *toptitleLab;
@property (strong, nonatomic) UILabel *boomtitlemLab;
@property (strong, nonatomic) UIButton *calendarBtn;
@property (strong, nonatomic) UIImageView *boot;
@property (strong, nonatomic) UIImageView *Top;

@end
