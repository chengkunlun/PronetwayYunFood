//
//  YunCalssViewController.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/10.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YunCalssViewController : UIViewController
- (void)backAction;

@property (strong, nonatomic) dispatch_block_t NavBarTapClick;
-(void)setCustomerTitle:(NSString *)title;

@end
