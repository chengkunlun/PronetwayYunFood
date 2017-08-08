//
//  Home_jiaohao.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/18.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_jiaohao.h"
@implementation Home_jiaohao



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    
   // [self addBtn];
    
    [self addSubview:self.JHTabview];
    
    _NextBtn = [[RedBtn alloc]initWithFrame:CGRectMake(0, kHeight-kNavBarHAndStaBarH-44*newKhight, kWidth, 44*newKhight) text:@"下一桌"];
    [self addSubview:_NextBtn];
}

-(UITableView *)JHTabview {

    if (!_JHTabview) {
        _JHTabview = [[UITableView alloc]initWithFrame:CGRectMake(15*newKwith, 15*newKhight, kWidth-30*newKwith, kHeight-kNavigationBarH-44*newKhight-30*newKhight) style:(UITableViewStylePlain)];
        _JHTabview.backgroundColor = kWhiteColor;
        [_JHTabview registerClass:[JHTableViewCell class] forCellReuseIdentifier:@"jiaohaocell"];
        _JHTabview.rowHeight = 140*newKhight;
        _JHTabview.backgroundColor = kCbgColor;
        _JHTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _JHTabview;
}

-(void)addBtn {

    _xiaoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _xiaoBtn.frame = CGRectMake((kWidth-244*newKwith)/2, 40*newKhight, 244*newKwith, 134*newKhight);
    [_xiaoBtn setBackgroundImage:kimage(@"Yun_home_JH_xiao") forState:(UIControlStateNormal)];
    [_xiaoBtn setTitleColor:kyellowcolor forState:(UIControlStateNormal)];
    [_xiaoBtn setTitle:@"小桌" forState:(UIControlStateNormal)];
    
    [self addSubview:_xiaoBtn];
    
    _zhongBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _zhongBtn.frame = CGRectMake((kWidth-244*newKwith)/2,_xiaoBtn.endY+20*newKhight, 245*newKwith, 134*newKhight);
    [_zhongBtn setBackgroundImage:kimage(@"Yun_home_JH_zhong") forState:(UIControlStateNormal)];
    [_zhongBtn setTitleColor:kGreenColor forState:(UIControlStateNormal)];
    [_zhongBtn setTitle:@"中桌" forState:(UIControlStateNormal)];
    [self addSubview:_zhongBtn];
    
    _daBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _daBtn.frame = CGRectMake((kWidth-345*newKwith)/2, 20*newKhight+_zhongBtn.endY, 345*newKwith, 134*newKhight);
    [_daBtn setBackgroundImage:kimage(@"Yun_home_JH_da") forState:(UIControlStateNormal)];
    [_daBtn setTitleColor:kBlueColor forState:(UIControlStateNormal)];
    [_daBtn setTitle:@"大桌" forState:(UIControlStateNormal)];
    [self addSubview:_daBtn];
    
    _xiaoBtn.titleLabel.font = kFont(23);
    _zhongBtn.titleLabel.font = kFont(23);
    _daBtn.titleLabel.font = kFont(23);

    [_xiaoBtn addTarget:self action:@selector(xiaoClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_zhongBtn addTarget:self action:@selector(zhongClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_daBtn addTarget:self action:@selector(daClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)xiaoClick:(UIButton *)btn {

   [_daBtn setBackgroundImage:kimage(@"Yun_home_JH_da") forState:(UIControlStateNormal)];
   [_zhongBtn setBackgroundImage:kimage(@"Yun_home_JH_zhong") forState:(UIControlStateNormal)];
   [_xiaoBtn setBackgroundImage:kimage(@"Yun_home_JH_xiao_select") forState:(UIControlStateNormal)];
    
    [_xiaoBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [_zhongBtn setTitleColor:kGreenColor forState:(UIControlStateNormal)];
    [_daBtn setTitleColor:kBlueColor forState:(UIControlStateNormal)];
    
}

-(void)zhongClick:(UIButton *)btn {
    
    [_daBtn setBackgroundImage:kimage(@"Yun_home_JH_da") forState:(UIControlStateNormal)];
    [_zhongBtn setBackgroundImage:kimage(@"Yun_home_JH_zhong_select") forState:(UIControlStateNormal)];
    [_xiaoBtn setBackgroundImage:kimage(@"Yun_home_JH_xiao") forState:(UIControlStateNormal)];
    [_xiaoBtn setTitleColor:kyellowcolor forState:(UIControlStateNormal)];
    [_zhongBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [_daBtn setTitleColor:kGreenColor forState:(UIControlStateNormal)];
    
}
-(void)daClick:(UIButton *)btn {
    
    [_daBtn setBackgroundImage:kimage(@"Yun_home_JH_da_select") forState:(UIControlStateNormal)];
    [_zhongBtn setBackgroundImage:kimage(@"Yun_home_JH_zhong") forState:(UIControlStateNormal)];
    [_xiaoBtn setBackgroundImage:kimage(@"Yun_home_JH_xiao") forState:(UIControlStateNormal)];
    [_xiaoBtn setTitleColor:kyellowcolor forState:(UIControlStateNormal)];
    [_zhongBtn setTitleColor:kGreenColor forState:(UIControlStateNormal)];
    [_daBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
