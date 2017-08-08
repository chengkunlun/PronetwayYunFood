//
//  YunHomeView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/14.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YunHomeView.h"

@implementation YunHomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    self.backgroundColor = [UIColor blackColor];
    
    _home_caipinImg = [UIImageView new];
    [self addSubview:_home_caipinImg];
    _home_caipinImg.image = kimage(@"Yun_home_bgCaipin");
    _home_caipinImg.userInteractionEnabled = YES;
    _home_caipinImg.frame = CGRectMake(0, 0, kWidth, 155*newKhight);
    
    _home_caipinBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_home_caipinImg addSubview:_home_caipinBtn];
    
    _home_caipinBtn.frame = CGRectMake((kWidth-147*newKwith)/2, (_home_caipinImg.height-46*newKhight)/2, 147*newKwith, 46*newKhight);

    _home_caipinBtn.backgroundColor = kWhiteColor;
    [_home_caipinBtn setTitle:@"菜品管理" forState:(UIControlStateNormal)];
    [_home_caipinBtn setTitleColor:RGB(55, 66, 86) forState:(UIControlStateNormal)];
    _home_caipinBtn.titleLabel.font = kBodlFont(17);
    _home_caipinBtn.layer.masksToBounds = YES;
    _home_caipinBtn.layer.cornerRadius = 5*newKhight;
    
    _home_canjuView = [UIImageView new];
    [self addSubview:_home_canjuView];
    _home_canjuView.backgroundColor = RGB(234, 83, 111);
    _home_canjuView.frame = CGRectMake(0, _home_caipinImg.endY+10*newKhight, 183*newKwith, 237*newKhight);
    
    UILabel *paidui = [UILabel new];
    [_home_canjuView addSubview:paidui];
    [self pakLab:paidui text:@"排 队 叫 号"];
    paidui.frame = CGRectMake(0, 21*newKhight, _home_canjuView.width, 34);

    
    UIImageView *paiduiimg = [UIImageView new];
    [_home_canjuView addSubview:paiduiimg];
    paiduiimg.image = kimage(@"Yun_home_canju");
    paiduiimg.frame = CGRectMake(42*newKwith, paidui.endY+11*newKhight, 105*newKwith, 105*newKhight);
   
    
    _home_shujuView = [[UIImageView alloc]initWithFrame:CGRectMake(193*newKwith, 165*newKhight, 183*newKwith, 113*newKhight)];
    _home_shujuView.backgroundColor = RGB(70, 176, 225);
    [self addSubview:_home_shujuView];
    
    UILabel *shuju = [[UILabel alloc]initWithFrame:CGRectMake(0, 19*newKhight, _home_shujuView.width, 34)];
    shuju.textAlignment = NSTextAlignmentCenter;
    [_home_shujuView addSubview:shuju];
    [self pakLab:shuju text:@"数 据 分 析"];
    
    UIImageView *shujuimg = [[UIImageView alloc]initWithFrame:CGRectMake(69*newKwith, shuju.endY, 45*newKwith, 44*newKhight)];
    shujuimg.image = kimage(@"Yun_home_shuju");
    [_home_shujuView addSubview:shujuimg];
    
    
    _home_dianpuView = [[UIImageView alloc]initWithFrame:CGRectMake(_home_shujuView.X, _home_shujuView.endY+10*newKhight, 86*newKwith, 114*newKhight)];
    _home_dianpuView.backgroundColor = RGB(245, 153, 0);
    [self addSubview:_home_dianpuView];
    
    UILabel *dianpu = [[UILabel alloc]initWithFrame:CGRectMake(0, 19*newKhight, _home_dianpuView.width, 34)];
    dianpu.textAlignment = NSTextAlignmentCenter;
    [_home_dianpuView addSubview:dianpu];
    [self pakLab:dianpu text:@"店 面 设 置"];
    
    UIImageView *dianpuimg = [[UIImageView alloc]initWithFrame:CGRectMake(23*newKwith, shuju.endY+4*newKhight, 38*newKwith, 38*newKhight)];
    dianpuimg.image = kimage(@"Yun_home_dianpu");
    [_home_dianpuView addSubview:dianpuimg];
    

    
    _home_wifiView = [[UIImageView alloc]initWithFrame:CGRectMake(_home_dianpuView.endX+10*newKwith, _home_shujuView.endY+10*newKhight, 86*newKwith, 114*newKhight)];
    _home_wifiView.backgroundColor = RGB(124, 174, 23);
    [self addSubview:_home_wifiView];
    
    UILabel *wifi = [[UILabel alloc]initWithFrame:CGRectMake(0, 19*newKhight, _home_wifiView.width, 34)];
    wifi.textAlignment = NSTextAlignmentCenter;
    [_home_wifiView addSubview:wifi];
    [self pakLab:wifi text:@"系 统 设 置"];
    
    UIImageView *wifiimg = [[UIImageView alloc]initWithFrame:CGRectMake(23*newKwith, shuju.endY+10*newKhight, 44*newKwith, 31*newKhight)];
    wifiimg.image = kimage(@"Yun_home_wifi");
    [_home_wifiView addSubview:wifiimg];
    
    
    
    _home_huiyanView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _home_dianpuView.endY+10*newKhight,kWidth, kHeight-_home_canjuView.endY-kTabBarH)];
    _home_huiyanView.backgroundColor = RGB(148, 89, 164);
    [self addSubview:_home_huiyanView];
    
    UILabel *huiyuan = [[UILabel alloc]initWithFrame:CGRectMake(0, 21*newKhight, _home_huiyanView.width, 34)];
    huiyuan.textAlignment = NSTextAlignmentCenter;
    [_home_huiyanView addSubview:huiyuan];
    [self pakLab:huiyuan text:@"我 的 会 员"];
    
    UIImageView *huiyanimg = [[UIImageView alloc]initWithFrame:CGRectMake(157*newKwith, huiyuan.endY+15*newKhight, 59*newKwith, 49*newKhight)];
    huiyanimg.image = kimage(@"Yun_home_huiyuan");
    [_home_huiyanView addSubview:huiyanimg];
    
    //给图片添加点击事件
    [self addTap:1 imgVC:_home_canjuView];
    [self addTap:2 imgVC:_home_shujuView];
    [self addTap:3 imgVC:_home_dianpuView];
    [self addTap:4 imgVC:_home_wifiView];
    [self addTap:5 imgVC:_home_huiyanView];

}

