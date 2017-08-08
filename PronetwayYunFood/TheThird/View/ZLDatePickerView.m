//
//  ZLDatePickerView.m
//  ZLAppointment
//
//  Created by ZL on 2017/6/19.
//  Copyright © 2017年 zhangli. All rights reserved.
//

#import "ZLDatePickerView.h"

@interface ZLDatePickerView () 

// 取消按钮
//@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
// 确认按钮
//@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
// 时间选择器视图
@property (strong, nonatomic)UIButton *cancelBtn;
@property (strong, nonatomic) UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIView *fromView;

@end

@implementation ZLDatePickerView


-(void)pakeBtn:(UIButton *)btn text:(NSString *)text{

    [btn setTitleColor:kRedColor forState:(UIControlStateNormal)];
    [btn setTitle:text forState:(UIControlStateNormal)];
    btn.titleLabel.font = kFont(17);
    
    
}

- (void)awakeFromNib {
    

    
    //self.cancelBtn.layer.borderColor = RGB(153, 153, 153).CGColor; // 设置边框颜色
    //[self.cancelBtn.layer setBorderWidth:1.0];
    
    UIView *whiteVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
    whiteVC.backgroundColor = kWhiteColor;
    [self addSubview:whiteVC];


    _sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _sureBtn.frame = CGRectMake(kWidth-80*newKwith, 0, 60*newKwith, whiteVC.height);
    [_sureBtn addTarget:self action:@selector(makeSure:) forControlEvents:(UIControlEventTouchUpInside)];
    [self pakeBtn:_sureBtn text:@"确定"];
    
    _cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _cancelBtn.frame = CGRectMake(20*newKwith, 0, 60*newKwith, whiteVC.height);
    [_cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:(UIControlEventTouchUpInside)];
    [self pakeBtn:_cancelBtn text:@"取消"];
    
    [whiteVC addSubview:self.cancelBtn];
    [whiteVC addSubview:self.sureBtn];
    
}

+ (instancetype)datePickerView:(NSString *)str {
    
    ZLDatePickerView *picker = [[NSBundle mainBundle] loadNibNamed:@"ZLDatePickerView" owner:nil options:nil].lastObject;
    picker.backgroundColor = kCbgColor;
    picker.frame = CGRectMake(0, kHeight - 250*newKhight, kWidth, 250*newKhight);
    if ([str isEqualToString:@"my"]) {
        
        picker.maximumDate = [NSDate date];

    }else {
    
        picker.minimumDate = [NSDate date];

    }
    
    return picker;
}

- (void)showFrom:(UIView *)view {
    UIView *bgView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    bgView.backgroundColor = [UIColor lightGrayColor];
    bgView.alpha = 0.5;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [bgView addGestureRecognizer:tap];
    
    self.fromView = view;
    self.bgView = bgView;
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    [self dismiss];
}
- (void)cancel:(id)sender {
    [self dismiss];
}

- (void)makeSure:(id)sender {
    
    [self dismiss];
    
    NSDate *date = self.datePicker.date;
    
    if ([self.deleagte respondsToSelector:@selector(datePickerView:backTimeString:To:)]) {
        [self.deleagte datePickerView:self backTimeString:[self fomatterDate:date] To:self.fromView];
    }
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    self.datePicker.minimumDate = minimumDate;
}

- (void)setMaximumDate:(NSDate *)maximumDate {
    self.datePicker.maximumDate = maximumDate;
}

- (void)setDate:(NSDate *)date {
    self.datePicker.date = date;
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.bgView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (NSString *)fomatterDate:(NSDate *)date {
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    fomatter.dateFormat = @"yyyy-MM-dd";
    return [fomatter stringFromDate:date];
}

@end
