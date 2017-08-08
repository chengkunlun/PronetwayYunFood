//
//  LoginAndRegisterView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "LoginAndRegisterView.h"

@implementation LoginAndRegisterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{

    
    // 创建一个富文本对象
    _attributes = [NSMutableDictionary dictionary];
    // 设置富文本对象的颜色
    _attributes[NSForegroundColorAttributeName] = RGB(0x85, 0x85, 0x85);
    // 设置UITextField的占位文字

    
    _logbgimg = [[UIImageView alloc]initWithFrame:kBounds];
    _logbgimg.userInteractionEnabled = YES;
    _logbgimg.image = kimage(@"Yun_login_bg");
    [self addSubview:_logbgimg];
    
    
    _login_redcs = [[UIView alloc]initWithFrame:CGRectMake((kWidth-90*newKwith)/2, 104*newKhight, 90*newKwith, 90*newKhight)];
    _login_redcs.layer.masksToBounds = YES;
    _login_redcs.layer.cornerRadius = _login_redcs.height/2;
    _login_redcs.backgroundColor = RGB(246, 230, 233);
    [self addSubview:_login_redcs];
    
    _whcsimg = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth-61*newKwith)/2, 115*newKhight, 61*newKwith, 61*newKhight)];
    _whcsimg.image = kimage(@"Yun_login_shushi1");
    [self addSubview:_whcsimg];
    
    
//    _lb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _whcsimg.endY+16*newKhight, kWidth,   28*newKhight)];
//    _lb1.textAlignment = NSTextAlignmentCenter;
//    _lb1.textColor  =kRedColor;
//    _lb1.text = @"您的餐饮管家";
//    _lb1.font = kFont(12);
//    [self addSubview:_lb1];
    
   // [self addSubview:self.registerBtn];
    
    [_logbgimg addSubview:self.login_redhebgViewimg];
    
}

