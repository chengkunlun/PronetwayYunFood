//
//  YingyeViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YingyeViewController.h"
#import "YinyeView.h"
@interface YingyeViewController ()
@property (strong, nonatomic) YinyeView *yingyeVC;
@end

@implementation YingyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _yingyeVC = [[YinyeView alloc]initWithFrame:kBounds];
    
    [self.view addSubview:_yingyeVC];

    
    
    
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
