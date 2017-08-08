//
//  Home_paiduiViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_paiduiViewController.h"
#import "Home_paihao.h"

@interface Home_paiduiViewController ()
@property (strong, nonatomic) Home_paihao *paihVC;


@end

@implementation Home_paiduiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle:@"排队叫号"];
    
    _paihVC = [[Home_paihao alloc]initWithFrame:kBounds];
    [self.view addSubview:_paihVC];
    
    WeakType(self);
    _paihVC.paiBlock = ^{
        
        weakself.hidesBottomBarWhenPushed  =YES;
        [weakself.navigationController pushViewController:[home_paihaoViewController new] animated:YES];
        //weakself.hidesBottomBarWhenPushed = NO;
        
        DLog(@"排号");
    };
    
_paihVC.jiaoBlock = ^{
    weakself.hidesBottomBarWhenPushed  =YES;
    [weakself.navigationController pushViewController:[Home_jiaohaoViewController new] animated:YES];
   // weakself.hidesBottomBarWhenPushed = NO;
    DLog(@"叫号");
};
 
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
