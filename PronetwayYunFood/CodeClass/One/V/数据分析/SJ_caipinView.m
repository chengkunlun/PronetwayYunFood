//
//  SJ_caipinView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "SJ_caipinView.h"
#import "NSDate+extend.h"
@implementation SJ_caipinView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    //添加上拉加载
    mananer = [RefreshManager new];

    
    [PronetwayYunFoodHandle shareHandle].shuju_isSelect = YES;
    [self addSubview:self.caipinTab];
    
    _start = [[DateUtil getCurrentTime] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    _end = [[DateUtil getCurrentTime]  stringByReplacingOccurrencesOfString:@"-" withString:@""];
    _type  =@"hot";
    [self reloadjosnStartTime:_start endTime:_end type:@"hot" start:@"0" limit:@"10"];

    //添加刷新
    [mananer addrefreshtab:self.caipinTab];
    mananer.delegate = self;

}

-(NSMutableArray *)caiPArr {

    if (!_caiPArr) {
        _caiPArr = [NSMutableArray array];
    }
    return _caiPArr;
}

-(UIView *)topView {
    
    if (!_topView) {
        CGFloat w = kWidth-30*newKhight;
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        _topView.backgroundColor  =kWhiteColor;
        
        UIImageView *sessionView = [[UIImageView alloc]initWithFrame:CGRectMake(-10, -4, w+20, 48*newKhight)];
        sessionView.image = kimage(@"Yun_huiyuan_sectionimg");
        [_topView addSubview:sessionView];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 ,w, 44*newKhight)];
        _title.text = @"最热销菜品";
        _title.font = kBodlFont(17);
        _title.textColor = kRedColor;
        _title.textAlignment = NSTextAlignmentCenter;
        [_topView addSubview:_title];
        
        _selectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _selectBtn.frame = CGRectMake(w-80*newKwith, 0, 70*newKwith, 44*newKhight);
       [_selectBtn addTarget:self action:@selector(selecyBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self pake:_selectBtn imagename:@"Yun_shuju_qiehuan" title:@"热销菜品"];
        
        _timeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _timeBtn.frame = CGRectMake(5*newKwith, 0, 50*newKwith, 44*newKhight);
        [_timeBtn addTarget:self action:@selector(timeBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self pake:_timeBtn imagename:@"Yun_shuju_redcandar" title:@"时间"];
        
        
    }
    
    return _topView;
}
-(UIView *)sessionheader {

    if (!_sessionheader) {
        _sessionheader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth-30*newKwith, 44*newKhight)];
        _sessionheader.backgroundColor = kWhiteColor;
        
        UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(0, 43*newKhight, kWidth, 1*newKhight)];
        linVC.backgroundColor = kCbgColor;
        [_sessionheader addSubview:linVC];
        
        CGFloat averageW = (kWidth-30)/4;
        
        NSArray *arr = @[@"排名",@"名称",@"销量",@"总额"];
        for (int i = 0; i<4; i++) {
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(averageW*i, 0, averageW, 44*newKhight)];
            lab.textColor = RGB(85, 85, 85);
            lab.font = kFont(15);
            lab.text = arr[i];
            lab.textAlignment = NSTextAlignmentCenter;
            [_sessionheader addSubview:lab];
        }
    }
    
    return _sessionheader;
}

-(UITableView *)caipinTab {
    
    if (!_caipinTab) {
        _caipinTab = [[UITableView alloc]initWithFrame:CGRectMake(15*newKwith, 20*newKhight, kWidth-30*newKwith, kHeight-2*kNavBarHAndStaBarH)];
        _caipinTab.delegate = self;
        _caipinTab.dataSource = self;
        [_caipinTab registerClass:[SJ_caipinTableViewCell class] forCellReuseIdentifier:@"sj_tabcell"];
        _caipinTab.backgroundColor = kClearColor;
        _caipinTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _caipinTab.tableHeaderView = self.topView;
    }
    
    return _caipinTab;
}
//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _caiPArr.count;
}
//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SJ_caipinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sj_tabcell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[SJ_caipinTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"sj_tabcell"];
    }
    if ([PronetwayYunFoodHandle shareHandle].shuju_isSelect) {
        
        cell.shujuimg.image = kimage(@"Yun_shuju_star_select");
        
    }else {
        
        cell.shujuimg.image = kimage(@"Yun_shuju_star");
    }
    if (self.caiPArr.count>indexPath.row) {//防止数组越界
        
        [cell loadModel:self.caiPArr[indexPath.row] index:indexPath.row];

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44*newKhight;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.sessionheader;
}


//热销 - 冷门按钮 切换事件
-(void)selecyBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    if (btn.selected == YES) {
        DLog(@"冷门");
        _type = @"cool";
        [self.caiPArr removeAllObjects];
        _refresh = 0;

        [self reloadjosnStartTime:_start endTime:_end type:@"cool" start:@"0" limit:@"10"];
        _title.text = @"冷门菜品";
        [btn setTitle:@"冷门菜品" forState:(UIControlStateSelected)];
        /*
         请求数据成功之后,修改图片,
         */
        //修改图片
        [PronetwayYunFoodHandle shareHandle].shuju_isSelect = NO;
        
    }else {

        [self.caiPArr removeAllObjects];

        [self reloadjosnStartTime:_start endTime:_end type:@"hot" start:@"0" limit:@"10"];
        _type = @"hot";

        DLog(@"热销");
        _title.text = @"热销菜品";
        [btn setTitle:@"热销菜品" forState:(UIControlStateNormal)];
        [PronetwayYunFoodHandle shareHandle].shuju_isSelect = YES;
    }
}

