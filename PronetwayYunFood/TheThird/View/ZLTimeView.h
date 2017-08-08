//
//  ZLTimeView.h
//  ZLAppointment
//
//  Created by ZL on 2017/6/19.
//  Copyright © 2017年 zhangli. All rights reserved.
//  自定义时间选择器视图

#import <UIKit/UIKit.h>
//#import "ZLTimeBtn.h"

@class ZLTimeView;


@protocol ZLTimeViewDelegate <NSObject>

/**
 *  时间选择器视图
 *
 *  @param beginTime           起始时间/开始时间
 *  @param endTime             终止时间按/结束时间
 *
 */
- (void)timeView:(ZLTimeView *)timeView seletedDateBegin:(NSString *)beginTime end:(NSString *)endTime;
-(void)onpressBegBtnClick;
-(void)onpressEndBtnClick;


@end

@interface ZLTimeView : UIView

@property (nonatomic, weak) id<ZLTimeViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame select:(NSString *)select;
//@property (strong, nonatomic)ZLTimeBtn *beginTimeBtn;
//@property (strong, nonatomic)ZLTimeBtn *endTimeBtn;
@property (strong, nonatomic) NSString *selectStr;
@end
