//
//  detailView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/26.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "detailView.h"
#import "ZLTimeBtn.h"
@implementation detailView

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
    
    NSArray *arr = @[@"充值金额",@"赠送金额",@"总送金额",@"",@"充值次数",@"已送金额",@"剩余金额"];
    CGFloat w = kWidth-30*newKwith;
    for (int i = 0; i<7; i++) {
        
        if (i == 3) {
            _ckltime = [[ZLTimeView alloc]initWithFrame:CGRectMake(15*newKwith, 15*newKhight+i*(59*newKhight), w, 44*newKhight) select:@""];
            _ckltime.backgroundColor = kCbgColor;
            _ckltime.delegate = self;
            [self addSubview:_ckltime];
           // return;
        }else {
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(15*newKhight, 15*newKhight+i*(59*newKhight),w , 44*newKhight)];
            bgView.backgroundColor = kCbgColor;
            bgView.layer.masksToBounds = YES;
            bgView.layer.cornerRadius = 5;
            [self addSubview:bgView];
            
            UIView *inputVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kWidth, 44*newKhight)];
            inputVC.backgroundColor = kWhiteColor;
            
            _inputLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
            _inputLab.font = kFont(15);
            //_inputLab.text = @"¥ ";
            _inputLab.textColor = kGreenColor;
            _inputLab.textAlignment = NSTextAlignmentCenter;
            [inputVC addSubview:_inputLab];
            
            
            UIButton *cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            cancelBtn.titleLabel.font = kFont(15);
            [cancelBtn setTitle:@"确定" forState:(UIControlStateNormal)];
            cancelBtn.frame = CGRectMake(kWidth-70*newKwith, 0, 50*newKhight, 44*newKhight);
            [cancelBtn addTarget:self action:@selector(DismissKeyboard) forControlEvents:(UIControlEventTouchUpInside)];
            [cancelBtn setTitleColor:kGreenColor forState:(UIControlStateNormal)];
            [inputVC addSubview:cancelBtn];
            
            UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(0, inputVC.height-1, kWidth, 1)];
            linVC.backgroundColor = kCbgColor;
            [inputVC addSubview:linVC];
            
            UITextField *T = [[UITextField alloc]initWithFrame:CGRectMake(0,0,w-70*newKwith, bgView.height)];
            T.clearButtonMode = 1;
            T.keyboardType = UIKeyboardTypeDecimalPad;
            T.font = kFont(15);
            if (i == 2) {
                T.enabled = YES;
                T.textColor = RGB(81, 81, 81);
            }else {
                T.textColor = rgba(155, 155, 155, 1);
                T.enabled = NO;
                
            }
            T.delegate = self;
            
            //[T addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            T.inputAccessoryView = inputVC;
            
            //T.borderStyle = UITextBorderStyleRoundedRect;
            T.tag = kYun_huiyuandetailTag+i;
            T.backgroundColor = kCbgColor;
            [bgView addSubview:T];
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w-15*newKwith, 44*newKhight)];
            lab.textColor = rgba(155, 155, 155, 1);
            lab.font = kFont(14);
            lab.textAlignment = NSTextAlignmentRight;
            lab.text = arr[i];
            [bgView addSubview:lab];
            
        }
    }
    
    [self addSubview:self.saveBtn];
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UITextField *T6 = (UITextField *)[self viewWithTag:kYun_huiyuandetailTag+6];
    if (textField == T6) {
        [self animateTextField: textField up: YES];
    }
   // _inputLab.text = @"";
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UITextField *T6 = (UITextField *)[self viewWithTag:kYun_huiyuandetailTag+6];
    if (textField == T6) {
        [self animateTextField: textField up: NO];
    }

}
- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80*newKhight; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.frame = CGRectOffset(self.frame, 0, movement);
    [UIView commitAnimations];
}




-(void)DismissKeyboard {

    UITextField *T = (UITextField *)[self viewWithTag:kYun_huiyuandetailTag];
    UITextField *T1 = (UITextField *)[self viewWithTag:kYun_huiyuandetailTag+1];
    UITextField *T2 = (UITextField *)[self viewWithTag:kYun_huiyuandetailTag+2];
    UITextField *T4 = (UITextField *)[self viewWithTag:kYun_huiyuandetailTag+4];
    UITextField *T5 = (UITextField *)[self viewWithTag:kYun_huiyuandetailTag+5];
    UITextField *T6 = (UITextField *)[self viewWithTag:kYun_huiyuandetailTag+6];

    [T resignFirstResponder];
    [T1 resignFirstResponder];
    [T2 resignFirstResponder];
    [T4 resignFirstResponder];
    [T5 resignFirstResponder];
    [T6 resignFirstResponder];

}
-(void)onpressBegBtnClick {

    [self DismissKeyboard];
}

-(void)onpressEndBtnClick {

    [self DismissKeyboard];
}

-(void)timeView:(ZLTimeView *)timeView seletedDateBegin:(NSString *)beginTime end:(NSString *)endTime {

    if (_delagate && [_delagate  respondsToSelector:@selector(showBegainTime:endStr:)]) {
        
        [_delagate showBegainTime:beginTime endStr:endTime];
        
    }
    
}

-(RedBtn *)saveBtn {

    if (!_saveBtn) {
        _saveBtn = [[RedBtn alloc]initWithFrame:CGRectMake(0, kHeight-kNavBarHAndStaBarH-44*newKhight, kWidth, 44*newKhight) text:@"保存"];
    }
    return _saveBtn;
}

-(void)setChongModel:(ChuiyuanModel *)ChongModel {

    UITextField *T = (UITextField *)[self viewWithTag:kYun_huiyuandetailTag];
    UITextField *T1 = (UITextField *)[self viewWithTag:kYun_huiyuandetailTag+1];
    UITextField *T2 = (UITextField *)[self viewWithTag:kYun_huiyuandetailTag+2];
    UITextField *T4 = (UITextField *)[self viewWithTag:kYun_huiyuandetailTag+4];
    UITextField *T5 = (UITextField *)[self viewWithTag:kYun_huiyuandetailTag+5];
    UITextField *T6 = (UITextField *)[self viewWithTag:kYun_huiyuandetailTag+6];
    
    T.text = [NSString stringWithFormat:@" ¥ %@",ChongModel.recharge];
    T1.text = [NSString stringWithFormat:@" ¥ %@",ChongModel.give];
    T2.text = [NSString stringWithFormat:@" ¥ %@",ChongModel.total];
    T4.text = [NSString stringWithFormat:@" 次数: %@",ChongModel.numb];
    T5.text = [NSString stringWithFormat:@" ¥ %@",ChongModel.givetotal];
    T6.text = [NSString stringWithFormat:@" ¥ %@",ChongModel.smoney];
    ZLTimeBtn *starbtn = (ZLTimeBtn *)[_ckltime viewWithTag:9150];
    ZLTimeBtn *endbtn = (ZLTimeBtn *)[_ckltime viewWithTag:9151];
    
    
    [starbtn setTitle:[ChongModel.startdate substringWithRange:NSMakeRange(0,10)] forState:(UIControlStateNormal)];
    [endbtn setTitle:[ChongModel.enddate substringWithRange:NSMakeRange(0,10)] forState:(UIControlStateNormal)];

}


@end
