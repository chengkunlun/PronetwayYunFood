//
//  detailChongzhiViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/26.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "detailChongzhiViewController.h"
#import "detailView.h"
@interface detailChongzhiViewController ()<detailviewDelegate>
@property (strong, nonatomic) detailView *detailVC;
@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *endTime;
@end

@implementation detailChongzhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"营销修改"];
    
    _detailVC = [[detailView alloc]initWithFrame:kBounds];
    _detailVC.delagate = self;
    
    [_detailVC.saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_detailVC];
    
    _detailVC.ChongModel = self.model;
    
    _startTime = [DateUtil TimeToTimestamp:self.model.startdate];
    _endTime = [DateUtil TimeToTimestamp:self.model.enddate];
    
    DLog(@"----%@",[DateUtil TimeToTimestamp:@"2017-07-12 24:00:00"]);
    
    
    // Do any additional setup after loading the view.
}
-(void)showBegainTime:(NSString *)begainStr endStr:(NSString *)endStr {

    DLog(@"start ++ %@",begainStr);
    DLog(@"end -- %@",endStr);
      _startTime = [DateUtil TimeToTimestampForday:begainStr];

      _endTime = [DateUtil TimeToTimestampForday:endStr];

}

-(void)saveBtnClick{

    if ([self check]) {
        
        [self reloadJosnForChangeC];
    }
}

-(BOOL)check {

    UITextField *T2 = (UITextField *)[self.view viewWithTag:kYun_huiyuandetailTag+2];
    if (kStringIsEmpty(T2.text)) {
        
        [WSProgressHUD showImage:nil status:@"总送金额不能为空"];
        return NO;
    }
    return YES;
}

-(void)reloadJosnForChangeC {
    UITextField *T2 = (UITextField *)[self.view viewWithTag:kYun_huiyuandetailTag+2];
    NSString *totl = [T2.text stringByReplacingOccurrencesOfString:@"¥" withString:@""];
    NSString *totl1 = [totl stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",kIpandPort,kHuiyuan_changeC1,[UserDefaults objectForKeyStr:ksid],kHuiyuan_changeC2,totl1,kHuiyuan_changeC3,_startTime,kHuiyuan_changeC4,_endTime];
    DLog(@"修改充值营销接口%@",url);
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"修改成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