-(UIButton *)logbtn {
    
    if (!_logbtn) {
        _logbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _logbtn.frame = CGRectMake(20*newKwith+48*newKwith, 419*newKhight, 240*newKwith, 44*newKhight);
        [_logbtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        _logbtn.titleLabel.font = kBodlFont(16);
        _logbtn.layer.masksToBounds = YES;
        _logbtn.layer.cornerRadius = 5;
        [_logbtn setTitle:@"登 录" forState:(UIControlStateNormal)];
    
        [_logbtn addTarget:self action:@selector(logingBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        //[_XDBtn setImage:kimage(@"Yun_order_bottom") forState:(UIControlStateNormal)];
        [_logbtn setBackgroundImage:kimage(@"Yun_order_bottom") forState:(UIControlStateNormal)];
    }
    return _logbtn;
}

-(UIButton *)registerBtn {
    
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _registerBtn.frame = CGRectMake(123*newKwith, _logbtn.endY+10*newKhight, 130*newKwith, 28*newKhight);
        [_registerBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        _registerBtn.titleLabel.font = kBodlFont(12);
        [_registerBtn setTitle:@"暂无账号,点这里注册" forState:(UIControlStateNormal)];
        [_registerBtn setTitleColor:kGreenColor forState:(UIControlStateNormal)];
        [_registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];

        //[_XDBtn setImage:kimage(@"Yun_order_bottom") forState:(UIControlStateNormal)];
    }
    return _registerBtn;
}

-(UIButton *)forgetBtn {

    if (!_forgetBtn) {
                _forgetBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                _forgetBtn.frame = CGRectMake(241*newKwith, 355*newKhight, 70*newKwith, 26*newKhight);
                _forgetBtn.titleLabel.font = kBodlFont(12);
                [_forgetBtn setTitle:@"忘记密码?" forState:(UIControlStateNormal)];
                [_forgetBtn setTitleColor:kGreenColor forState:(UIControlStateNormal)];
                [_forgetBtn addTarget:self action:@selector(forgetBtnBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
            }
            return _forgetBtn;
}

-(UIButton *)phonloginBtn {
    
    if (!_phonloginBtn) {
        _phonloginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _phonloginBtn.frame = CGRectMake(58*newKwith, 355*newKhight, 90*newKwith, 26*newKhight);
        _phonloginBtn.titleLabel.font = kBodlFont(12);
        [_phonloginBtn setTitle:@"手机号登录" forState:(UIControlStateNormal)];
        [_phonloginBtn setTitleColor:kGreenColor forState:(UIControlStateNormal)];
        [_phonloginBtn addTarget:self action:@selector(phonloginBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _phonloginBtn;
}

-(UIImageView *)login_redhebgViewimg {

    if (!_login_redhebgViewimg) {
        
        
        _login_redhebgViewimg.userInteractionEnabled = YES;
        _login_redhebgViewimg = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth-280*newKwith)/2, 149*newKhight, 280*newKwith, 378*newKhight)];
        _login_redhebgViewimg.image = kimage(@"Yun_login_he");
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake((_login_redhebgViewimg.width-115*newKwith)/2, 61*newKhight, 115*newKwith, 28*newKhight)];
        lb.text = @"您的餐饮管理专家";
        lb.font = kFont(13);
        lb.textColor = kRedColor;
        [_login_redhebgViewimg addSubview:lb];
        
        _whcsimg.image = kimage(@"Yun_login_shushi1");
        
        _userimg = [[UIImageView alloc]initWithFrame:CGRectMake(30*newKwith, lb.endY+29*newKhight, 14*newKwith, 17*newKhight)];
        _userimg.image = kimage(@"Yun_login_user");
        [_login_redhebgViewimg addSubview:_userimg];
        
        UIImageView *password = [[UIImageView alloc]initWithFrame:CGRectMake(30*newKwith, _userimg.endY+36*newKhight, 14*newKwith, 17*newKhight)];
        password.image = kimage(@"Yun_login_password");
        [_login_redhebgViewimg addSubview:password];
        
        for (int i = 0; i<2; i++) {
            
            UIView *linvc = [[UIView alloc]initWithFrame:CGRectMake(20*newKwith, _userimg.endY+8*newKhight+i*(53), _login_redhebgViewimg.width-40*newKwith, 1)];
            linvc.backgroundColor = RGB(188, 188, 188);
            [_login_redhebgViewimg addSubview:linvc];
        }
        _userT = [[UITextField alloc]initWithFrame:CGRectMake(_userimg.endX+5*newKwith+48*newKwith, 260*newKhight, _login_redhebgViewimg.width-20*newKwith-_userimg.endX-5*newKwith, 30)];
        _userT.enabled = YES;
        //_userT.backgroundColor = kblackColor;
        _userT.clearButtonMode = 1;
        _userT.font = kFont(13);
       // [_userT becomeFirstResponder];
        _userT.keyboardType = UIKeyboardTypeDefault;
        [self addSubview:_userT];
        _userT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入用户名" attributes:_attributes];

       // [_userT canBecomeFirstResponder];

        
        _passwordT = [[UITextField alloc]initWithFrame:CGRectMake(_userimg.endX+5*newKwith+48*newKwith, _userT.endY+23*newKhight, _login_redhebgViewimg.width-20*newKwith-_userimg.endX-5*newKwith, 30*newKhight)];
        _passwordT.enabled = YES;
       // _passwordT.backgroundColor = kblackColor;
        _passwordT.clearButtonMode = 1;
        _passwordT.font = kFont(13);
        _passwordT.delegate = self;
        // [_userT becomeFirstResponder];
        _passwordT.keyboardType = UIKeyboardTypeDefault;
        _passwordT.secureTextEntry = YES;
        _passwordT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入密码" attributes:_attributes];

        [self addSubview:_passwordT];
        [self addSubview:self.logbtn];

        //[self addSubview:self.forgetBtn];
        [self addSubview:self.phonloginBtn];
        [self addSubview:self.registerBtn];
        [self addSubview:self.countDownCode];
    }
    
    return _login_redhebgViewimg;
}

-(STCountDownButton *)countDownCode {

    if (!_countDownCode) {
        _countDownCode = [[STCountDownButton alloc]initWithFrame:CGRectMake(231.5*newKwith,311.5*newKhight,80*newKwith,28*newKhight)];
        _countDownCode.titleLabel.font = [UIFont systemFontOfSize:13];
        [_countDownCode setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        [_countDownCode setTitleColor:kRedColor forState:(UIControlStateNormal)];
        [_countDownCode setSecond:60];
        _countDownCode.layer.masksToBounds = YES;
        _countDownCode.layer.cornerRadius = 5;
        _countDownCode.layer.borderColor = [kRedColor CGColor];
        _countDownCode.layer.borderWidth = 1;
        _countDownCode.hidden = YES;
         [_countDownCode addTarget:self action:@selector(getcode:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _countDownCode;
}

//设置个人信息布局
-(void)packupMiMa {
    
    _whcsimg.image = kimage(@"Yun_login_shezhi");
    _userimg.image = kimage(@"Yun_login_user");
    _countDownCode.hidden = YES;
    
    //光标选到设置用户名上
    [_userT becomeFirstResponder];
    
    _userT.text = @"";
    _passwordT.text = @"";
    _userT.keyboardType = UIKeyboardTypeDefault;
    _passwordT.keyboardType = UIKeyboardTypeDefault;
    
    [UIView animateWithDuration:0.5 animations:^{
        [_logbtn setTitle:@"开始使用" forState:(UIControlStateNormal)];
        _logbtn.frame = CGRectMake(20*newKwith+48*newKwith, 445*newKhight, 240*newKwith, 44*newKhight);
        _passwordT.size = CGSizeMake(_login_redhebgViewimg.width-20*newKwith-_userimg.endX-5*newKwith,30*newKhight);
        
    }];
    _userT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请设置您的用户名" attributes:_attributes];
    
    _passwordT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请设置您的密码" attributes:_attributes];
    [self addOkMiMa];
}

-(void)addOkMiMa {

    UIImageView *okimge = [[UIImageView alloc]initWithFrame:CGRectMake(_userimg.X, _userimg.endY+89*newKhight, 14*newKwith, 17*newKhight)];
    okimge.image = kimage(@"Yun_login_password");
    [_login_redhebgViewimg addSubview:okimge];
    
    _okT = [[UITextField alloc]initWithFrame:CGRectMake(_userimg.endX+5*newKwith+48*newKwith, _passwordT.endY+23*newKhight, _login_redhebgViewimg.width-20*newKwith-_userimg.endX-5*newKwith, 30*newKhight)];
    _okT.clearButtonMode = 1;
    _okT.font = kFont(13);
    _okT.delegate = self;
    _okT.secureTextEntry = YES;
    _okT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请再次确认您的密码" attributes:_attributes];

    [self addSubview:_okT];
    
    UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(20*newKwith, _userimg.endY+8*newKhight+2*(53), _login_redhebgViewimg.width-40*newKwith, 1)];
    linVC.backgroundColor = RGB(188, 188, 188);
    [_login_redhebgViewimg addSubview:linVC];
}
//获取验证码
-(void)getcode:(STCountDownButton *)btn {
    
    [self reloadJosnForYZM];
    [btn start];

    
}

#pragma mark ------                  按钮的点击事件  登录 注册                    ------
//登录
-(void)logingBtnClick:(UIButton *)btn {

   // [self addSubview:self.login_redhebgViewimg];
    
    if ([btn.titleLabel.text isEqualToString:@"登 录"]) {
        
        if ([self.selectStr isEqualToString:@"phoneLogin"]) {
            if (_delegate &&[_delegate respondsToSelector:@selector(onpressForLogin:)]) {
                
                [_delegate onpressForLogin:@"phoneLogin"];
            }
            
        }else {
            if (_delegate &&[_delegate respondsToSelector:@selector(onpressForLogin:)]) {
                
                [_delegate onpressForLogin:@""];
            }
        }
        
        DLog(@"登录..");
        
    }else if ([btn.titleLabel.text isEqualToString:@"注 册"]) {
    //注册按钮点击事件
        DLog(@"注册"); //注册成功以后去设置个人信息
        
        if ([self checkForregister]) {
            //获取验证码成功以后直接登录 ..
            [self reloadJosnForcheckYZM];
            //设置布局

        }
    }else if ([btn.titleLabel.text isEqualToString:@"开始使用"]) {
        //gotomain
        if ([self checkForbegainToUse]) {
            
            [self reloadJosnForSetuserInfo];

        }
    }
}
//没有暂无账号,点这里注册
-(void)registerBtnClick:(UIButton *)btn {
    
    _countDownCode.hidden = NO;
    _forgetBtn.hidden = YES;
    _phonloginBtn.hidden = YES;
    _registerBtn.hidden = YES;
    _userT.text = @"";
    _passwordT.text = @"";
    _userT.keyboardType = UIKeyboardTypePhonePad;
    _passwordT.keyboardType = UIKeyboardTypePhonePad;
    
    _passwordT.size = CGSizeMake(_login_redhebgViewimg.width-20*newKwith-_userimg.endX-5*newKwith-80*newKhight, 30*newKhight);
    
    [_logbtn setTitle:@"注 册" forState:(UIControlStateNormal)];
    _userimg.image = kimage(@"Yun_login_phone");
    _userT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入手机号" attributes:_attributes];
    _passwordT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入验证码" attributes:_attributes];
    
}

//忘记密码
-(void)forgetBtnBtnClick:(UIButton *)btn {

    
}


//手机号登录
-(void)phonloginBtnClick:(UIButton *)btn {

    self.selectStr = @"phoneLogin";
    [self packPhoneLlogin];
    
}
//设置手机号登录验证码 --
-(void)packPhoneLlogin {

    
    _countDownCode.hidden = NO;
    _forgetBtn.hidden = YES;
    _phonloginBtn.hidden = YES;
    _registerBtn.hidden = YES;
    _userT.text = @"";
    _passwordT.text = @"";
    _userT.keyboardType = UIKeyboardTypePhonePad;
    _passwordT.keyboardType = UIKeyboardTypePhonePad;
    
    _passwordT.size = CGSizeMake(_login_redhebgViewimg.width-20*newKwith-_userimg.endX-5*newKwith-80*newKhight, 30*newKhight);
    
    [_logbtn setTitle:@"登 录" forState:(UIControlStateNormal)];
    _userimg.image = kimage(@"Yun_login_phone");
    _userT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入手机号" attributes:_attributes];
    _passwordT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入验证码" attributes:_attributes];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self endEditing:YES];
}
//检测注册--验证码的
-(BOOL)checkForregister {

    if (kStringIsEmpty(_userT.text)) {
        [self yaopai:_userT];

        return NO;
    }
    if (kStringIsEmpty(_passwordT.text)) {
        [self yaopai:_passwordT];

        return NO;
    }
    if (![ValidateUtil checkTel:_userT.text]) {
        
        [WSProgressHUD showImage:nil status:@"手机号格式错误"];
        return NO;
    }
    return YES;
}

//开始使用
-(BOOL)checkForbegainToUse {

    if (kStringIsEmpty(_userT.text)) {
        [self yaopai:_userT];
        return NO;
    }
    if (kStringIsEmpty(_passwordT.text)) {
        [self yaopai:_passwordT];

        return NO;
    }
    if (kStringIsEmpty(_okT.text)) {
        [self yaopai:_okT];
        return NO;
    }
    if (![_passwordT.text isEqualToString:_okT.text]) {
        
        [WSProgressHUD showImage:nil status:@"两次输入密码不一致"];
        return NO;
    }
    return YES;
}

-(void)yaopai:(UITextField *)textfield {
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];     anim.duration = 0.2;
    anim.repeatCount = 2;
    anim.values = @[@-20, @20, @-20];
    [textfield.layer addAnimation:anim forKey:nil];
    
}


#pragma mark                --- 注册 ---
//注册
-(void)reloadjosnForRegister {

    
    
    
}
//注册成功之后设置个人信息----最后一步 设置个人信息
-(void)reloadJosnForSetuserInfo {

    [WSProgressHUD showWithStatus:@"正在登录 .."];
    NSString *urlstr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",kIpandPort,kregister1,kregister2,_userT.text,kregister3, _passwordT.text,kregister4,@"0",kregister5,kregister6,[UserDefaults objectForKeyStr:kuserid]];
    DLog(@"注册的url是 %@",urlstr);
    
    [CKLRequestManger GET:urlstr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        DLog(@"%@",dic);
        
        NSString *result = dic[@"result"];
        
        if ([result isEqualToString:@"0"]) {
            [WSProgressHUD dismiss];
            //注册成功,保存数据
            [UserDefaults setObjectleForStr:dic[@"pid"] key:kpid];
            
            [kNotificationCenter postNotificationName:@"gotomain" object:nil];
            [UserDefaults setObjectleForStr:@"YES" key:kloginStatuekey];
            
        }else if ([result isEqualToString:@"3"]){
            
            [WSProgressHUD showImage:nil status:@"用户名已存在"];
        }else {
            
            [WSProgressHUD showImage:nil status:@"注册失败"];
        }
        
    } failure:^(NSError *error) {
        [WSProgressHUD dismiss];
        
        DLog(@"%@",error);
    }];
}
-(void)reloadJosnForYZM{

    NSString *str;
    if ([self.selectStr isEqualToString:@"phoneLogin"]) {
        
     str = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kgetCode1,_userT.text,kgetCode2,kcheckCode4];
    }else {
        str  = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kgetCode1,_userT.text,kgetCode2,kgetCode3];
    }
    DLog(@"获取验证码的 url 是 %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
        [WSProgressHUD showImage:nil status:@"发送成功"];

        }else if ([dic[@"result"]isEqualToString:@"11"]) {
        
            [WSProgressHUD showImage:nil status:@"该手机号未注册!"];
            return ;
        }else if ([dic[@"result"]isEqualToString:@"11"]) {
            [WSProgressHUD showImage:nil status:@"该手机号已注册!"];
        }else {
            
            [WSProgressHUD showImage:nil status:@"获取验证码失败"];
        }
    } failure:^(NSError *error) {
        
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
    
}
//效验验证码
-(void)reloadJosnForcheckYZM{
    NSString *str;
    if ([self.selectStr isEqualToString:@"phoneLogin"]) {//手机登录
      str  = [NSString stringWithFormat:@"%@%@%@%@%@%@",kIpandPort,kcheckCode1,_userT.text,kcheckCode2,_passwordT.text,kcheckCode4];

    }else {//注册
        str  = [NSString stringWithFormat:@"%@%@%@%@%@%@",kIpandPort,kcheckCode1,_userT.text,kcheckCode2,_passwordT.text,kcheckCode3];
    }
    DLog(@"检测code的 url 是 %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        DLog(@"注册成功的字典是 %@",dic);
        
        if ([dic[@"result"] isEqualToString:@"0"]) {
            [UserDefaults setObjectleForStr:dic[@"id"] key:kuserid];
            [self packupMiMa];
        }else if ([dic[@"result"] isEqualToString:@"6"]) {
        
            [WSProgressHUD showImage:nil status:@"验证码错误"];
        }else if ([dic[@"result"] isEqualToString:@"7"]) {
            [WSProgressHUD showImage:nil status:@"验证码为空"];
            
        }else if ([dic[@"result"]isEqualToString:@"12"]) {
            [WSProgressHUD showImage:nil status:@"该手机号已经注册"];
            
        }
        else if ([dic[@"result"]isEqualToString:@"11"]) {
            [WSProgressHUD showImage:nil status:@"该手机号未注册"];
            
        }
    } failure:^(NSError *error) {
        
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
    
}

@end
