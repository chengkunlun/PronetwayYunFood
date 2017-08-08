//
//  AddView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/13.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "AddView.h"

@implementation AddView

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
    
//    _name = [[UILabel alloc]initWithFrame:CGRectMake(15*newKwith, 44*newKhight, kWidth, 30*newKhight)];
//    _name.textColor = RGB(85, 85, 85);
//    _name.text = @"名称";
//    _name.font = kFont(15);
//    [self addSubview:_name];
//    
    _nameT = [[UITextField alloc]initWithFrame:CGRectMake(14*newKwith, 15*newKhight, kWidth-30*newKwith, 44*newKhight)];
    _nameT.clearButtonMode = 1;
    _nameT.placeholder = @"请输入名称";
    _nameT.font = kFont(14);
    _nameT.backgroundColor = kCbgColor;
    _nameT.borderStyle = UITextBorderStyleRoundedRect;
    _nameT.textColor = RGB(85, 85, 85);
    [self addSubview:_nameT];
    
//    _people = [[UILabel alloc]initWithFrame:CGRectMake(15*newKwith, _name.endY+14*newKhight, kWidth, 30*newKhight)];
//    _people.textColor = RGB(85, 85, 85);
//    _people.text = @"人数范围";
//    _people.font = kFont(15);
//    [self addSubview:_people];
    
    _StarT = [[UITextField alloc]initWithFrame:CGRectMake(14*newKwith, _nameT.endY+15*newKhight, 144*newKwith, 44*newKhight)];
    _StarT.clearButtonMode = 1;
    _StarT.placeholder = @"最少可坐人数";
    _StarT.keyboardType = UIKeyboardTypeDecimalPad;
    _StarT.borderStyle = UITextBorderStyleRoundedRect;
   // _StarT.layer.masksToBounds
    _StarT.font = kFont(14);
    _StarT.backgroundColor  =kCbgColor;
    _StarT.textColor = RGB(85, 85, 85);
    [self addSubview:_StarT];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(_StarT.endX + 5*newKwith, 23*newKhight+_StarT.Y, 47*newKwith, 1)];
    lb.backgroundColor = kblackColor;
    [self addSubview:lb];
    
    UILabel *tilb = [[UILabel alloc]initWithFrame:CGRectMake(_StarT.endX + 5*newKwith, _StarT.Y, 47*newKwith, 22*newKhight)];
    tilb.textColor = RGB(85, 85, 85);
    tilb.font = kFont(14);
    tilb.text = @"至";
    tilb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tilb];
    
    
    _EndT = [[UITextField alloc]initWithFrame:CGRectMake(lb.endX+5, _nameT.endY+15*newKhight, 144*newKwith, 44*newKhight)];
    _EndT.clearButtonMode = 1;
    _EndT.placeholder = @"最多可坐人数";
    _EndT.keyboardType = UIKeyboardTypeDecimalPad;
    _EndT.borderStyle = UITextBorderStyleRoundedRect;
    // _StarT.layer.masksToBounds
    _EndT.font = kFont(14);
    _EndT.backgroundColor  =kCbgColor;
    _EndT.textColor = RGB(85, 85, 85);
    [self addSubview:_EndT];

    
//    _daiHLab = [[UILabel alloc]initWithFrame:CGRectMake(15*newKwith, _people.endY+14*newKhight, kWidth, 30*newKhight)];
//    _daiHLab.textColor = RGB(85, 85, 85);
//    _daiHLab.text = @"代号";
//    _daiHLab.font = kFont(15);
//    [self addSubview:_daiHLab];
    
    _subTitle = [[UILabel alloc]init];
    _subTitle.frame = CGRectMake(14*newKwith, _StarT.endY, kWidth-30*newKwith, 30*newKhight);
    _subTitle.text =  @"(已存在区间(3,4),(5,6))";
    _subTitle.textColor = rgba(151, 151, 151, 1);
    _subTitle.font = kFont(13);
    _subTitle.numberOfLines = 0;
    [self addSubview:_subTitle];
    
    _selectVC = [[selectBtnView alloc]initWithFrame:CGRectMake(15*newKwith, _subTitle.endY+15*newKhight, kWidth-30*newKwith, 44*newKhight) text:@"客桌类型" color:kCbgColor];
    [self addSubview:_selectVC];
    
    _Savebtn = [[RedBtn alloc]initWithFrame:CGRectMake(0, kHeight-kNavBarHAndStaBarH-44*newKhight, kWidth, 44*newKhight) text:@"保存"];
    [self addSubview:_Savebtn];

//    _Btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    _Btn.frame = CGRectMake(15*newKwith, _subTitle.endY+15*newKhight, kWidth-30*newKwith, 44*newKhight);
//    _Btn.layer.masksToBounds = YES;
//    _Btn.layer.cornerRadius = 5;
//    _Btn.backgroundColor = kCbgColor;
//    
//    [_Btn setTitleColor:RGB(85, 85, 85) forState:(UIControlStateNormal)];
//    _Btn.titleLabel.font  =kFont(15);
//    [self addSubview:_Btn];
//    
//    _arrowimg = [[UIImageView alloc]initWithFrame:CGRectMake(_Btn.width-30*newKwith, 15*newKhight, 14*newKwith, 8*newKhight)];
//    _arrowimg.image = kimage(@"Yun_home_addCai_jiantou");
//    [_Btn addSubview:_arrowimg];
//    
   //
//    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(5*newKwith, 0, kWidth-30*newKwith, 44*newKhight)];
//    lab.textColor  = RGB(85, 85, 85);
//    lab.text = @"客桌类型";
//    lab.font = kFont(14);
//    [_Btn addSubview:lab];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self endEditing:YES];
}


@end
