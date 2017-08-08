//
//  dianpuView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "dianpuView.h"

@implementation dianpuView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    [self addSubview:self.bootmVC];
}


-(UIView *)bootmVC {

    if (!_bootmVC) {
        
        CGFloat w = kWidth/2;
        _bootmVC = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight-kNavBarHAndStaBarH-44*newKhight, kWidth, 44*newKhight)];
        
        _bootmVC.backgroundColor = kWhiteColor;
        
        _kezhuobtn = [[RedBtn alloc]initWithFrame:CGRectMake(w, 0,w ,44*newKhight)text:@"客桌管理"];
        [_bootmVC addSubview:_kezhuobtn];
        
        _dybtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
        _dybtn.frame = CGRectMake(0, 0, w, 44*newKhight);
        _dybtn.layer.masksToBounds = YES;
        _dybtn.layer.borderColor = [kRedColor CGColor];
        _dybtn.layer.borderWidth = 0.5;
        [_bootmVC addSubview:_dybtn];
        [_dybtn setTitleColor:kRedColor forState:(UIControlStateNormal)];
        [_dybtn setTitle:@"打印该店二维码" forState:(UIControlStateNormal)];
        _dybtn.titleLabel.font = kFont(15);
    }
    
    
    return _bootmVC;
}


@end