-(void)timeBtnClick:(UIButton *)btn {

    if ([PronetwayYunFoodHandle shareHandle].sjselected == YES) {
        return;
    }else {
        
        [PronetwayYunFoodHandle shareHandle].sjselected = YES;
        _calendarView = [[LDCalendarView alloc] initWithFrame:CGRectMake(0, 0, kWidth,kHeight-kNavBarHAndStaBarH)];
        [self addSubview:_calendarView];
        [_calendarView.CancerBtn addTarget:self action:@selector(cancer) forControlEvents:(UIControlEventTouchUpInside)];
        
        __weak typeof(self) weakSelf = self;
        _calendarView.complete = ^(NSArray *result) {
            if (result) {
                [PronetwayYunFoodHandle shareHandle].sjselected = NO;
                weakSelf.seletedDays = [result mutableCopy];
                DLog(@"你选择的日期是 -- %@",weakSelf.showStr);
                _start = [weakSelf.showStr substringWithRange:NSMakeRange(0, 8)];
                _end = [weakSelf.showStr substringWithRange:NSMakeRange(8, 8)];
                
                NSString *type;
                if ([PronetwayYunFoodHandle shareHandle].shuju_isSelect == NO) {
                    type = @"cool";
                }else {
                    type = @"hot";
                }
                _refresh = 0;
                [weakSelf.caiPArr removeAllObjects];//情况数组
                [weakSelf reloadjosnStartTime: weakSelf.start endTime:weakSelf.end type:type start:[NSString stringWithFormat:@"%d",weakSelf.refresh] limit:@"10"];
                
            }
        };
        [self.calendarView show];
        
                //如果想显示已经选择过的天数,加这个方法
        // self.calendarView.defaultDates = _seletedDays;
    }
    DLog(@"选择月份");
}

- (NSString *)showStr {
    NSMutableString *str = [NSMutableString string];
    
    //[str appendString:@"\r\n"];
    //从小到大排序
    [self.seletedDays sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return [obj1 compare:obj2];
    }];
    for (NSNumber *interval in self.seletedDays) {
        NSString *partStr = [NSDate stringWithTimestamp:interval.doubleValue/1000.0 format:@"yyyMMdd"];
        [str appendFormat:@"%@",partStr];
    }
    return [str copy];
}

-(void)cancer {
    [PronetwayYunFoodHandle shareHandle].sjselected = NO;
}

-(void)reloadjosnStartTime:(NSString *)StartTime endTime:(NSString *)endTime type:(NSString *)type  start:(NSString *)start limit:(NSString *)limit{
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@",kIpandPort,kcaiPStatistics1,[UserDefaults objectForKeyStr:kpid],kyinye2,StartTime,kyinye3,endTime,kyinye4,type,kyinye5,start,kyinye6,limit];
    DLog(@"数据分析 %@",url);
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
           _arr = dic[@"eimdata"];
            
            if (kStringIsEmpty(_refreshType)) {
                
                if (_arr.count == 0) {
                    
                    [WSProgressHUD showImage:nil status:@"暂无数据"];
                    return;
                }
            }
            if ([self.refreshType isEqualToString:@"top"]) {
                
                [self.caiPArr removeAllObjects];
            }
            
            for (NSDictionary *dict in _arr) {
                CaiPsticsModel *model = [CaiPsticsModel setUpModelWithDictionary:dict];
                [self.caiPArr addObject:model];
            }
            if ([_refreshType isEqualToString:@"top"]) {
                [self delayreload:1.5];
                
            }else if ([_refreshType isEqualToString:@"bottom"]) {
                
                [self delayreload:1.5];
                
            }else {
                [self.caipinTab reloadData];
            }
            
            
            
        }else {
            [WSProgressHUD showImage:nil status:@"暂无数据"];
        }
    } failure:^(NSError *error) {
        
        [WSProgressHUD showImage:nil status:@"服务器出错"];
    }];
}
//头部刷新点击事件
-(void)headerRefreshClick {
    
    _refreshType = @"top";
    
    _refresh = 0;
    
    [self reloadjosnStartTime:_start endTime:_end type:_type start:[NSString stringWithFormat:@"%d",_refresh] limit:@"10"];
    
}

//底部刷新点击事件
-(void)footRefreshClick {
    
    _refreshType = @"bottom";
    
    _refresh = 10*(++_refresh);
    
    [self reloadjosnStartTime:_start endTime:_end type:_type start:[NSString stringWithFormat:@"%d",_refresh] limit:@"10"];

    
}

-(void)delayreload:(int)time {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if ([self.refreshType isEqualToString:@"top"]) {
            [mananer stoprefreshHeader];
            if (_arr.count == 0) {
                
                [WSProgressHUD showImage:nil status:@"没有数据了"];
                return;
            }
            [self.caipinTab reloadData];
            
        }else if ([self.refreshType isEqualToString:@"bottom"]) {
            
            [mananer stoprefreshFoot];
            if (_arr.count == 0) {
                
                [WSProgressHUD showImage:nil status:@"没有数据了"];
                return;
            }
            [self.caipinTab reloadData];
        }
    });
}



-(void)pake:(UIButton *)btn imagename:(NSString *)str title:(NSString *)title {
    
    [btn setImage:kimage(str) forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:RGB(153, 153, 153) forState:(UIControlStateNormal)];
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
    
    CGFloat totalHeight = (btn.imageView.frame.size.height + btn.titleLabel.frame.size.height);
    // 设置按钮图片偏移
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - btn.imageView.frame.size.height), 0.0, 0.0, -btn.titleLabel.frame.size.width)];
    // 设置按钮标题偏移
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -btn.imageView.frame.size.width, -(totalHeight - btn.titleLabel.frame.size.height),0.0)];
    [_topView addSubview:btn];
    
}


@end
