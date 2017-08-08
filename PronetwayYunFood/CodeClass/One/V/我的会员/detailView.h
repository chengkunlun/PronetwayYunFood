//
//  detailView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/26.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTimeView.h"
#import "ChuiyuanModel.h"
@protocol detailviewDelegate <NSObject>

-(void)showBegainTime:(NSString *)begainStr endStr:(NSString *)endStr;

@end

@interface detailView : UIView<UITextFieldDelegate,ZLTimeViewDelegate>
@property (strong, nonatomic) UILabel *inputLab;
@property (strong, nonatomic) RedBtn *saveBtn;
@property (strong, nonatomic) id<detailviewDelegate>delagate;
@property (strong, nonatomic) ZLTimeView *ckltime;
@property (strong, nonatomic) ChuiyuanModel *ChongModel;
@end
