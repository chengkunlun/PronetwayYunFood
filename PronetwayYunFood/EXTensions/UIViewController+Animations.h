//
//  UIViewController+Animations.h
//  PronetwayGeneral
//
//  Created by ckl@pmm on 16/8/19.
//  Copyright © 2016年 CKLPronetway. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^photoBlock)(UIImage *photo);

@interface UIViewController (Animations)

//改变状态栏的颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color;

- (UILabel *)giveTitleColor:(UIColor *)color andFontSize:(CGFloat)fontSize forNavigationItemTitle:(NSString *)title;

-(void)showMsg:(NSString *)Msg;

-(void)setNavBarHidden:(BOOL)Hidden;

/**
 *  照片选择->图库/相机
 *
 *  @param edit  照片是否需要裁剪,默认NO
 *  @param block 照片回调
 */
-(void)showCanEdit:(BOOL)edit photo:(photoBlock)block;



@end