-(void)addTap:(NSInteger)index imgVC:(UIImageView *)imgVC {

    imgVC.userInteractionEnabled = YES;
    imgVC.tag = index;
    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView:)];
    PrivateLetterTap.numberOfTouchesRequired = 1; //手指数PrivateLetterTap.
    PrivateLetterTap.numberOfTapsRequired = 1; //tap次数
    imgVC.contentMode = UIViewContentModeScaleToFill;
    [imgVC addGestureRecognizer:PrivateLetterTap];

}


-(void)tapAvatarView:(UITapGestureRecognizer*)tapgester{
    
    UILongPressGestureRecognizer *tap = (UILongPressGestureRecognizer *)tapgester;
    
    UIImageView *imageVC = (UIImageView *)tap.view;

    NSInteger tag = imageVC.tag;
    
    switch (tag) {
        case 1:
            
            if (self.canjuBlock) {
                
                self.canjuBlock();
            }
            
            
            break;
            
        case 2:
            if (self.shujuBlock) {
                
                self.shujuBlock();
            }
            
            
            break;case 3:
            if (self.dianpuBlock) {
                
                self.dianpuBlock();
            }
            
            
            break;case 4:
            
            if (self.wifiBlock) {
                
                self.wifiBlock();
            }
            
            break;
            
            
        default:
            
            if (self.huiyuanBlock) {
                
                self.huiyuanBlock();
            }
            
            break;
    }
    
}


-(void)pakLab:(UILabel *)lab text:(NSString *)text{

    lab.font = kBodlFont(17);
    lab.textColor = kWhiteColor;
    lab.text = text;
    lab.textAlignment = NSTextAlignmentCenter;
}

@end
