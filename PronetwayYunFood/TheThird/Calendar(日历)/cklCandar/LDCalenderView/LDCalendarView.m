//
//  LDCalendarView.m
//
//  Created by lidi on 15/9/1.
//  Copyright (c) 2015年 lidi. All rights reserved.
//

#import "LDCalendarView.h"
#import "NSDate+extend.h"
#import "Animations.h"
#define UNIT_WIDTH  35 * SCREEN_RAT

//行 列 数目
//行 列 每小格宽度 格子总数
static const NSInteger kRow = 7;
static const NSInteger kCol = 7;
static const NSInteger kTotalNum = (kRow - 1) * kCol;

@implementation UIColor (Extend)
+ (UIColor *)hexColorWithString:(NSString *)string
{
    return [UIColor hexColorWithString:string alpha:1.0f];
}

+ (UIColor *)hexColorWithString:(NSString *)string alpha:(float) alpha
{
    if ([string hasPrefix:@"#"]) {
        string = [string substringFromIndex:1];
    }
    
    NSString *pureHexString = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([pureHexString length] != 6) {
        return [UIColor whiteColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [pureHexString substringWithRange:range];
    
    range.location += range.length ;
    NSString *gString = [pureHexString substringWithRange:range];
    
    range.location += range.length ;
    NSString *bString = [pureHexString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}
@end

@interface LDCalendarView() {
    NSMutableArray *_currentMonthDateArray;
    NSMutableArray *_selectArray;
    
    UIView *_dateBgView;//日期的背景
    UIView  *_contentBgView;
    CGRect _touchRect;//可操作区域
    UIButton *_done; //确定按钮
}
@property (nonatomic, assign)int32_t month;
@property (nonatomic, assign)int32_t year;
@property (nonatomic, strong)UILabel *titleLab;//标题
@property (nonatomic, strong)NSDate *today; //今天0点的时间
@end

@implementation LDCalendarView
- (NSDate *)today {
    if (!_today) {
        NSDate *currentDate = [NSDate date];
        NSInteger tYear = currentDate.year;
        NSInteger tMonth = currentDate.month;
        NSInteger tDay = currentDate.day;
        
        //字符串转换为日期
        //实例化一个NSDateFormatter对象
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        _today =[dateFormat dateFromString:[NSString stringWithFormat:@"%@-%@-%@",@(tYear),@(tMonth),@(tDay)]];
    }
    return _today;
}


-(void)bgClick:(UITapGestureRecognizer *)tap {

    [self cancerBtnClick];
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _indexForSelect = 1;
        
        UIView *bgAlphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        bgAlphaView.alpha = 0.3;
        bgAlphaView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgClick:)];
        tap1.numberOfTapsRequired = 1;
        tap1.numberOfTouchesRequired = 1;
        [bgAlphaView addGestureRecognizer:tap1];
        
        [self addSubview:bgAlphaView];
        
        
        //内容区的背景
        _contentBgView = [[UIView alloc] init];
        _contentBgView.layer.cornerRadius = 2.0;
        _contentBgView.layer.masksToBounds = YES;
        _contentBgView.userInteractionEnabled = YES;
        _contentBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentBgView];
        
     //   UIImageView *lineM = [[UIImageView alloc]init];
      //  lineM.backgroundColor = RGB(151, 151, 151);
        
       // [self addSubview:lineM];
//        _CancerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        // CancerBtn.backgroundColor = [UIColor redColor];
//        [_CancerBtn addTarget:self action:@selector(cancerBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
//        [_CancerBtn setImage:[UIImage imageNamed:@"backcander"] forState:(UIControlStateNormal)];
//        [self addSubview:_CancerBtn];
        
        [UIView animateWithDuration:.75f
                              delay:0.2
             usingSpringWithDamping:0.65f
              initialSpringVelocity:0.5
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                _contentBgView.frame = CGRectMake((SCREEN_WIDTH-UNIT_WIDTH*kCol)/2.0, 100*newKwith, UNIT_WIDTH*kCol, 92*newKhight+UNIT_WIDTH*kCol);
                         }
                completion:^(BOOL finished) {
                             
             // lineM.frame = CGRectMake(kWidth/2, _contentBgView.endY, 2, 73*newKhight);
             // _CancerBtn.frame = CGRectMake((kWidth-32*newKwith)/2, lineM.endY, 32*newKwith, 32*newKhight);
               
                         }];
        UIImageView *leftImage = [UIImageView new];
        leftImage.image = [UIImage imageNamed:@"com_arrows_right"];
        leftImage.transform=CGAffineTransformMakeRotation(M_PI);
        [_contentBgView addSubview:leftImage];
        leftImage.frame = CGRectMake(CGRectGetWidth(_contentBgView.frame)/3.0 - 18*newKwith, (29*newKhight)/2.0, 8*newKwith, 13*newKhight);
        
        UIImageView *rightImage = [UIImageView new];
        rightImage.image = [UIImage imageNamed:@"com_arrows_right"];
        [_contentBgView addSubview:rightImage];
        rightImage.frame = CGRectMake(CGRectGetWidth(_contentBgView.frame)*2/3.0 + 8, (42*newKhight-13*newKhight)/2.0, 8*newKwith, 13*newKhight);
    
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_contentBgView.frame), 42*newKhight)];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.userInteractionEnabled = YES;
        [_contentBgView addSubview:_titleLab];
        
        UITapGestureRecognizer *titleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchMonthTap:)];
        [_titleLab addGestureRecognizer:titleTap];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLab.frame) - 0.5, CGRectGetWidth(_contentBgView.frame), 0.5)];
        line.backgroundColor = [UIColor hexColorWithString:@"dddddd"];
        [_contentBgView addSubview:line];
        
        _dateBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLab.frame), CGRectGetWidth(_contentBgView.frame), UNIT_WIDTH*kCol)];
        _dateBgView.userInteractionEnabled = YES;
        _dateBgView.backgroundColor = [UIColor hexColorWithString:@"ededed"];
        [_contentBgView addSubview:_dateBgView];
        
      UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
        UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
        
        leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        
        [_dateBgView addGestureRecognizer:leftSwipeGestureRecognizer];
        [_dateBgView addGestureRecognizer:rightSwipeGestureRecognizer];
        
        
        UIView *_bottomLine  = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dateBgView.frame), CGRectGetWidth(_contentBgView.frame), 0.5)];
        _bottomLine.backgroundColor = [UIColor hexColorWithString:@"dddddd"];
        [_contentBgView addSubview:_bottomLine];
        
        _done = [UIButton buttonWithType:UIButtonTypeCustom];
        [_done setFrame:CGRectMake((CGRectGetWidth(_contentBgView.frame) - 150*newKwith) / 2.0, CGRectGetHeight(_contentBgView.frame) - 40*newKhight, 150*newKwith, 30*newKhight)];
        
        [_done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_done.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_done setBackgroundImage:[[UIImage imageNamed:@"Yun_order_bottom"] stretchableImageWithLeftCapWidth:15 topCapHeight:10] forState:UIControlStateNormal];
        [_done setBackgroundImage:[[UIImage imageNamed:@"Yun_order_bottom"] stretchableImageWithLeftCapWidth:15 topCapHeight:10] forState:UIControlStateSelected];
        [_done setBackgroundImage:[[UIImage imageNamed:@"Yun_order_bottom"] stretchableImageWithLeftCapWidth:15 topCapHeight:10] forState:UIControlStateDisabled];
        [_done addTarget:self action:@selector(_doneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_done setTitle:@"确定" forState:UIControlStateNormal];
        [_contentBgView addSubview:_done];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_dateBgView addGestureRecognizer:tap];
        
        //初始化数据
        [self initData];

    }
    return self;
}

