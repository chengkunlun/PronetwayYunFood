//
//  FourViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/10.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "FourViewController.h"
#import "Yun_MyView.h"
#import "My_tiXianViewController.h"
#import "MyconmeeViewController.h"
@interface FourViewController ()<ZLTimeViewDelegate>
@property (strong, nonatomic) Yun_MyView *myVC;
@property (strong, nonatomic) UIButton *Rightbtn;

@property (strong, nonatomic) OkimageView *okimg;
@property (strong, nonatomic)    GuideView *markView;
@property (assign) int maerkshow;
@property (strong, nonatomic) NSString *historyStartTime;
@property (strong, nonatomic) NSString *historyEendTime;


//
@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *endTime;

@property (assign)  int  requested;

@property (assign) int i;

@end

@implementation FourViewController


-(void)viewWillAppear:(BOOL)animated {

    
    if ([_Rightbtn.titleLabel.text isEqualToString:@"历史"]){
        
        if (_i == 0) {
            
            _startTime =  [[DateUtil getCurrentTime] stringByReplacingOccurrencesOfString:@"-" withString:@""];
            _endTime = [[DateUtil getCurrentTime] stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
        }
        //解析数据
        [self reloadJosnForgetList:_startTime endTime:_endTime];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setCustomerTitle:@"当前账户"];
    _myVC = [[Yun_MyView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
   // [_myVC.My_top_tixianBtn addTarget:self action:@selector(tixianBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    _myVC.ckltime.delegate = self;
    _myVC.My_top_tixianBtn.hidden = YES;
    
    WeakType(self);
    _myVC.my_leftView.clickBlock = ^{
        MyconmeeViewController *myconM = [MyconmeeViewController new];
        myconM.selectStr = @"充值";
        [weakself.navigationController pushViewController:myconM animated:YES];
    };
    _myVC.my_RightView.clickBlock = ^{
        MyconmeeViewController *myconM = [MyconmeeViewController new];
        myconM.selectStr = @"提现";
        [weakself.navigationController pushViewController:myconM animated:YES];
    };
    _myVC.my_middleView.clickBlock = ^{
        MyconmeeViewController *myconM = [MyconmeeViewController new];
        myconM.selectStr = @"营业额";
        myconM.startTime = weakself.startTime;
        myconM.endTime = weakself.endTime;
        [weakself.navigationController pushViewController:myconM animated:YES];
    };
    _myVC.my_top_leftView.clickBlock = ^{
        MyconmeeViewController *myconM = [MyconmeeViewController new];
        myconM.selectStr = @"现金支付";
        myconM.startTime = weakself.startTime;
        myconM.endTime = weakself.endTime;
        [weakself.navigationController pushViewController:myconM animated:YES];
    };
   _myVC.my_top_RightView.clickBlock = ^{
       MyconmeeViewController *myconM = [MyconmeeViewController new];
        myconM.selectStr = @"线上支付";
       myconM.startTime = weakself.startTime;
       myconM.endTime = weakself.endTime;
        [weakself.navigationController pushViewController:myconM animated:YES];
    };
    
        [self setupnacBar];
    
    [self.view addSubview:_myVC];
    
    [self hiddenXian];
    
    
    if ([UserDefaults objectForKeyStr:kshowmy] == nil) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self showMarkView];
        });

    }
    
}

-(void)hiddenXian {

    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    // bg.png为自己ps出来的想要的背景颜色。
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_ios7"]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
}

