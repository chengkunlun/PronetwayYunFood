//
//  YunNavgationController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/10.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YunNavgationController.h"

@interface YunNavgationController ()<UINavigationBarDelegate>

@end

@implementation YunNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        
        if (iOS7) {
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_ios7.png"] forBarMetrics:UIBarMetricsDefault];
            self.navigationBar.userInteractionEnabled = YES;
        } else {
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
            self.navigationBar.userInteractionEnabled = YES;
            
        }
        
    }
    
    
    //导航栏
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(0, 0, 10, 19);
    [setBtn setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(popToBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:setBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}
- (void)popToBack
{
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
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