- (void)initData {
    _selectArray = @[].mutableCopy;
    
    //获取当前年月
    NSDate *currentDate = [NSDate date];
    self.month = (int32_t)currentDate.month;
    self.year = (int32_t)currentDate.year;
    [self refreshDateTitle];

    _currentMonthDateArray = [NSMutableArray array];
    for (int i = 0; i < kTotalNum; i++) {
        [_currentMonthDateArray addObject:@(0)];
    }
    
    [self showDateView];
}

- (void)switchMonthTap:(UITapGestureRecognizer *)tap {
   CGPoint loc =  [tap locationInView:_titleLab];
    CGFloat titleLabWidth = CGRectGetWidth(_titleLab.frame);
    if (loc.x <= titleLabWidth/3.0) {
        //左
        [self leftSwitch];
    }else if(loc.x >= titleLabWidth/3.0*2.0){
        //右
        [self rightSwitch];
    }
}

- (void)leftSwitch{
    
    [UIView transitionWithView:_dateBgView duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        //左
        if (self.month > 1) {
            self.month -= 1;
        }else {
            self.month = 12;
            self.year -= 1;
        }
    } completion:^(BOOL finished) {
        
        [self refreshDateTitle];
        
    }];
    
}
- (void)rightSwitch {
    
    [UIView transitionWithView:_dateBgView duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        
        if (self.month < 12) {
            self.month += 1;
        }else {
            self.month = 1;
            self.year += 1;
        }

    } completion:^(BOOL finished) {
        
        [self refreshDateTitle];
    }];

}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        [self leftSwitch];
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        [self rightSwitch];
    }
}


