//
//  Yun_MyView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Yun_MyView.h"

@implementation Yun_MyView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}


-(void)addView{

    self.backgroundColor = kblackColor;//RGB(241, 241, 241);
    
    //历史
    [self addSubview:self.historyView];
    
    _my_topView = [[UIView alloc]initWithFrame:CGRectMake(15*newKwith, 15*newKhight, kWidth-30*newKwith, 143*newKhight)];
    _my_topView.backgroundColor = kWhiteColor;
    [self addSubview:_my_topView];
    
    _my_top_img = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth-58*newKwith)/2, 11*newKhight, 58*newKwith, 55*newKhight)];
    _my_top_img.image = kimage(@"Yun_my_jb");
    [_my_topView addSubview:_my_top_img];
    
    _my_top_lb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _my_top_img.endY+10*newKhight, kWidth, 34*newKhight)];
    _my_top_lb1.textColor = RGB(88, 88, 88);
    _my_top_lb1.textAlignment = NSTextAlignmentCenter;
    _my_top_lb1.font = kBodlFont(17);
    _my_top_lb1.text = @"当前余额 :¥";
    [_my_topView addSubview:_my_top_lb1];
    
    _My_top_tixianBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _My_top_tixianBtn.frame = CGRectMake((kWidth-50*newKwith)/2, _my_top_lb1.endY, 50*newKwith, 20*newKhight);
    [_My_top_tixianBtn setTitleColor:RGB(124, 174, 23) forState:(UIControlStateNormal)];
    [_My_top_tixianBtn setTitle:@"提现 >" forState:(UIControlStateNormal)];
    _My_top_tixianBtn.titleLabel.font = kFont(13);
    [_my_topView addSubview:_My_top_tixianBtn];
    
    //老板
    if ([ValidateUtil checkuserType]) {
        
        _my_leftView = [[MycommenView alloc]initWithFrame:CGRectMake(15*newKwith, _my_topView.endY+10*newKhight, 167*newKwith, 98*newKhight)];
        _my_leftView.backgroundColor = kBlueColor;
        _my_leftView.titleLb.text = @"¥ 暂无数据";
        _my_leftView.subtitlelab.text = @"充值";
        [self addSubview:_my_leftView];
        
        _my_RightView = [[MycommenView alloc]initWithFrame:CGRectMake(_my_leftView.endX+10*newKwith, _my_leftView.Y, _my_leftView.width, _my_leftView.height)];
        _my_RightView.backgroundColor = kyellowcolor;
        _my_RightView.titleLb.text = @"¥ ";
        _my_RightView.subtitlelab.text = @"提现";
        [self addSubview:_my_RightView];
        //营业额
         _my_middleView = [[MycommenView alloc]initWithFrame:CGRectMake(15*newKwith, _my_leftView.endY+10*newKhight, kWidth-30*newKhight, 143*newKhight)];

    }else {//营业员
     _my_middleView = [[MycommenView alloc]initWithFrame:CGRectMake(15*newKwith, _my_topView.endY+10*newKhight, kWidth-30*newKhight, 143*newKhight)];
        
    }
    _my_middleView.backgroundColor = kRedColor;
    _my_middleView.titleLb.text = @"¥ 暂无数据";
    _my_middleView.subtitlelab.text = @"营业额";
    [self addSubview:_my_middleView];
    
    _my_top_leftView = [[MycommenView alloc]initWithFrame:CGRectMake(15*newKwith, _my_middleView.endY+10*newKhight, 167*newKwith, 98*newKhight)];
    _my_top_leftView.backgroundColor = kpurplecolor;
    _my_top_leftView.titleLb.text = @"¥ 暂无数据";
    _my_top_leftView.subtitlelab.text = @"现金支付";

    [self addSubview:_my_top_leftView];
    
    _my_top_RightView = [[MycommenView alloc]initWithFrame:CGRectMake(_my_top_leftView.endX+10*newKwith, _my_middleView.endY+10*newKhight, _my_top_leftView.width, _my_top_leftView.height)];
    _my_top_RightView.titleLb.text = @"¥ 暂无数据";
    _my_top_RightView.subtitlelab.text = @"线上支付";
    _my_top_RightView.backgroundColor = kGreenColor;
    [self addSubview:_my_top_RightView];
    
   //[self addSubview:self.My_tab];
    //解析数据
   // [self reloadJosnForList];
    
}

-(UIView*)historyView {

    if (!_historyView) {
        
        _historyView = [[UIView alloc]initWithFrame:CGRectMake(15*newKwith, 15*newKhight, kWidth-30*newKwith, 143*newKhight)];
        _historyView.backgroundColor = kWhiteColor;
        [self addSubview:_historyView];
        UIImageView *timeimg = [[UIImageView alloc]initWithFrame:CGRectMake(125*newKwith, 20*newKhight, 23*newKwith, 23*newKhight)];
        timeimg.image = kimage(@"Yun_my_time");
        [_historyView addSubview:timeimg];

        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, _historyView.width, 23)];
        lab.textColor = RGB(81, 81, 81);
        lab.font = kFont(14);
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = @"时间";
        [_historyView addSubview:lab];
        _ckltime = [[ZLTimeView alloc]initWithFrame:CGRectMake(0, lab.endY+20, _historyView.width, 44*newKhight) select:@"my"];
        [_historyView addSubview:_ckltime];
        _historyView.hidden = YES;
    }
    
    return _historyView;
    
}


-(UIView *)headerView {

    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        _headerView.backgroundColor = kWhiteColor;
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10*newKwith, 0, kWidth, 44*newKhight)];
        lab.text = @"今日明细";
        lab.textColor = RGB(88, 88, 88);
        lab.font = kFont(13);
        [_headerView addSubview:lab];
        
        UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(0, 43, kWidth, 1)];
        linVC.backgroundColor = RGB(241, 241, 241);
        [_headerView addSubview:linVC];
    }
    return _headerView;
}


@end
