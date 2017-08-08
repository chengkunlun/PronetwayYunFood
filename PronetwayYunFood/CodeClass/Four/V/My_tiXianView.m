//
//  My_tiXianView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "My_tiXianView.h"

@implementation My_tiXianView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
 
    self.backgroundColor = kCbgColor;
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(15*newKwith, 15*newKhight, kWidth-30*newKwith, 262*newKhight)];
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 3;
    _bgView.backgroundColor = kWhiteColor;
    [self addSubview:_bgView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _bgView.width, 44*newKhight)];
    topView.layer.masksToBounds = YES;
    topView.layer.borderColor = [kGreenColor CGColor];
    topView.layer.cornerRadius = 3;
    topView.layer.borderWidth = 1;
    [_bgView addSubview:topView];
    
    _My_lb1 = [[UILabel alloc]initWithFrame:CGRectMake(10*newKwith, 0, 80*newKwith, 42*newKhight)];
    _My_lb1.textColor= RGB(88, 88, 88);
    _My_lb1.text = @"到账银行卡";
    _My_lb1.font = kFont(14);
    [topView addSubview:_My_lb1];
    
    _My_lb2 = [[UILabel alloc]initWithFrame:CGRectMake(_My_lb1.endX+10*newKwith, 0,_bgView.width, 42*newKhight)];
    _My_lb2.textColor= kGreenColor;
    _My_lb2.text = @"建设银行 (8932)";
    _My_lb2.font = kFont(15);
    _My_lb2.textColor = kGreenColor;
    [topView addSubview:_My_lb2];
    
    _My_lb3 = [[UILabel alloc]initWithFrame:CGRectMake(10*newKwith, topView.endY, 120*newKwith, 28*newKhight)];
    _My_lb3.textColor= RGB(158, 158, 158);
    _My_lb3.text = @"提现金额";
    _My_lb3.font = kFont(12);
    [_bgView addSubview:_My_lb3];

    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(10, _My_lb3.endY, 15*newKwith, 44*newKhight)];
    lb.textColor = kblackColor;
    lb.text = @"¥";
    lb.font = kBodlFont(18);
    [_bgView addSubview:lb];
    
    _my_input = [[UITextField alloc]initWithFrame:CGRectMake(lb.endX, _My_lb3.endY, _bgView.width-20*newKwith, 44*newKhight)];
    //_my_input.backgroundColor = kblackColor;
    _my_input.font = kBodlFont(18);
    [_my_input becomeFirstResponder];
    _my_input.keyboardType = UIKeyboardTypeDecimalPad;
    [_bgView addSubview:_my_input];
    
    UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(10*newKwith, _my_input.endY, _bgView.width-20*newKwith, 1)];
    linVC.backgroundColor = kCbgColor;
    [_bgView addSubview:linVC];
    
    _My_Allbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _My_Allbtn.frame = CGRectMake(_bgView.width-110*newKwith, _my_input.Y+1*newKhight, 100*newKwith, 30*newKhight);
    _My_Allbtn.layer.masksToBounds = YES;
    _My_Allbtn.layer.cornerRadius = 5;
    _My_Allbtn.layer.borderColor = [kGreenColor CGColor];
    _My_Allbtn.layer.borderWidth = 1;
    _My_Allbtn.titleLabel.font = kFont(14);
    [_My_Allbtn setTitleColor:kGreenColor forState:(UIControlStateNormal)];
    [_My_Allbtn setTitle:@"全部提现" forState:(UIControlStateNormal)];
    [_bgView addSubview:_My_Allbtn];
    
    _My_lb4 = [[UILabel alloc]initWithFrame:CGRectMake(10*newKwith, linVC.endY+5*newKhight, 120*newKwith, 28*newKhight)];
    _My_lb4.textColor= RGB(168, 168, 168);
    _My_lb4.text = @"账户余额 8.22 ¥";
    _My_lb4.font = kFont(12);
    [_bgView addSubview:_My_lb4];
    
    
    [_bgView addSubview:self.my_tixianBtn];
    
}

-(UIButton *)my_tixianBtn {
    
    if (!_my_tixianBtn) {
        _my_tixianBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _my_tixianBtn.frame = CGRectMake(0, _bgView.height-44*newKhight, _bgView.width, 44*newKhight);
        [_my_tixianBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        _my_tixianBtn.titleLabel.font = kBodlFont(16);
        [_my_tixianBtn setTitle:@"提 现" forState:(UIControlStateNormal)];
        //[_XDBtn setImage:kimage(@"Yun_order_bottom") forState:(UIControlStateNormal)];
        [_my_tixianBtn setBackgroundImage:kimage(@"Yun_order_bottom") forState:(UIControlStateNormal)];
    }
    return _my_tixianBtn;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self endEditing:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
