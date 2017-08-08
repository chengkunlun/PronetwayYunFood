//
//  datepickView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/24.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol datepickerDelegate <NSObject>

-(void)onpress:(NSString *)selectTime datepicker:(UIDatePicker *)datepicker;
-(void)onpressOkBtnClick;
-(void)onpressCanselBtnClick;

@end
@interface datepickView : UIView

@property (strong, nonatomic) UIDatePicker *datepicker;
@property (strong, nonatomic) id<datepickerDelegate>delegate;

@property (strong, nonatomic) UIButton *okbtn;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) UILabel *timelab;

@end
