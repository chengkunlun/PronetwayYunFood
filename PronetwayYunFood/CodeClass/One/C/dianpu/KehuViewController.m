//
//  KehuViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "KehuViewController.h"
#import "ShujuView.h"
@interface KehuViewController ()
@property (strong, nonatomic) ShujuView *kehuVC;
@end

@implementation KehuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _kehuVC = [[ShujuView alloc]initWithFrame:kBounds];
    [_kehuVC.calendarBtn addTarget:self action:@selector(clendarClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_kehuVC];
    
    // Do any additional setup after loading the view.
}

//日历
-(void)clendarClick:(UIButton *)btn {

    
    DLog(@"日历选择");
    
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
