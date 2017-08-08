//
//  Home_paihao.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/18.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home_paihao : UIView

@property (strong, nonatomic)UIImageView *PaiimgView;

@property (strong, nonatomic)UIImageView *JiaoimgView;

@property (strong, nonatomic) dispatch_block_t paiBlock;
@property (strong, nonatomic) dispatch_block_t jiaoBlock;


@end
