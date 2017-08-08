//
//  Order_XDAlertView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Order_XDAlertView.h"
#define alertWeidth kWidth-66

@implementation Order_XDAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    self.backgroundColor = kWhiteColor;
    
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    UIView *huiVC = [[UIView alloc]initWithFrame:kBounds];
    huiVC.backgroundColor = kblackColor;
    huiVC.alpha = 0.8;
    [keywindow addSubview:huiVC];
    
    UIView *whbg = [[UIView alloc]initWithFrame:CGRectMake(66*newKwith, 149*newKhight, alertWeidth, 330*newKhight)];
    whbg.backgroundColor = kWhiteColor;
    [huiVC addSubview:whbg];
    
    _Alert_deskNumber = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,alertWeidth, 44*newKhight)];
    _Alert_deskNumber.textColor = [UIColor greenColor];
    _Alert_deskNumber.text = @"A001";
    _Alert_deskNumber.font = kFont(15);
    _Alert_deskNumber.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_Alert_deskNumber];
    
    UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(0, 44*newKhight, alertWeidth, 1)];
    linVC.backgroundColor = [UIColor greenColor];
    [self addSubview:linVC];
    
    
    
    
}

-(void)show {

    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    [keywindow addSubview:self];


    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
