//
//  LoginAndRegisterView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCountDownButton.h"

@protocol LoginDelegate <NSObject>

-(void)onpressForLogin:(NSString *)selectStr;//登录
-(void)onpressForregister;//注册
-(void)onpressForbegainToUse;//开始使用

@end

@interface LoginAndRegisterView : UIView<UITextFieldDelegate>
@property (strong, nonatomic) UIImageView *logbgimg;
@property (strong, nonatomic) UIButton *logbtn;
@property (strong, nonatomic) UIButton *registerBtn;
@property (strong, nonatomic) UILabel *lb1;
@property (strong, nonatomic) UIImageView *whcsimg;

@property (strong, nonatomic)NSMutableDictionary *attributes;

@property (strong, nonatomic) UIImageView* login_redhebgViewimg;
@property (strong, nonatomic) UIView *login_redcs;
@property (strong, nonatomic) UIImageView* login_redimg;
@property (strong, nonatomic) UITextField *userT;
@property (strong, nonatomic) UITextField *passwordT;
@property (strong, nonatomic)UIImageView *userimg;
@property (strong, nonatomic) UIButton *phonloginBtn;
@property (strong, nonatomic) UIButton *forgetBtn;

@property (strong, nonatomic) UITextField *okT;

@property (nonatomic, strong)STCountDownButton *countDownCode; //验证码

@property (strong, nonatomic) id<LoginDelegate>delegate;

@property (strong, nonatomic) NSString *selectStr;

@end
