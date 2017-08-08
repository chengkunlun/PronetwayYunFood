//
//  cMoneyViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/14.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "cMoneyViewController.h"
#import "HGDQQRCodeView.h"
#import "FishMealViewController.h"
@interface cMoneyViewController ()

@property (strong, nonatomic) UIView *QRcodeView;
@property (strong, nonatomic) UILabel *lab1;
@property (strong, nonatomic) UILabel *lab2;
@property (strong, nonatomic) NSString *urlStr;

@property (strong, nonatomic) TimeManager *timanger;


@end

@implementation cMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"收款码"];
    
    self.view.backgroundColor = kWhiteColor;
    
    _urlStr = self.payUrl;
    
    [self.view addSubview:self.QRcodeView];
    
    [self.view addSubview:self.lab1];
    
    [self.view addSubview:self.lab2];

    
    self.timanger = [TimeManager pq_createTimerWithType:1 updateInterval:5 repeatInterval:1 update:^{
        
        
        
    }];

    
}

-(UIView *)QRcodeView {

    if (!_QRcodeView) {
        
        _QRcodeView = [[UIView alloc]initWithFrame:CGRectMake(30*newKwith, 80*newKhight, kWidth-60*newKwith, kWidth-60*newKwith)];
        [HGDQQRCodeView creatQRCodeWithURLString:_urlStr superView:self.QRcodeView logoImage:[UIImage imageNamed:@"1494828623"] logoImageSize:CGSizeMake(80*newKwith, 80*newKhight) logoImageWithCornerRadius:0];
        
    }
    return _QRcodeView;
}


-(UILabel *)lab1 {

    if (!_lab1) {
        _lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _QRcodeView.Y-30*newKhight, kWidth, 30*newKhight)];
        _lab1.text = @"正在打印并等待支付...";
        _lab1.textAlignment = NSTextAlignmentCenter;
        _lab1.font = kFont(16);
        _lab1.textColor = RGB(153, 153, 153);
        
    }
    return _lab1;
}


-(UILabel *)lab2 {
    
    if (!_lab2) {
        _lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, _QRcodeView.endY, kWidth, 30*newKhight)];
        _lab2.text = @"扫我付款";
        _lab2.font = kFont(13);
        _lab2.textAlignment = NSTextAlignmentCenter;
        _lab2.textColor = RGB(153, 153, 153);
        
    }
    return _lab2;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    FishMealViewController *fishVC = [FishMealViewController new];
    [self.navigationController pushViewController:fishVC animated:YES];
}

-(void)reloadjosnTogetorderresult {

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
