//
//  Home_shujuViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_shujuViewController.h"
#import "RCSegmentView.h"
#import "KehuViewController.h"
#import "YingyeViewController.h"
#import "CaipinViewController.h"
@interface Home_shujuViewController ()

@end

@implementation Home_shujuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle:@"数据分析"];
    
    
    KehuViewController * First=[[KehuViewController alloc]init];
    YingyeViewController * Second=[[YingyeViewController alloc]init];
    CaipinViewController * Third=[[CaipinViewController alloc]init];
    //FourViewController *four = [[FourViewController alloc]init];
    NSArray *controllers=@[First,Second,Third];
    
    NSArray *titleArray =@[@"客户分析",@"营业统计",@"菜品统计"];
    RCSegmentView * rcs=[[RCSegmentView alloc]initWithFrame:CGRectMake(0, 0, kWidth,kHeight) controllers:controllers titleArray:titleArray ParentController:self];
    [self.view addSubview:rcs];
    // 当前选择的视图
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectVCClick:) name:@"SelectVC" object:nil];
    
    // Do any additional setup after loading the view.
}


- (void)SelectVCClick:(NSNotification *)not
{
    UIButton * btn=not.object;
    NSString * title=[NSString stringWithFormat:@"当前是第%@页",@[@"一",@"二",@"三"][btn.tag]];
    DLog(@"%@",title);
   // SETNAVIGTIONBAR(title);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