- (void)refreshDateTitle {
    _titleLab.text = [NSString stringWithFormat:@"%@月,%@年",@(self.month),@(self.year)];
    [self showDateView];
}

- (void)showDateView {
    //移除之前子视图
    [_dateBgView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    CGFloat offX = 0.0;
    CGFloat offY = 0.0;
    CGFloat w = (CGRectGetWidth(_dateBgView.frame)) / kCol;
    CGFloat h = (CGRectGetHeight(_dateBgView.frame)) / kRow;
    CGRect baseRect = CGRectMake(offX,offY, w, h);
    NSArray *tmparr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    for(int i = 0 ;i < 7; i++)
    {
        UILabel *lab = [[UILabel alloc] initWithFrame:baseRect];
        lab.textColor = [UIColor hexColorWithString:@"848484"];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:12];
        lab.backgroundColor = [UIColor clearColor];
        lab.text = [tmparr objectAtIndex:i];
        [_dateBgView addSubview:lab];
        
        baseRect.origin.x += baseRect.size.width;
    }

    //字符串转换为日期
    //实例化一个NSDateFormatter对象
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *firstDay =[dateFormat dateFromString:[NSString stringWithFormat:@"%@-%@-%@",@(self.year),@(self.month),@(1)]];
    
    CGFloat startDayIndex = [NSDate acquireWeekDayFromDate:firstDay];
    //第一天是今天，特殊处理
    if (startDayIndex == 1) {
        //星期天（对应一）
        startDayIndex = 6;
    }else {
        //周一到周六（对应2-7）
        startDayIndex -= 2;
    }
    baseRect.origin.x = w * startDayIndex;
    baseRect.origin.y += (baseRect.size.height);
    NSInteger baseTag = 100;
    for(int i = startDayIndex; i < kTotalNum;i++)
    {
        if (i % kCol == 0 && i!= 0)
        {
            baseRect.origin.y += (baseRect.size.height);
            baseRect.origin.x = offX;
        }
        
        //设置触摸区域
        if (i == startDayIndex)
        {
            _touchRect.origin = baseRect.origin;
            _touchRect.origin.x = 0;
            _touchRect.size.width = kCol * w;
            _touchRect.size.height = kRow * h;
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = baseTag + i;
        [btn setFrame:baseRect];
        btn.userInteractionEnabled = NO;
        btn.backgroundColor = [UIColor clearColor];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        NSDate * date = [firstDay dateByAddingTimeInterval:(i - startDayIndex) *24*60*60];
        _currentMonthDateArray[i] = @(([date timeIntervalSince1970]) * 1000);
        NSString *title = INTTOSTR(date.day);
        if ([date isToday])
        {//今天
            title = @"今天";
            btn.layer.borderColor = kRedColor.CGColor;
            btn.layer.borderWidth = 0.5;
        }
        else if(date.day == 1)
        {//是1号
            //在下面标一下月份
            UILabel *monthLab = [[UILabel alloc] initWithFrame:CGRectMake(baseRect.origin.x, baseRect.origin.y + baseRect.size.height - 7, baseRect.size.width, 7)];
            monthLab.backgroundColor = [UIColor clearColor];
            monthLab.textAlignment = NSTextAlignmentCenter;
            monthLab.font = [UIFont systemFontOfSize:8];
            monthLab.textColor = [UIColor hexColorWithString:@"c0c0c0"];
            monthLab.text = [NSString stringWithFormat:@"%@月",@(date.month)];
            [_dateBgView addSubview:monthLab];
        }
        
        [btn setTitle:title forState:UIControlStateNormal];
        if ([self.today compare:date] < 0) {
            //时间比今天大,同时是当前月
            [btn setTitleColor:[UIColor hexColorWithString:@"bfbfbf"] forState:UIControlStateNormal];
       }else {//bfbfbf
           [btn setTitleColor:[UIColor hexColorWithString:@"2b2b2b"] forState:UIControlStateNormal];
       }
        [btn setBackgroundColor:[UIColor clearColor]];
        [_dateBgView addSubview:btn];
        [_dateBgView sendSubviewToBack:btn];
        
        baseRect.origin.x += (baseRect.size.width);
    }
    
    //高亮选中的
    [self refreshDateView];
}

- (void)setDefaultDates:(NSArray *)defaultDates {
    _defaultDates = defaultDates;
    
    if (defaultDates) {
        _selectArray = [defaultDates mutableCopy];
    }else {
        _selectArray = @[].mutableCopy;
    }
}

- (void)refreshDateView {
    for(int i = 0; i < kTotalNum; i++)
    {
        UIButton *btn = (UIButton *)[_dateBgView viewWithTag:100 + i];
        NSNumber *interval = [_currentMonthDateArray objectAtIndex:i];

        if (i < [_currentMonthDateArray count] && btn)
        {
            if ([_selectArray containsObject:interval]) {
                btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.frame.size.width - 12, btn.frame.size.height - 10, 0);
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
                
                [btn setImage:[UIImage imageNamed:@"com_ic_select"] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setBackgroundColor:kRedColor];
            }
        }
    }
}

