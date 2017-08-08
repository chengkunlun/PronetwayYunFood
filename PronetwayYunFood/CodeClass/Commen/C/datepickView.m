//
//  datepickView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/24.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "datepickView.h"

@implementation datepickView

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
    
    _cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _cancelBtn.frame = CGRectMake(15*newKwith, 0, 50*newKwith, 44*newKhight);
    [_cancelBtn setTitleColor:kRedColor forState:(UIControlStateNormal)];
    _cancelBtn.titleLabel.font = kFont(15);
    [_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    _okbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _okbtn.frame = CGRectMake(self.width-65*newKwith, 0, 50*newKwith, 44*newKhight);
    [_okbtn setTitleColor:kRedColor forState:(UIControlStateNormal)];
    _okbtn.titleLabel.font = kFont(15);
    [_okbtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [self addSubview:_okbtn];
    [self addSubview:_cancelBtn];
    
    [_cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:(UIControlEventTouchUpInside)];
     [_okbtn addTarget:self action:@selector(okBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    _timelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 44*newKhight)];
    _timelab.textColor = kRedColor;
    _timelab.textAlignment = NSTextAlignmentCenter;
    _timelab.font  =kFont(16);
    [self addSubview:_timelab];
    
    _datepicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, _timelab.endY, kWidth, 216*newKhight)];
    NSLocale *l = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    _datepicker.locale = l;
    _datepicker.datePickerMode = UIDatePickerModeTime;
    [_datepicker addTarget:self action:@selector(selectTime:) forControlEvents:(UIControlEventValueChanged)];
    [self addSubview:_datepicker];
    
}
//选择时间
-(void)selectTime:(UIDatePicker *)datepicker {

    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    formate.dateFormat =@"HH:mm";
    NSString *str =  [formate stringFromDate:datepicker.date];
    DLog(@"%@",str);
    _timelab.text = str;
    if (_delegate && [_delegate respondsToSelector:@selector(onpress:datepicker:)]) {
        [_delegate onpress:str datepicker:datepicker];
    }
}
-(void)cancelBtn:(UIButton *)btn {

    if (_delegate && [_delegate respondsToSelector:@selector(onpressCanselBtnClick)]) {
        
        [_delegate onpressCanselBtnClick];
        
    }
    
    [self dismiss];
}

-(void)okBtn:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(onpressOkBtnClick)]) {
        
        [_delegate onpressOkBtnClick];
        
    }
    [self dismiss];
}

-(void)dismiss {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];

    
}


@end
