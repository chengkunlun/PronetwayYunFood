//
//  My_tiXianViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "My_tiXianViewController.h"
#import "My_tiXianView.h"
@interface My_tiXianViewController ()
@property (strong, nonatomic) My_tiXianView *tixianVC;
@end

@implementation My_tiXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"提现"];
    
    _tixianVC = [[My_tiXianView alloc]initWithFrame:kBounds];
    [_tixianVC.my_tixianBtn addTarget:self action:@selector(tixianBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_tixianVC];
    
    // Do any additional setup after loading the view.
}

//提现
-(void)tixianBtnClick:(UIButton *)btn {

    
    [WSProgressHUD showWithStatus:@"正在提现中 .."];
    _tixianVC.my_tixianBtn.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [WSProgressHUD showImage:nil status:@"操作完成"];
        _tixianVC.userInteractionEnabled = YES;
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
