//
//  DYdianpuViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/19.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "DYdianpuViewController.h"
#import "DYdianpuViewController.h"
#import "HGDQQRCodeView.h"
@interface DYdianpuViewController ()

@property (strong, nonatomic) UIView *dyVC;
@property (strong, nonatomic) UIView *bottmView;
@property (strong, nonatomic) RedBtn *saveBtn;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIImageView *titleimg;
@property (strong, nonatomic) UIImageView *bootleftimg;
@property (strong, nonatomic) UIImageView *bootrightimg;
@property (strong, nonatomic) UILabel *titlelab;
@property (strong, nonatomic) UILabel *titlelab1;
@property (strong, nonatomic) UILabel *bootlab;
@property (strong, nonatomic) UIView *QRcodeView;


@end

@implementation DYdianpuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"打印店铺信息"];
    
    [self.view addSubview:self.bottmView];
    
    [self.view addSubview:self.contentView];
    
    // Do any additional setup after loading the view.
}

-(UIView *)contentView {

    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake((kWidth-350*newKwith)/2, (kHeight-350*newKhight-kNavBarHAndStaBarH*2-40*newKhight)/2, 350*newKwith, 370*newKhight)];
        _contentView.backgroundColor = kWhiteColor;
        _titleimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _contentView.width, 44*newKhight)];
        _titleimg.image = kimage(@"juxing");
        [_contentView addSubview:_titleimg];
        
        _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _contentView.width, _titleimg.height)];
        _titlelab.font = kBodlFont(24);
        _titlelab.text = @"扫我可以付款哟";
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.textColor = kWhiteColor;
        [_titleimg addSubview:_titlelab];
        
        _titlelab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleimg.endY, _contentView.width, _titleimg.height)];
        _titlelab1.font = kFont(15);
        _titlelab1.text = @"川菜馆";
        _titlelab1.textAlignment = NSTextAlignmentCenter;
        _titlelab1.textColor = rgba(85, 85, 85, 1);
        [_contentView addSubview:_titlelab1];
        
        
        _QRcodeView = [[UIView alloc]initWithFrame:CGRectMake(70*newKwith, _titlelab1.endY, _contentView.width-140*newKwith, _contentView.width-140*newKwith)];
        [HGDQQRCodeView creatQRCodeWithURLString:@"www.baidu.com" superView:self.QRcodeView logoImage:[UIImage imageNamed:@"1494828623"] logoImageSize:CGSizeMake(80*newKwith, 80*newKhight) logoImageWithCornerRadius:0];
        [_contentView addSubview:_QRcodeView];
        
        _bootleftimg = [[UIImageView alloc]initWithFrame:CGRectMake((_contentView.width-60*newKwith)/3, _QRcodeView.endY+5, 30, 30)];
        _bootleftimg.image = kimage(@"Yun_dianp_zhifubao");
        [_contentView addSubview:_bootleftimg];
        
        _bootrightimg = [[UIImageView alloc]initWithFrame:CGRectMake((_contentView.width-60*newKwith)/3*2+_bootleftimg.width, _QRcodeView.endY+5, 30, 30)];
        _bootrightimg.image = kimage(@"Yun_dianp_weiixn");
        [_contentView addSubview:_bootrightimg];
        

        _bootlab = [[UILabel alloc]initWithFrame:CGRectMake(0, _bootrightimg.endY, _contentView.width, _titleimg.height)];
        _bootlab.font = kFont(12);
        _bootlab.text = [NSString stringWithFormat:@"店铺电话 :%@",[UserDefaults objectForKeyStr:kdianputel]];
        _bootlab.textAlignment = NSTextAlignmentCenter;
        _bootlab.textColor = rgba(85, 85, 85, 1);
        [_contentView addSubview:_bootlab];
        
    }
    return _contentView;
}

-(UIView *)QRcodeView {
    
    if (!_QRcodeView) {
        
        _QRcodeView = [[UIView alloc]initWithFrame:CGRectMake(30*newKwith, 80*newKhight, kWidth-60*newKwith, kWidth-60*newKwith)];
        [HGDQQRCodeView creatQRCodeWithURLString:@"www.baidu.com" superView:self.QRcodeView logoImage:[UIImage imageNamed:@"1494828623"] logoImageSize:CGSizeMake(80*newKwith, 80*newKhight) logoImageWithCornerRadius:0];
        
    }
    return _QRcodeView;
}

-(UIView *)bottmView {

    if (!_bottmView) {
        _bottmView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight-kNavBarHAndStaBarH-44*newKhight, kWidth, 44*newKhight)];
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.layer.borderColor = [kRedColor CGColor];
        btn.layer.borderWidth = 1;
        [btn setTitle:@"打印" forState:(UIControlStateNormal)];
        btn.titleLabel.font = kFont(16);
        [btn setTitleColor:kRedColor forState:(UIControlStateNormal)];
        btn.frame = CGRectMake(0, 0, kWidth/2, 44*newKhight);
        [btn addTarget:self action:@selector(dyBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_bottmView addSubview:btn];
        _saveBtn = [[RedBtn alloc]initWithFrame:CGRectMake(kWidth/2, 0, kWidth/2, 44*newKhight) text:@"保存到相册"];
        [_saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_bottmView addSubview:_saveBtn];
     
        //[WSProgressHUD showImage:<#(UIImage *)#> status:<#(NSString *)#>];
    }
    return _bottmView;
}

-(void)dyBtnClick:(UIButton *)btn {

    DLog(@"打印");
    
}

-(void)saveBtnClick:(RedBtn *)btn {

    DLog(@"保存");
    
    [self saveImageToPhotos:[self captureCurrentView:self.contentView]];
    
    
}


- (UIImage *)captureCurrentView:(UIView *)view {
    // CGRect frame = view.frame;
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:contextRef];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext(); UIGraphicsEndImageContext();
    return image;
}

- (void)saveImageToPhotos:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil) {
        NSLog(@"保存成功");
        [WSProgressHUD showImage:nil status:@"保存成功"];
    } else {
        [WSProgressHUD showImage:nil status:@"保存失败"];
        NSLog(@"失败");
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
