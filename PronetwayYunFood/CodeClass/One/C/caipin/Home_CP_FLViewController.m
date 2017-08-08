//
//  Home_CP_FLViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/18.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_CP_FLViewController.h"

@interface Home_CP_FLViewController ()
@property (strong, nonatomic) RedBtn *SaveBtn;
@property (strong, nonatomic) UITextField *inputT;
@property ( nonatomic) BOOL isSave;

@end

@implementation Home_CP_FLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.inputT];

    if ([self.selectstr isEqualToString:@"添加分类"]) {
        
        [self setCustomerTitle:@"添加分类"];
        _inputT.placeholder = @"菜品分类 ,例如热销";


    }else if ([self.selectstr isEqualToString:@"客桌分区"]) {
    
        [self setCustomerTitle:@"新增分区"];
        _inputT.placeholder = @"分区名称 ,例如A";
        
    }
    else if ([self.selectstr isEqualToString:@"修改客桌分区"]) {
        
        [self setCustomerTitle:@"修改分区"];
        _inputT.text = self.kezhuofenqumodel.name;
    }
    else {
        [self setCustomerTitle:@"修改分类"];
        _inputT.text = self.styModel.name;
    }
    
    [self.view addSubview:self.SaveBtn];
    
    // Do any additional setup after loading the view.
}

-(void)backAction {
    
    if ([self.selectstr isEqualToString:@"添加分类"]) {
        
        
    }else if ([self.selectstr isEqualToString:@"客桌分区"]) {
    
    }else {
    
        //通知left刷新数据
        [kNotificationCenter postNotificationName:@"gunleft" object:nil];

    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(UITextField *)inputT {

    if (!_inputT) {
        _inputT = [[UITextField alloc]initWithFrame:CGRectMake(15*newKwith, 20*newKhight, kWidth-30*newKwith, 44*newKhight)];
        _inputT.borderStyle = 3;
        if ([self.selectstr isEqualToString:@"添加分类"]||[self.selectstr isEqualToString:@"客桌分区"]) {
            
            [_inputT becomeFirstResponder];
        }
        _inputT.backgroundColor = kCbgColor;
    }
    
    return _inputT;
}

-(RedBtn *)SaveBtn {

    if (!_SaveBtn) {
        _SaveBtn = [[RedBtn alloc]initWithFrame:CGRectMake(0,kHeight-44*newKhight-kNavBarHAndStaBarH, kWidth, 44*newKhight)text:@"保 存"];
        [_SaveBtn addTarget:self action:@selector(savebtn:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _SaveBtn;
}
-(void)savebtn:(UIButton *)btn {

    if ([self.selectstr isEqualToString:@"添加分类"]) {
        if ([self checkT]) {
            
            NetworkManger *manger = [NetworkManger new];
            [manger addCaipinstyle:_inputT.text];
            manger.Addkezuofenqusuccessblock = ^{
                //添加菜品种类
                [UserDefaults setObjectleForStr:@"YES" key:kshowCaiPstyle];
                
                [self.navigationController popViewControllerAnimated:YES];
            };
        }
        DLog(@"添加菜品分类");
    } else if ([self.selectstr isEqualToString:@"客桌分区"]){
    
        DLog(@"客桌分区");
        if ([self checkT]) {
            
            NetworkManger *manger = [NetworkManger new];
            [manger reloadJosnForaddkezhuofenqu:_inputT.text];
            manger.Addkezuofenqusuccessblock = ^{
                //添加客桌分区成功,取消蒙板
                [UserDefaults setObjectleForStr:@"YES" key:kshowkezhuomanagerfenqu];
                [self.navigationController popViewControllerAnimated:YES];
            };
            
        }
        
    }else if ([self.selectstr isEqualToString:@"修改客桌分区"]) {
    
        
        NetworkManger *manger = [NetworkManger new];
        [manger reloadJosnForchangekezhuofenqu:self.kezhuofenqumodel input:_inputT.text];
        
        manger.Addkezuofenqusuccessblock = ^{
            
            [self.navigationController popViewControllerAnimated:YES];
        };

    }
    else {

        
        if ([self checkT]) {
            
            NetworkManger *manger = [NetworkManger new];
            [manger changeCaipinStyle:self.styModel name:_inputT.text];
            
            manger.Addkezuofenqusuccessblock = ^{
                
                [self.navigationController popViewControllerAnimated:YES];
            };
            
        }
        DLog(@"修改分类");
    }
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}




-(BOOL)checkT {
    
    if (kStringIsEmpty(_inputT.text)) {
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];     anim.duration = 0.2;
        anim.repeatCount = 2;
        anim.values = @[@-20, @20, @-20];
        [_inputT.layer addAnimation:anim forKey:nil];
        return NO;
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
