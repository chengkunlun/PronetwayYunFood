//
//  AddCaiKindView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/17.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUFoldingTableView.h"


@protocol addCaiDelegate <NSObject>

-(void)onpressBtn1;
-(void)onpressBtn2;


@end

@interface AddCaiKindView : UIView<YUFoldingTableViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame select:(NSString *)select;

@property (nonatomic, assign) YUFoldingSectionHeaderArrowPosition arrowPosition;
@property (nonatomic, weak) YUFoldingTableView *foldingTableView;

@property (strong, nonatomic) UIImageView *PhotoimgView;
@property (strong, nonatomic) UIButton *saveBtn;
@property (strong, nonatomic) UILabel *lb;
@property (strong, nonatomic) NSArray *arr;
@property (strong, nonatomic) NSString *select;

@property (strong, nonatomic) UIButton *btn1;
@property (strong, nonatomic) UILabel *lab1;
@property (strong, nonatomic) UIButton *btn2;
@property (strong, nonatomic) UILabel *lab2;


@property (strong, nonatomic) UIImageView *leftimgView;
@property (strong, nonatomic) UIImageView *rightimgView;

@property (strong, nonatomic)UIVisualEffectView *LeftEfView;
@property (strong, nonatomic)UIVisualEffectView *RightEfView;


@property (strong, nonatomic) id<addCaiDelegate>delegate;

@property (strong, nonatomic) keyboardView *keyView;

@end
