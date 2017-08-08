//
//  FishMealView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/20.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "FishMealView.h"

@implementation FishMealView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{

    self.backgroundColor  =kWhiteColor;
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake((kWidth-82*newKwith)/2, 92*newKhight, 82*newKwith, 82*newKhight)];
    titleView.layer.masksToBounds = YES;
    titleView.layer.cornerRadius = titleView.size.height/2;
    titleView.layer.borderColor = [kGreenColor CGColor];
    titleView.layer.borderWidth = 1;
    [self addSubview:titleView];

    _okimg = [[UIImageView alloc]initWithFrame:CGRectMake((titleView.width-38*newKwith)/2, (titleView.height-30*newKhight)/2, 38*newKwith, 30*newKhight)];
    _okimg.image = kimage(@"Yun_income_ok");
    [titleView addSubview:_okimg];
    
    _moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(0, titleView.endY+10*newKhight, kWidth, 40*newKhight)];
    _moneyLab.textColor = kGreenColor;
    _moneyLab.textAlignment = NSTextAlignmentCenter;
    _moneyLab.font = kBodlFont(28);
    _moneyLab.text = @"¥ ";
    [self addSubview:_moneyLab];
    
    _moneysunbtitle = [[UILabel alloc]initWithFrame:CGRectMake(0, _moneyLab.endY, kWidth, 20*newKhight)];
    _moneysunbtitle.textColor = rgba(153, 153, 153, 1);
    _moneysunbtitle.textAlignment = NSTextAlignmentCenter;
    _moneysunbtitle.font = kFont(13);
    _moneysunbtitle.text = @"收银成功";
    [self addSubview:_moneysunbtitle];
    
    _fishMealBtn = [[RedBtn alloc]initWithFrame:CGRectMake((kWidth-180*newKwith)/2, _moneysunbtitle.endY+171*newKhight, 180*newKwith, 44*newKhight) text:@"此桌结束用餐"];
    _fishMealBtn.layer.masksToBounds = YES;
    _fishMealBtn.layer.cornerRadius = 5;
    [self addSubview:_fishMealBtn];
    
    _goonBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _goonBtn.frame = CGRectMake((kWidth-180*newKwith)/2, _fishMealBtn.endY+22*newKhight, 180*newKwith, 44*newKhight);
    _goonBtn.layer.borderColor = [kRedColor CGColor];
    _goonBtn.layer.borderWidth = 1;
    [_goonBtn setTitleColor:kRedColor forState:(UIControlStateNormal)];
    _goonBtn.titleLabel.font = kFont(16);
    [_goonBtn setTitle:@"此桌继续用餐" forState:(UIControlStateNormal)];
    _goonBtn.layer.masksToBounds = YES;
    _goonBtn.layer.cornerRadius = 5;
    [self addSubview:_goonBtn];
    
    
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
