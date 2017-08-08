//
//  Home_helpViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/18.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_helpViewController.h"

@interface Home_helpViewController ()

@property (strong, nonatomic) UIImageView *helpimgVC;

@end

@implementation Home_helpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"帮助"];
    
    [self.view addSubview:self.helpimgVC];
    if ([self.selectStr isEqualToString:@"kezhuomanager"]) {
        _helpimgVC.image = kimage(@"Yun_kezhuomanager_helpe");
        
    }else {
        _helpimgVC.image = kimage(@"Yun_caip_helpe");
    }
    // Do any additional setup after loading the view.
}

-(UIImageView *)helpimgVC {

    if (!_helpimgVC) {
        _helpimgVC = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    
    }
    
    return _helpimgVC;
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
