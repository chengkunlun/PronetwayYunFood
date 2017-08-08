//
//  selectBtnView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/24.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface selectBtnView : UIView

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text color:(UIColor *)color;
@property (strong, nonatomic) UIButton *btn;
@property (strong, nonatomic) UILabel *btnlab;
@property (strong, nonatomic) UIImageView *arrowimg;

@property (strong, nonatomic) dispatch_block_t ClickBlock;

@end
