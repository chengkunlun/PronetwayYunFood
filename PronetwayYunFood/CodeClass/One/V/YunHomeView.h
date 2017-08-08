//
//  YunHomeView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/14.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YunHomeView : UIView

@property (strong, nonatomic) UIImageView *home_caipinImg;
@property (strong, nonatomic) UIButton *home_caipinBtn;
@property (strong, nonatomic) UIImageView *home_canjuView;
@property (strong, nonatomic) UIImageView *home_shujuView;
@property (strong, nonatomic) UIImageView *home_dianpuView;
@property (strong, nonatomic) UIImageView *home_wifiView;
@property (strong, nonatomic) UIImageView *home_huiyanView;

@property (strong, nonatomic) dispatch_block_t canjuBlock;
@property (strong, nonatomic) dispatch_block_t shujuBlock;
@property (strong, nonatomic) dispatch_block_t dianpuBlock;
@property (strong, nonatomic) dispatch_block_t wifiBlock;
@property (strong, nonatomic) dispatch_block_t huiyuanBlock;
@property (strong, nonatomic) dispatch_block_t BtnBlock;


@end
