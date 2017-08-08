//
//  MycommenView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/7.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MycommenView : UIView

@property (strong, nonatomic) UILabel *titleLb;
@property (strong, nonatomic) UILabel *subtitlelab;
@property (strong, nonatomic) dispatch_block_t clickBlock;
@end
