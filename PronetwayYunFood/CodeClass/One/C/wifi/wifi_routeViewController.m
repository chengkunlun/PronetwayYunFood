//
//  wifi_routeViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "wifi_routeViewController.h"

@interface wifi_routeViewController ()
@property (strong, nonatomic) UIImageView *imgVC;
@property (strong, nonatomic) UILabel *lab;
@end

@implementation wifi_routeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kCbgColor;
    
    
    [self.view addSubview:self.imgVC];
    
    [self.view addSubview:self.lab];
    
    
    
    // Do any additional setup after loading the view.
}

-(UIImageView *)imgVC {

    if (!_imgVC) {
        _imgVC = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth-124*newKwith)/2, 142*newKhight, 124*newKwith, 128*newKhight)];
        _imgVC.image = kimage(@"Yun_wifi_app");
        [self.view addSubview:_imgVC];
        
    }
    return _imgVC;
}

-(UILabel *)lab {

    if (!_lab) {
        _lab = [[UILabel alloc]initWithFrame:CGRectMake(0, _imgVC.endY, kWidth, 34*newKhight)];
        _lab.textAlignment = NSTextAlignmentCenter;
        _lab.textColor = RGB(170, 170, 170);
        _lab.font = kFont(15);
        _lab.text = @"程序猿正在努力建设中 ...";
    }
    return _lab;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