- (void)show {
    self.hidden = NO;
}

- (void)hide {
    self.hidden = YES;
    [self removeFromSuperview];

}

-(void)tap:(UITapGestureRecognizer *)gesture{
    CGPoint point = [gesture locationInView:_dateBgView];
    if (CGRectContainsPoint(_touchRect, point)) {
        CGFloat w = (CGRectGetWidth(_dateBgView.frame)) / kCol;
        CGFloat h = (CGRectGetHeight(_dateBgView.frame)) / kRow;
        int row = (int)((point.y - _touchRect.origin.y) / h);
        int col = (int)((point.x) / w);
        
        NSInteger index = row * kCol + col;
        
       
        [self clickForIndex:index];
    }
}

- (void)clickForIndex:(NSInteger)index
{
    UIButton *btn = (UIButton *)[_dateBgView viewWithTag:100 + index];
    if (index < [_currentMonthDateArray count]) {
        NSNumber *interval = [_currentMonthDateArray objectAtIndex:index];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval.doubleValue/1000.0];
        
        if ([self.today  compare:date] < 0) {
            //时间比今天大,同时是当前月
             DLog(@"选择的起始时间无效");
           // [self showErrorWithTitle:@"无效的时间" autoCloseTime:1];
            
            [WSProgressHUD showImage:nil status:@"无效的时间"];
            return;
        }else {
            
            
        }
        if (_indexForSelect == 3) {
    
            if ([_selectArray containsObject:interval]) {
            
                _indexForSelect = _indexForSelect-1;
                [_selectArray removeObject:interval];
                btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                
                [btn setImage:nil forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor hexColorWithString:@"2b2b2b"] forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor clearColor]];
                
                return;
            }else {
            
    
          // DMLog(@"已经选择两天了");
            [WSProgressHUD showShimmeringString:@"请点击确定" maskType:(WSProgressHUDMaskTypeDefault)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [WSProgressHUD dismiss];
            });
            return;
                
            }
        }

        if ([_selectArray containsObject:interval]) {
            //已选中,取消
            _indexForSelect = _indexForSelect-1;
            
            [_selectArray removeObject:interval];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            
            [btn setImage:nil forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hexColorWithString:@"2b2b2b"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor clearColor]];
        }else {
            
            _indexForSelect +=1;

            //未选中,想选择
            [_selectArray addObject:interval];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.frame.size.width - 12, btn.frame.size.height - 10, 0);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
            
            [btn setImage:[UIImage imageNamed:@"com_ic_select"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:kRedColor];
            
            //如果选中的是下个月切换到下个月
            if (date.month > self.month) {
                [self rightSwitch];
            }
        }
    }
}

- (void)_doneBtnClick:(id)sender
{
    
    if (_indexForSelect == 2) {
        
        //[WSProgressHUD showWithStatus:@"请选择结束时间" maskType:WSProgressHUDMaskTypeDefault];
        [WSProgressHUD showShimmeringString:@"请选择结束时间" maskType:(WSProgressHUDMaskTypeDefault)];
        NSLog(@"请选择结束时间");
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [WSProgressHUD dismiss];
        });
        
    }else if (_indexForSelect == 1) {
    
        [WSProgressHUD showShimmeringString:@"请选择开始时间" maskType:(WSProgressHUDMaskTypeDefault)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [WSProgressHUD dismiss];
        });
  
        
    }else {
    
        if (_complete) {
            _complete([_selectArray mutableCopy]);
        }
        [self hide];
    }
    
    
}

- (void)dealloc
{
    _indexForSelect = 0 ;
   // [_selectArray removeAllObjects];
}


-(void)cancerBtnClick{
        [UIView transitionWithView:_dateBgView duration:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.backgroundColor = kClearColor;
            self.alpha = 0;
            [PronetwayYunFoodHandle shareHandle].sjselected = NO;
        } completion:^(BOOL finished) {
        self.alpha = 0;
        [self removeFromSuperview];

        }];
}
@end
