//
//  SJ_caipinView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJ_caipinTableViewCell.h"
#import "LDCalendarView.h"
#import "CaiPsticsModel.h"
@interface SJ_caipinView : UIView<RefreshDelegate,UITableViewDelegate,UITableViewDataSource>
{

    RefreshManager *mananer;

}
@property (strong, nonatomic) UITableView *caipinTab;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIButton *selectBtn;
@property (strong, nonatomic) UIButton *timeBtn;
@property (strong, nonatomic) UIView *sessionheader;


@property (nonatomic, strong)LDCalendarView    *calendarView;//日历控件
@property (nonatomic, strong)NSMutableArray *seletedDays;//选择的日期
@property (nonatomic, copy)NSString *showStr;

@property (strong, nonatomic) NSString *start;
@property (strong, nonatomic) NSString *end;

@property (strong, nonatomic) NSMutableArray *caiPArr;

@property (strong, nonatomic) NSString *refreshType;
@property (assign) int  refresh;
@property (strong, nonatomic) NSArray *arr;
@property (strong, nonatomic) NSString *type;


@end
