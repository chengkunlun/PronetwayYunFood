//
//  YinyeView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YinyeView.h"
#import "YinYeModel.h"
@implementation YinyeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    self.backgroundColor = kCbgColor;
 
    
    [self addSubview:self.Yingyetab];
    
    [self reloadjosnStartTime:[[DateUtil getCurrentTime] stringByReplacingOccurrencesOfString:@"-" withString:@""] endTime:[[DateUtil getCurrentTime] stringByReplacingOccurrencesOfString:@"-" withString:@""] type:@"day"];
    
}

-(NSMutableArray *)dateXArr {
    if (!_dateXArr) {
        
        _dateXArr = [NSMutableArray array];
    }
    return _dateXArr;
}
-(NSMutableArray *)dateYArr {
    
    if (!_dateYArr) {
        
        _dateYArr = [NSMutableArray array];
    }
    return _dateYArr;
}
-(NSMutableArray *)AllArr {
    
    if (!_AllArr) {
        
        _AllArr = [NSMutableArray array];
    }
    return _AllArr;
}

-(UIView *)topView {

    if (!_topView) {
        CGFloat w = kWidth-30*newKhight;
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        _topView.backgroundColor  =kWhiteColor;
        
        UIImageView *sessionView = [[UIImageView alloc]initWithFrame:CGRectMake(-10, -4, w+20, 48*newKhight)];
        sessionView.image = kimage(@"Yun_huiyuan_sectionimg");
        [_topView addSubview:sessionView];
        
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , kWidth-30*newKwith, 44*newKhight)];
        _titleLb.text = @"日营业";
        _titleLb.font = kBodlFont(17);
        _titleLb.textColor = kRedColor;
        _titleLb.textAlignment = NSTextAlignmentCenter;
        [_topView addSubview:_titleLb];
     
        _selectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _selectBtn.frame = CGRectMake(w-80*newKwith, 0, 70*newKwith, 44*newKhight);
        [_selectBtn addTarget:self action:@selector(selecyBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self pake:_selectBtn imagename:@"Yun_shuju_qiehuan" title:@"日营业"];
        
        _timeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _timeBtn.frame = CGRectMake(5*newKwith, 0, 80*newKwith, 44*newKhight);
        [_timeBtn addTarget:self action:@selector(timeBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self pake:_timeBtn imagename:@"Yun_shuju_redcandar" title:@"今天营业"];
        
        
    }
    
    return _topView;
}

-(UITableView *)Yingyetab {
    
    if (!_Yingyetab) {
        _Yingyetab = [[UITableView alloc]initWithFrame:CGRectMake(15*newKwith, 20*newKhight, kWidth-30*newKwith, kHeight-2*kNavBarHAndStaBarH)];
        _Yingyetab.delegate = self;
        _Yingyetab.dataSource = self;
        [_Yingyetab registerClass:[YingyeTableViewCell class] forCellReuseIdentifier:@"yy_tabcell"];
        _Yingyetab.backgroundColor = kClearColor;
        _Yingyetab.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _Yingyetab.tableHeaderView = self.topView;
    }
    
    return _Yingyetab;
}
//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _AllArr.count;
}
//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YingyeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy_tabcell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[YingyeTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"yy_tabcell"];
    }
    
    if (self.AllArr.count>indexPath.row) {
        
        cell.model = self.AllArr[indexPath.row];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 200*newKhight;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return self.zexianView;
}
-(UIView *)zexianView {

    if (!_zexianView) {
        _zexianView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth-30*newKwith, 200*newKhight)];
        _zexianView.backgroundColor = kWhiteColor;
        
        [_zexianView addSubview:self.incomeChartLineView];
        
        UIView *linView = [[UIView alloc]initWithFrame:CGRectMake(0, _zexianView.endY-1*newKhight, kWidth-30*newKwith, 1)];
        linView.backgroundColor = kCbgColor;
        [_zexianView addSubview:linView];
        
        [self.zexianView addSubview:self.incomeChartLineView];

    }
    
    return _zexianView;
}

//加载 折线图
-(LRSChartView *)incomeChartLineView{
   
    _incomeChartLineView = [[LRSChartView alloc]initWithFrame:CGRectMake(-30*newKwith, 0,kWidth, 167*newKhight)];
    _incomeChartLineView.backgroundColor = [UIColor clearColor];
    _incomeChartLineView.titleOfYStr = @"收入(¥)";
    _incomeChartLineView.titleOfXStr = @"(日)";

    return _incomeChartLineView;
}

