//
//  LoginAndRegisterViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "LoginAndRegisterViewController.h"
#import "LoginAndRegisterView.h"
@interface LoginAndRegisterViewController ()<LoginDelegate>
@property (strong, nonatomic) LoginAndRegisterView *logVC;
@end

@implementation LoginAndRegisterViewController

-(void)viewWillAppear:(BOOL)animated {

    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _logVC = [[LoginAndRegisterView alloc]initWithFrame:kBounds];
    _logVC.delegate = self;
   
    [self.view addSubview:_logVC];
    
    // Do any additional setup after loading the view.
}

//登录按钮点击事件
-(void)onpressForLogin:(NSString *)selectStr {

    if ([self checkForLogin]) {
        if ([selectStr isEqualToString:@"phoneLogin"]) {
            
            [self reloadJosnForphonelogin];
            
        }else {
        
            [self reloadjosnForLogin];

        }
    }
}

-(BOOL)checkForLogin {

    if (kStringIsEmpty(_logVC.userT.text)) {
        
        [self yaopai:_logVC.userT];
        return NO;
    }
    if (kStringIsEmpty(_logVC.passwordT.text)) {
        
        [self yaopai:_logVC.passwordT];

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

//请求数据
-(void)reloadjosnForLogin {

    [WSProgressHUD showWithStatus:@"正在登录 .."];
    
    NSString *urlstr = [NSString stringWithFormat:@"%@%@%@%@%@%@",kIpandPort,klogin1,_logVC.userT.text,klogin2,_logVC.passwordT.text,klogin3];
    DLog(@"登录的url是 %@",urlstr);
    
    [CKLRequestManger GET:urlstr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        DLog(@"登录的dic %@",dic);
        
        NSString *result = dic[@"result"];
        
        if ([result isEqualToString:@"0"]) {
            [WSProgressHUD dismiss];
            
            [UserDefaults setObjectleForStr:@"YES" key:kloginStatuekey];
            [UserDefaults setObjectleForStr:dic[@"pid"] key:kpid];//保存商家id
            [UserDefaults setObjectleForStr:dic[@"utype"] key:kutype];
#pragma mark -- 营业账号登录 --
//营业账号登录
            if ([dic[@"utype"]isEqualToString:@"1"]) {
                
                //营业员登录,保存他所在店铺对应的sid
                [UserDefaults setObjectleForStr:dic[@"groupid"] key:ksid];
                
            }
            //登录成功
            [kNotificationCenter postNotificationName:@"gotomain" object:nil];

        }else if ([result isEqualToString:@"2"]){
            [WSProgressHUD showImage:nil status:@"用户名或者密码错误"];
        }else if ([result isEqualToString:@"5"]){
            [WSProgressHUD showImage:nil status:@"用户名或者密码错误"];
        }
        else {
            [WSProgressHUD showImage:nil status:@"登录失败"];
        }
        
    } failure:^(NSError *error) {
        [WSProgressHUD dismiss];

        DLog(@"%@",error);
    }];
    
    
}


//效验验证码
-(void)reloadJosnForphonelogin{
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@",kIpandPort,kcheckCode1,_logVC.userT.text,kcheckCode2,_logVC.passwordT.text,kcheckCode4];
    DLog(@"手机号登录的 url 是 %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        DLog(@"手机号登录成功 %@",dic);
        
        if ([dic[@"result"] isEqualToString:@"0"]) {
            [UserDefaults setObjectleForStr:dic[@"pid"] key:kpid];
            [UserDefaults setObjectleForStr:@"YES" key:kloginStatuekey];
            //登录成功
            [kNotificationCenter postNotificationName:@"gotomain" object:nil];

        }else if ([dic[@"result"] isEqualToString:@"6"]) {
            [WSProgressHUD showImage:nil status:@"效验短信失败"];

        }else if ([dic[@"result"] isEqualToString:@"7"]) {
            [WSProgressHUD showImage:nil status:@"验证码为空"];
            
        }else if ([dic[@"result"]isEqualToString:@"11"]) {
            [WSProgressHUD showImage:nil status:@"该手机号未注册"];
            
        }else {
        
            [WSProgressHUD showImage:nil status:@"登录失败"];
        }
    } failure:^(NSError *error) {
        
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