-(void)setupnacBar {

    _Rightbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _Rightbtn.frame = CGRectMake(0, 0, 50*newKwith, 44*newKhight);
    [_Rightbtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    _Rightbtn.titleLabel.font = kFont(15);
    [_Rightbtn setTitle:@"历史" forState:(UIControlStateNormal)];
    [_Rightbtn addTarget:self action:@selector(rightClick:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *rit = [[UIBarButtonItem alloc]initWithCustomView:_Rightbtn];
    self.navigationItem.rightBarButtonItem = rit;
    
    
}

-(void)rightClick:(UIButton *)btn {

    btn.selected = !btn.selected;
    
    if (btn.selected == YES) {
        [_Rightbtn setTitle:@"当前" forState:(UIControlStateSelected)];
        [self setCustomerTitle:@"历史账户"];
        DLog(@"历史");
        _myVC.historyView.hidden = NO;
        _myVC.my_topView.hidden = YES;
        
        _startTime = _historyStartTime;
        _endTime = _historyEendTime;
        [self reloadJosnForgetList:_startTime endTime:_endTime];

        
    }else {
        [_Rightbtn setTitle:@"历史" forState:(UIControlStateNormal)];
        [self setCustomerTitle:@"当前账户"];
        _myVC.historyView.hidden = YES;
        _myVC.my_topView.hidden = NO;
        
        _startTime =  [[DateUtil getCurrentTime] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        _endTime = [[DateUtil getCurrentTime] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [self reloadJosnForgetList:_startTime endTime:_endTime];

        DLog(@"当前账户");
    }
}


-(void)tixianBtnClick:(id)sender {

    self.hidesBottomBarWhenPushed=YES;
    My_tiXianViewController *next=[[My_tiXianViewController alloc]init];
    [self.navigationController pushViewController:next animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

-(OkimageView *)okimg {
    
    
    if (!_okimg) {
        _okimg = [[OkimageView alloc]initWithFrame:CGRectMake((kWidth-140*newKwith)/2, kHeight-118*newKhight-70*newKhight, 140*newKwith, 118*newKhight)];
    }
    
    
    return _okimg;
}

//遮罩视图
-(void)showMarkView {
    
    _markView = [[GuideView alloc]initWithFrame:kBounds];
    _markView.fullShow = YES;
    _markView.model =
    GuideViewCleanModeRoundRect;
    //markView.guideColor = kCbgColor;
    _markView.showRect = CGRectMake(kWidth-54*newKwith, kStatusBarH, 40*newKwith, 40*newKhight);
    _markView.markText = @"点此查看历史记录";
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    [_markView addSubview:self.okimg];
    
    WeakType(self);
    self.okimg.Click = ^{
        
        [UIView animateWithDuration:0.3 animations:^{
            [UserDefaults setObjectleForStr:@"YES" key:kshowmy];
            weakself.markView.alpha = 0;
        } completion:^(BOOL finished) {
            [weakself.markView removeFromSuperview];
        }];
        
    };
    
    [window addSubview:weakself.markView];
}
#pragma  mark --- 解析数据 ---
-(void)reloadJosnForgetList:(NSString *)startTime endTime:(NSString *)endTime {

    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",kIpandPort,kgetUserAllinfo,[UserDefaults objectForKeyStr:kpid],@"&startTime=",startTime,@"&endTime=",endTime];
    
    DLog(@"查询总的营业额的 %@",str);
    
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            NSString *balance = dic[@"balance"];
            _myVC.my_top_lb1.text = [NSString stringWithFormat:@"当前余额 :%0.2f",[balance floatValue]/100];
            _myVC.my_leftView.titleLb.text = [NSString stringWithFormat:@"¥ %0.2f",[dic[@"rcmoney"] floatValue]/100];
            _myVC.my_RightView.titleLb.text = [NSString stringWithFormat:@"¥ %0.2f",[dic[@"txmoney"] floatValue]/100];
            _myVC.my_middleView.titleLb.text = [NSString stringWithFormat:@"¥ %0.2f",[dic[@"odmoneyall"] floatValue]/100];
            _myVC.my_top_leftView.titleLb.text = [NSString stringWithFormat:@"¥ %0.2f",[dic[@"odmoneycash"] floatValue]/100];
            _myVC.my_top_RightView.titleLb.text = [NSString stringWithFormat:@"¥ %0.2f",[dic[@"odmoneyonline"] floatValue]/100];
        }
        
    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
    }];
    
}

-(void)timeView:(ZLTimeView *)timeView seletedDateBegin:(NSString *)beginTime end:(NSString *)endTime {
   
    _startTime = [beginTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    _endTime = [endTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    _historyStartTime = _startTime;
    _historyEendTime = _endTime;
    
    [self reloadJosnForgetList:_startTime endTime:_endTime];
    
    DLog(@" -- start -- %@",beginTime);
    DLog(@" ++ end ++ %@",endTime);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
