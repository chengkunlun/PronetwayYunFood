//
//  ZLTimeView.m
//  ZLAppointment
//
//  Created by ZL on 2017/6/19.
//  Copyright © 2017年 zhangli. All rights reserved.
//

#import "ZLTimeView.h"
#import "ZLDatePickerView.h"
#import "NSDate+ZLDateTimeStr.h"
#import "ZLTimeBtn.h"

@interface ZLTimeView () <ZLDatePickerViewDelegate>

@property (nonatomic, weak) ZLTimeBtn *beginTimeBtn;
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) ZLTimeBtn *endTimeBtn;
@property (nonatomic, weak) UIView *line;

@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
@end

@implementation ZLTimeView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubview];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame select:(NSString *)select {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectStr = select;
        [self setupSubview];
    }
    return self;
}

- (void)setupSubview {
    // 起始时间按钮
  ZLTimeBtn *beginTimeBtn  = [[ZLTimeBtn alloc] init];
    beginTimeBtn.backgroundColor = [UIColor clearColor];
    [beginTimeBtn addTarget:self action:@selector(beginTimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:beginTimeBtn];
    if ([self.selectStr isEqualToString:@"my"]) {
        
        beginTimeBtn.backgroundColor = kCbgColor;
    }else {
        
    [beginTimeBtn setTitle:@"营销开始时间" forState:(UIControlStateNormal)];
    
    }
    self.beginTimeBtn = beginTimeBtn;
    beginTimeBtn.tag = 9150;
    
    // 至label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"至";
    label.textColor = RGB(102, 102, 102);
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    self.label = label;
    [self addSubview:label];
    
    // 终止时间按钮
   ZLTimeBtn* endTimeBtn  = [[ZLTimeBtn alloc] init];
    [endTimeBtn addTarget:self action:@selector(endTimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.selectStr isEqualToString:@"my"]) {
        
        endTimeBtn.backgroundColor = kCbgColor;

    }else {
        [endTimeBtn setTitle:@"营销结束时间" forState:(UIControlStateNormal)];
    }
    self.endTimeBtn = endTimeBtn;
    endTimeBtn.tag = 9151;
    [self addSubview:endTimeBtn];
    
    if ([self.selectStr isEqualToString:@"my"]) {
    
        
    }else {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = RGB(204, 204, 204);
        self.line = line;
        [self addSubview:line];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if ([self.selectStr isEqualToString:@"my"]) {
        
        self.beginTimeBtn.frame = CGRectMake(25*newKwith, 0, 130*newKwith, self.height);
        self.label.frame = CGRectMake(CGRectGetMaxX(self.beginTimeBtn.frame)-15*newKwith, 0, self.width / 5, self.height);
        self.beginTimeBtn.layer.masksToBounds = YES;
        self.beginTimeBtn.layer.cornerRadius = 5;
        self.endTimeBtn.layer.masksToBounds = YES;
        self.endTimeBtn.layer.cornerRadius = 5;
        self.endTimeBtn.frame = CGRectMake(self.width-155*newKwith,0 , 130*newKwith, self.height);
    }else {
    
        self.beginTimeBtn.frame = CGRectMake(0, 0, self.width / 5.0 * 2, self.height);
        self.label.frame = CGRectMake(CGRectGetMaxX(self.beginTimeBtn.frame), 0, self.width / 5, self.height);
        self.endTimeBtn.frame = CGRectMake(CGRectGetMaxX(self.label.frame),0 , self.width / 5.0 * 2, self.height);
        self.line.frame = CGRectMake(0, self.height - 1, self.width, 1);
        
    }
    
   
}

#pragma mark - ZLDatePickerViewDelegate

- (void)beginTimeBtnClick:(UIButton *)btn {
    
    if (_delegate && [_delegate respondsToSelector:@selector(onpressBegBtnClick)]) {
        [_delegate onpressBegBtnClick];
    }
    
    if ([self.selectStr isEqualToString:@"my"]) {
    ZLDatePickerView *beginTimePV = [ZLDatePickerView datePickerView:@"my"];

    beginTimePV.date = [NSDate stringChangeTimeFormat:@"yyyy-MM-dd" string:btn.titleLabel.text];
        if (self.maxDate) {
            beginTimePV.maximumDate = self.maxDate;
        }
        
        beginTimePV.deleagte = self;
        [beginTimePV showFrom:btn];

    }else {
    
        ZLDatePickerView *beginTimePV = [ZLDatePickerView datePickerView:@""];
        if (self.maxDate) {
            beginTimePV.maximumDate = self.maxDate;
        }
        
        beginTimePV.deleagte = self;
        [beginTimePV showFrom:btn];

    }
}

- (void)endTimeBtnClick:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(onpressEndBtnClick)]) {
        [_delegate onpressEndBtnClick];
    }
    
    if ([self.selectStr isEqualToString:@"my"]) {
        ZLDatePickerView *endTimePV = [ZLDatePickerView datePickerView:@"my"];

        endTimePV.date = [NSDate stringChangeTimeFormat:@"yyyy-MM-dd" string:btn.titleLabel.text];
        if (self.minDate) {
            endTimePV.minimumDate = self.minDate;
        }
        endTimePV.deleagte = self;
        [endTimePV showFrom:btn];
    }else {
    
        ZLDatePickerView *endTimePV = [ZLDatePickerView datePickerView:@""];
        
        //endTimePV.date = [NSDate stringChangeTimeFormat:@"yyyy-MM-dd" string:btn.titleLabel.text];
        if (self.minDate) {
            endTimePV.minimumDate = self.minDate;
        }
        endTimePV.deleagte = self;
        [endTimePV showFrom:btn];
    }
    
}

- (void)datePickerView:(ZLDatePickerView *)pickerView backTimeString:(NSString *)string To:(UIView *)view {
    UIButton *btn = (UIButton *)view;
    if (btn == self.beginTimeBtn) {
        self.minDate = [NSDate stringChangeTimeFormat:@"yyyy-MM-dd" string:string];
    }
    if (btn == self.endTimeBtn) {
        self.maxDate = [NSDate stringChangeTimeFormat:@"yyyy-MM-dd" string:string];
    }
    
    [btn setTitle:string forState:UIControlStateNormal];
    
    if ([self.delegate respondsToSelector:@selector(timeView:seletedDateBegin:end:)]) {
        [self.delegate timeView:self seletedDateBegin:self.beginTimeBtn.titleLabel.text end:self.endTimeBtn.titleLabel.text];
    }
}

@end
