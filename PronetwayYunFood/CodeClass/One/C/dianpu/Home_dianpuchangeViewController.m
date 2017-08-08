//
//  Home_dianpuchangeViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/24.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_dianpuchangeViewController.h"
#import "LoginAndRegisterViewController.h"
@interface Home_dianpuchangeViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) UITextField *oldT;
@property (strong, nonatomic) UITextField *newsT;
@property (strong, nonatomic) explainView *explainVC;

@end

@implementation Home_dianpuchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([self.selectStr isEqualToString:@"system"]) {
        [self setCustomerTitle:@"修改密码"];
        
    }else {
    
        [self setCustomerTitle:@"修改营业账户密码"];

    }
    
    self.view.backgroundColor = kCbgColor;
    
    [self.view addSubview:self.oldT];

    [self.view addSubview:self.explainVC];

    
    [self setupnavBar];
    
}

-(explainView *)explainVC {

    if (!_explainVC) {
        
        NSString *str ;
        if ([self.selectStr isEqualToString:@"system"]) {
            
            str = @"说明 :\n1.密码修改成功后,旧密码失效,需要重新登录一次.\n2.只有商家有权限修改商户密码!\n3.密码支持中文,数字或者两者组合,不支持特殊字符!";
        }else {
            str = @"说明 :1.建议密码长度大于6位.\n2.修改后请使用新密码登录!";
        }
        _explainVC = [[explainView alloc]initWithFrame:CGRectMake(15*newKwith, _newsT.endY+40*newKhight, kWidth-30*newKwith, 0) text:str];
    }
    return _explainVC;

}


-(void)setupnavBar {

    
    UIButton *ritBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    ritBtn.frame = CGRectMake(0, 0, 50*newKwith, 44*newKhight);
    [ritBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [ritBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    ritBtn.titleLabel.font = kFont(15);
    [ritBtn addTarget:self action:@selector(ritClick:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *baritem = [[UIBarButtonItem alloc]initWithCustomView:ritBtn];
    self.navigationItem.rightBarButtonItem = baritem;
}

-(UITextField *)oldT {

    if (!_oldT) {
        
        _oldT = [[UITextField alloc]initWithFrame:CGRectMake(15*newKwith, 15*newKhight, kWidth-30*newKwith, 44*newKhight)];
        _oldT.borderStyle = UITextBorderStyleRoundedRect;
        _oldT.backgroundColor = kWhiteColor;
        _oldT.clearButtonMode = 1;
        _oldT.font = kFont(15);
        if ([self.selectStr isEqualToString:@"system"]) {
            
            _oldT.placeholder = @"旧密码";
        }else {
            _oldT.placeholder = @"原营业账户密码";

        }
        _newsT = [[UITextField alloc]initWithFrame:CGRectMake(15*newKwith, _oldT.endY+15*newKhight, kWidth-30*newKwith, 44*newKhight)];
        _newsT.borderStyle = UITextBorderStyleRoundedRect;
        _newsT.backgroundColor = kWhiteColor;
        _newsT.clearButtonMode = 1;
        _newsT.font = kFont(15);
        _newsT.placeholder = @"新密码";
        [self.view addSubview:_newsT];
        
        _newsT.delegate = self;
        _oldT.delegate = self;

    }
    
    return _oldT;
}

-(void)ritClick:(UIButton *)btn {
    
    
    if ([self checkT]) {
        if ([self.selectStr isEqualToString:@"system"]) {//修改系统密码
            [self reloadJosnForchangepassworld];
            
        }else {//修改子账号密码
        
            [self reloadJosnForchangepassworld];
        }
        
        DLog(@"保存");
    }
    
}

-(BOOL)checkT {

    if (kStringIsEmpty(_oldT.text)) {
        [self yaoBai:_oldT];
        return NO;
    }
    if (kStringIsEmpty(_newsT.text)) {
        [self yaoBai:_newsT];
        return NO;
    }
    return YES;
}

-(void)yaoBai:(UITextField *)textfield {
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.duration = 0.2;
    anim.repeatCount = 2;
    anim.values = @[@-20, @20, @-20];
    [textfield.layer addAnimation:anim forKey:nil];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}

-(void)reloadJosnForchangepassworld {

    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",kIpandPort,kchangeuserPsssword1,[UserDefaults objectForKeyStr:kuserid],kchangeuserPsssword2,self.model.username,kchangeuserPsssword3,_oldT.text,kchangeuserPsssword4,_newsT.text];
    
   DLog(@"修改子账号密码 : %@",url);
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"]isEqualToString:@"0"]) {
            [WSProgressHUD showImage:nil status:@"修改成功"];
            if ([self.selectStr isEqualToString:@"system"]) {
                
                LoginAndRegisterViewController *logVC = [LoginAndRegisterViewController new];
                [self.navigationController pushViewController:logVC animated:YES];
                return ;
            }

            [self.navigationController popViewControllerAnimated:YES];
        }else if ([dic[@"result"]isEqualToString:@"3"]) {
            [WSProgressHUD showImage:nil status:@"账号与密码不匹配"];
        }
        
    } failure:^(NSError *error) {
    
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
