//
//  YinyeView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YingyeTableViewCell.h"
#import "LRSChartView.h"

@interface YinyeView : UIView<UITableViewDelegate ,UITableViewDataSource>
@property (strong, nonatomic) UITableView *Yingyetab;
@property (strong, nonatomic) UIView *topView;

@property (strong, nonatomic) UILabel *titleLb;

@property (strong, nonatomic) UIView *zexianView;

@property (nonatomic, strong) LRSChartView *incomeChartLineView;
@property (strong, nonatomic) UIButton *selectBtn;
@property (strong, nonatomic) UIButton *timeBtn;


@property (strong, nonatomic) NSMutableArray *dateXArr;
@property (strong, nonatomic) NSMutableArray *dateYArr;
@property (strong, nonatomic) NSMutableArray *AllArr;


@end
