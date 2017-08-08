//
//  Home_wifiViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_wifiViewController.h"
#import "wifiView.h"
#import "wifiMobanViewController.h"
#import "wifi_routeViewController.h"
#import "RCSegmentView.h"
#import "MymobanViewController.h"

@interface Home_wifiViewController ()
@property (strong, nonatomic) wifiView *wifiVC;
@property (strong, nonatomic) UIButton *rightBtn;

@end

@implementation Home_wifiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle:@"路由设置"];
    _wifiVC = [[wifiView alloc]initWithFrame:kBounds];
    [self.view addSubview:_wifiVC];
    
    //添加右按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = right;
    
    wifiMobanViewController * First=[[wifiMobanViewController alloc]init];
    wifi_routeViewController * Second=[[wifi_routeViewController alloc]init];
    //FourViewController *four = [[FourViewController alloc]init];
    NSArray *controllers=@[First,Second];
    
    NSArray *titleArray =@[@"模板",@"应用"];
    RCSegmentView * rcs=[[RCSegmentView alloc]initWithFrame:CGRectMake(0, 0, kWidth,kHeight) controllers:controllers titleArray:titleArray ParentController:self];
    [self.view addSubview:rcs];
    // 当前选择的视图
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectVCClick:) name:@"SelectVC" object:nil];
    

}

- (void)SelectVCClick:(NSNotification *)not
{
    UIButton * btn=not.object;
    NSString * title=[NSString stringWithFormat:@"当前是第%@页",@[@"一",@"二",@"三"][btn.tag]];
    DLog(@"%@",title);
    // SETNAVIGTIONBAR(title);
}


-(UIButton *)rightBtn {
    
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _rightBtn.frame = CGRectMake(0, 0, 40*newKhight, 40*newKwith);
        [_rightBtn setTitle:@"我的" forState:(UIControlStateNormal)];
        _rightBtn.titleLabel.font = kBodlFont(16);
        [_rightBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        [_rightBtn addTarget:self action:@selector(RightClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _rightBtn;
}

//右按钮点击事件
-(void)RightClick:(UIButton *)btn {
    
    [self.navigationController pushViewController:[MymobanViewController new] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
