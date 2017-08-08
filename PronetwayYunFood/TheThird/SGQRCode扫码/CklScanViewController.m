//
//  CklScanViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/4.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "CklScanViewController.h"
#import "ScanSuccessJumpVC.h"
@interface CklScanViewController ()

@end

@implementation CklScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kClearColor;
    
   // [self setupNavigationBar];
    
    // 注册观察者
   // [SGQRCodeNotificationCenter addObserver:self selector:@selector(SGQRCodeInformationFromeAibum:) name:SGQRCodeInformationFromeAibum object:nil];
   // [SGQRCodeNotificationCenter addObserver:self selector:@selector(SGQRCodeInformationFromeScanning:) name:SGQRCodeInformationFromeScanning object:nil];
}

- (void)SGQRCodeInformationFromeAibum:(NSNotification *)noti {
    
    NSString *string = noti.object;
    
    ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
    jumpVC.jump_URL = string;
    [self.navigationController pushViewController:jumpVC animated:YES];
}
//获取扫码结果
- (void)SGQRCodeInformationFromeScanning:(NSNotification *)noti {
    SGQRCodeLog(@"noti - - %@", noti);
    NSString *string = noti.object;
    
    if ([string hasPrefix:@"http"]) {
        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
        jumpVC.jump_URL = string;
        [self.navigationController pushViewController:jumpVC animated:YES];
       // [self presentViewController:jumpVC animated:YES completion:nil];

    } else { // 扫描结果为条形码
        
               
//        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//        jumpVC.jump_bar_code = string;
//        [self.navigationController pushViewController:jumpVC animated:YES];
//       // [self presentViewController:jumpVC animated:YES completion:nil];
    }
}
- (void)dealloc {
    SGQRCodeLog(@"QRCodeScanningVC - dealloc");
    [SGQRCodeNotificationCenter removeObserver:self];
}

-(void)smpay:(NSString *)result {

    NSString *urlstr = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,ktmpay1,self.payUrl,ktmpay2,result];
    DLog(@"条码支付 %@",urlstr);
    [CKLRequestManger GET:urlstr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [WSProgressHUD showSuccessWithStatus:@"支付成功"];
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }else {
        
            [WSProgressHUD showImage:nil status:@"支付失败"];
            
        }
    } failure:^(NSError *error) {
        DLog(@"%@",error);
        [WSProgressHUD showImage:nil status:@"服务器错误"];
    }];
}

@end
