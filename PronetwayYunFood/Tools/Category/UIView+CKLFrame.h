//
//  UIView+CKLFrame.h
//  mansoryLayout
//
//  Created by ckl@pmm on 16/8/29.
//  Copyright © 2016年 CKLPronetway. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface UIView (CKLFrame)

//  高度
@property (nonatomic,assign) CGFloat height;
//  宽度
@property (nonatomic,assign) CGFloat width;

//  X
@property (nonatomic,assign) CGFloat X;
//  Y
@property (nonatomic,assign) CGFloat Y;

//  X + Height
@property (nonatomic,assign) CGFloat endX;
//  Y + width
@property (nonatomic,assign) CGFloat endY;



/**
 *  Make view draggable.
 *
 *     Animator reference view, usually is super view.
 *   Value from 0.0 to 1.0. 0.0 is the least oscillation. default is 0.4.
 */
- (void)makeDraggable;
- (void)makeDraggableInView:(UIView *)view damping:(CGFloat)damping;

/**
 *  Disable view draggable.
 */
- (void)removeDraggable;

/**
 *  If you call make draggable method in the initialize method such as `-initWithFrame:`,
 *  `-viewDidLoad`, the view may not be layout correctly at that time. So you should
 *  update snap point in `-layoutSubviews` or `-viewDidLayoutSubviews`.
 *
 *  By the way, you can call make draggable method in `-layoutSubviews` or
 *  `-viewDidLayoutSubviews` directly instead of update snap point.
 */
- (void)updateSnapPoint;


@end