//热销 - 冷门按钮 切换事件
-(void)selecyBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
        if (btn.selected == YES) {
        DLog(@"月营业");
            
            if (_incomeChartLineView) {
                
                [UIView animateWithDuration:0.4 animations:^{
                    _incomeChartLineView.alpha = 0;
                    
                } completion:^(BOOL finished) {
                    [_incomeChartLineView removeFromSuperview];
                    _incomeChartLineView = nil;
                }];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (_incomeChartLineView == nil) {
                    
                    [self.zexianView addSubview:self.incomeChartLineView];
                    NSString *start = [NSString stringWithFormat:@"%@0101",[DateUtil getCurrentTimeToyear]];
                    NSString *end = [[DateUtil getCurrentTime] stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    [self reloadjosnStartTime:start endTime:end type:@"mon"];
                    _incomeChartLineView.titleOfXStr = @"(月)";
                }
            });
        _titleLb.text = @"月营业";
        [btn setTitle:@"月营业" forState:(UIControlStateSelected)];
        _timeBtn.hidden = YES;
    }else {
        DLog(@"日营业");
        _titleLb.text = @"日营业";
        if (_incomeChartLineView) {
            
            [UIView animateWithDuration:0.4 animations:^{
                _incomeChartLineView.alpha = 0;
                
            } completion:^(BOOL finished) {
                [_incomeChartLineView removeFromSuperview];
                _incomeChartLineView = nil;
            }];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (_incomeChartLineView == nil) {
                
                [self.zexianView addSubview:self.incomeChartLineView];
                
                NSString *start;
                NSString *tapm = [DateUtil getCurrentTimestamp];
                NSUInteger tam = [tapm floatValue];
                NSUInteger mut = tam-24*3600*7;
                start = [[DateUtil timestampToDateStr:mut] stringByReplacingOccurrencesOfString:@"-" withString:@""];
                
                NSString *end = [[DateUtil getCurrentTime] stringByReplacingOccurrencesOfString:@"-" withString:@""];
                
                [self reloadjosnStartTime:start endTime:end type:@"day"];
                _incomeChartLineView.titleOfXStr = @"(日)";
            }
        });
        
        [btn setTitle:@"日营业" forState:(UIControlStateNormal)];
        _timeBtn.hidden = NO;
        [_timeBtn setTitle:@"最近七天" forState:(UIControlStateNormal)];
    }
}

//构造日期 -- 最近七天
-(void)timeBtnClick:(UIButton *)btn {

    DLog(@"选择时间");
}

-(void)reloadjosnStartTime:(NSString *)StartTime endTime:(NSString *)endTime type:(NSString *)type {

    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",kIpandPort,kyinye1,[UserDefaults objectForKeyStr:kpid],kyinye2,StartTime,kyinye3,endTime,kyinye4,type];
    DLog(@"数据分析 %@",url);
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            NSArray *arr = dic[@"eimdata"];
            if (arr.count == 0) {
                return ;
            }
            
            [self.dateXArr removeAllObjects];
            [self.dateYArr removeAllObjects];
            [self.AllArr removeAllObjects];

            for (NSDictionary *dict in arr) {
                YinYeModel *model = [YinYeModel setUpModelWithDictionary:dict];
                [self.AllArr addObject:model];
                if ([type isEqualToString:@"day"]) {
                    
                    [self.dateXArr addObject:[model.stime substringFromIndex:5]];

                }else {
                
                    [self.dateXArr addObject:model.stime];

                }
                [self.dateYArr addObject:model.cMoney];
            }
            
            _incomeChartLineView.leftDataArr = [[self.dateYArr reverseObjectEnumerator]allObjects];
            _incomeChartLineView.dataArrOfX = [[self.dateXArr reverseObjectEnumerator]allObjects];//拿到X轴坐标
            
            [_Yingyetab reloadData];
            
        }else {
            [WSProgressHUD showImage:nil status:@"暂无数据"];
        }
        
    } failure:^(NSError *error) {
        
        [WSProgressHUD showImage:nil status:@"服务器出错"];

    }];
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
