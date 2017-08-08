//
//  Order_XDAlertView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface Order_XDAlertView : UIView
@property (strong, nonatomic) UILabel *Alert_deskNumber;

@property (strong, nonatomic) UIImageView *Alert_greenimg;
@property (strong, nonatomic) UIImageView *Alert_zanimg;
@property (strong, nonatomic) UILabel *Alert_XDLB;
@property (strong, nonatomic) UILabel *Alert_tisi;
@property (strong, nonatomic) UIButton *Alert_checkBtn;

-(void)show;
@end
