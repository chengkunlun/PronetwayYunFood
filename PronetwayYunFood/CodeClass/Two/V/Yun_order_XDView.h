//
//  Yun_order_XDView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/15.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "kezhuoModel.h"

@protocol XDViewdelagate <NSObject>


-(void)TogetXDArr:(NSMutableArray *)Arr;

@end

@interface Yun_order_XDView : UIView<UITableViewDelegate,UITableViewDataSource,TDAlertViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame sid:(NSString *)sid;
@property (strong, nonatomic) UITableView *Yun_xdTableView;
@property (strong, nonatomic) UIView *BottomView;
@property (strong, nonatomic) UILabel *lb4;
@property (strong, nonatomic) UILabel *lb5;
@property (strong, nonatomic) UILabel *lb6;

@property (strong, nonatomic) UIButton *XDBtn;

@property (strong, nonatomic) dispatch_block_t xdBlock;

@property (strong, nonatomic) NSMutableArray *xdArr;

@property (strong, nonatomic) NSMutableArray *FoodArr;
@property (strong, nonatomic) NSString *allPrice;
@property (strong, nonatomic) kezhuoModel *model;

@property (strong, nonatomic) id<XDViewdelagate>delegate;


@end
