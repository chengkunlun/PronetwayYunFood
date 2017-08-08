//
//  OneViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/10.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "OneViewController.h"
#import "YunHomeView.h"
#import "Home_paiduiViewController.h"
#import "Home_shujuViewController.h"
#import "Home_dianpuViewController.h"
#import "Home_wifiViewController.h"
#import "Home_huiyuanViewController.h"
#import "Home_CaipinViewController.h"
#import "AdddianpuViewController.h"
#import "dianpuModel.h"
#import "SelectViewController.h"
#import "SystemViewController.h"

@interface OneViewController ()<selectDelegate,guideDelagate>

@property (strong, nonatomic) YunHomeView *YunHomeVC;
@property (strong, nonatomic) NSMutableArray *dianpuArr;
@property (strong, nonatomic) NSString *gotowhere;
@property (strong, nonatomic) TimeManager *timeManger;
@property (strong, nonatomic) OkimageView *okimg;
@property (strong, nonatomic)    GuideView *markView;
@property (strong, nonatomic) GuideView *caiPMarkView;
@property (assign) int maerkshow;

@property (assign) BOOL isClicked;

@end

@implementation OneViewController

-(void)viewWillAppear:(BOOL)animated {

    [self reloadJosnForgetalldianpulist];
    
    if (kStringIsEmpty([UserDefaults objectForKeyStr:kdianpuName])) {
        
        [self setCustomerTitle:@"首页"];
        
    }else {
    
        [self setCustomerTitle: [NSString stringWithFormat:@"%@",[UserDefaults objectForKeyStr:kdianpuName]]];
    }
    [self.timeManger pq_open];
    
    //1 是否显示我的店面蒙板页面
        //添加蒙板
        if ([UserDefaults objectForKeyStr:kshowMengbanHome] == nil || [UserDefaults objectForKeyStr:kshowdeskManager] == nil) {
            
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 
            [self showMarkView];
             });
        }
    
   //2 是否展示菜品管理蒙板页面
    if ([UserDefaults objectForKeyStr:kshowMengbanHome] != nil && [UserDefaults objectForKeyStr:kshowdeskManager] != nil) {
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([UserDefaults objectForKeyStr:kshowCai] == nil) {
                
                [self showCaipmarkView];
            }
        });
    }
}
-(void)viewDidDisappear:(BOOL)animated {

    [self.timeManger pq_close];
}

-(NSMutableArray *)dianpuArr {

    if (!_dianpuArr) {
        _dianpuArr = [[NSMutableArray alloc]init];
    }
    return _dianpuArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"首页"];
    
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    double deviceLevel = [UIDevice currentDevice].batteryLevel;
    DLog(@"%0.2f",deviceLevel);
    
    //解析数据
    [self reloadJosnForgetalldianpulist];
    
    _YunHomeVC = [[YunHomeView alloc]initWithFrame:kBounds];
    [_YunHomeVC.home_caipinBtn addTarget:self action:@selector(caipinBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_YunHomeVC];
    
    WeakType(self);
    self.NavBarTapClick = ^{//navvar的点击事件
      
        if (![ValidateUtil checkuserType]) {
            [WSProgressHUD showImage:nil status:@"暂无权限!"];
            return ;
        }
        
        SelectViewController *seleVC = [[SelectViewController alloc]init];
        seleVC.selectstr = @"选择店铺";
        seleVC.delegate = weakself;
        seleVC.selectArr = weakself.dianpuArr;
        [weakself.navigationController pushViewController:seleVC animated:YES];
    
    };
    
    
    //排队
    _YunHomeVC.canjuBlock = ^{
        
        if (_isClicked == NO) {
            
            [WSProgressHUD showImage:nil status:@"请先设置店面"];
            return;
        }
        weakself.hidesBottomBarWhenPushed=YES;
        Home_paiduiViewController *next=[[Home_paiduiViewController alloc]init];
        [weakself.navigationController pushViewController:next animated:YES];
        weakself.hidesBottomBarWhenPushed=NO;
        
        DLog(@"排队");
    };
    //排队
    _YunHomeVC.shujuBlock= ^{
        //按钮不能被点击,没有添加店铺
        if (_isClicked == NO) {
            
            [WSProgressHUD showImage:nil status:@"请先设置店面"];
            return;
        }
        weakself.hidesBottomBarWhenPushed=YES;
        Home_shujuViewController *next=[[Home_shujuViewController alloc]init];
        [weakself.navigationController pushViewController:next animated:YES];
        weakself.hidesBottomBarWhenPushed=NO;
        DLog(@"数据分析");
    };//排队
    _YunHomeVC.dianpuBlock = ^{

        weakself.hidesBottomBarWhenPushed=YES;
        
        if ([[PronetwayYunFoodHandle shareHandle].gotoweher isEqualToString:@"home"]) {
            AdddianpuViewController *adddianpu = [AdddianpuViewController new];
            adddianpu.selectstr = @"home";
            [weakself.navigationController pushViewController:adddianpu animated:YES];
            weakself.hidesBottomBarWhenPushed=NO;
            [weakself ShowMarkViewdismiss];

        }else {
            Home_dianpuViewController *next=[[Home_dianpuViewController alloc]init];
            [weakself.navigationController pushViewController:next animated:YES];
            weakself.hidesBottomBarWhenPushed=NO;
            [weakself ShowMarkViewdismiss];

        }
            DLog(@"店铺设置");
    };//排队
    _YunHomeVC.wifiBlock = ^{
        
        weakself.hidesBottomBarWhenPushed=YES;
        SystemViewController *next=[[SystemViewController alloc]init];
        [weakself.navigationController pushViewController:next animated:YES];
        weakself.hidesBottomBarWhenPushed=NO;
        DLog(@"系统设置");
    };//排队
    _YunHomeVC.huiyuanBlock = ^{
        if (_isClicked == NO) {
            
            [WSProgressHUD showImage:nil status:@"请先设置店面"];
            return;
        }
        weakself.hidesBottomBarWhenPushed=YES;
        Home_huiyuanViewController *next=[[Home_huiyuanViewController alloc]init];
        [weakself.navigationController pushViewController:next animated:YES];
        weakself.hidesBottomBarWhenPushed=NO;
        DLog(@"我的会员");
    };
}

-(OkimageView *)okimg {
    if (!_okimg) {
        _okimg = [[OkimageView alloc]initWithFrame:CGRectMake((kWidth-140*newKwith)/2, kHeight-118*newKhight-70*newKhight, 140*newKwith, 118*newKhight)];
    }
    
    return _okimg;
}

-(void)showMarkView {
    
    _markView = [[GuideView alloc]initWithFrame:kBounds];
    _markView.fullShow = YES;
   // _markView.userInteractionEnabled = YES;
    
    _markView.model = GuideViewCleanModeRoundRect;
    //markView.guideColor = kCbgColor;
    _markView.showRect = CGRectMake(self.YunHomeVC.home_shujuView.X,  self.YunHomeVC.home_shujuView.endY+10*newKhight+kNavBarHAndStaBarH, 86*newKwith, 114*newKhight);
    _markView.markText = @"请先设置店铺信息\n开启云点餐管理!";
    _markView.delegate = self;
        //添加
    [[UIApplication sharedApplication].keyWindow addSubview:self.markView];

}

-(void)ShowMarkViewdismiss {

    [UIView animateWithDuration:0.3 animations:^{
        self.markView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.markView removeFromSuperview];
    }];
    
}

-(void)caiPmarkDismiss {

    [UIView animateWithDuration:0.3 animations:^{
        self.caiPMarkView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.caiPMarkView removeFromSuperview];
    }];
    
}


//展示菜品的蒙板view
-(void)showCaipmarkView {

    _caiPMarkView = [[GuideView alloc]initWithFrame:kBounds];
    _caiPMarkView.fullShow = YES;
    _caiPMarkView.model = GuideViewCleanModeRoundRect;
    _caiPMarkView.showRect = CGRectMake(0, 0, kWidth, 155*newKhight+kTabBarH+kStatusBarH);
    _caiPMarkView.markText = @"在此设置您的菜品,并进行管理!";
    _caiPMarkView.delegate = self;
    //添加
    [[UIApplication sharedApplication].keyWindow addSubview:self.caiPMarkView];
}


//菜品管理
-(void)caipinBtnClick:(UIButton *)btn{

    if (_isClicked == NO) {
        
        [WSProgressHUD showImage:nil status:@"请先设置店面"];
        return;
    }
    self.hidesBottomBarWhenPushed = YES;
    Home_CaipinViewController *caipinVC =[Home_CaipinViewController new];
    [self.navigationController pushViewController:caipinVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


-(void)reloadJosnForgetalldianpulist {

    NSString *urlstr;
    //
    if ([ValidateUtil checkuserType]) {//老板
        //老板
        urlstr = [NSString stringWithFormat:@"%@%@%@%@",kIpandPort,kgetAlldianpu1,kgetAlldianpu4,[UserDefaults objectForKeyStr:kpid]];
        
    }else {//营业账户
        
        urlstr = [NSString stringWithFormat:@"%@%@%@%@%@%@",kIpandPort,kgetAlldianpu1,kgetAlldianpu5,[UserDefaults objectForKeyStr:ksid],kgetAlldianpu4,[UserDefaults objectForKeyStr:kpid]];
    }
    DLog(@"获取所有店铺信息 -- %@",urlstr);
    [CKLRequestManger GET:urlstr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        DLog(@"All is - %@",dic);
        NSString *result = dic[@"result"];
        if ([result isEqualToString:@"0"]) {
            
            [self.timeManger pq_close];
            //获取成功
            NSArray *arr = dic[@"eimdata"];
            
            if (arr.count!=0) {
                [PronetwayYunFoodHandle shareHandle].gotoweher = @"";
                [self.dianpuArr removeAllObjects];
                for (NSDictionary *dict in arr) {
                    
                    dianpuModel *model = [dianpuModel setUpModelWithDictionary:dict];
                    [self.dianpuArr addObject:model];
                }
                //设置店铺名称
                if (![ValidateUtil checkuserType]) {//营业账号
                    
                    dianpuModel *dmodel = self.dianpuArr[0];
                    [UserDefaults setObjectleForStr:dmodel.name key:kdianpuName];
                    [UserDefaults setObjectleForStr:dmodel.address key:kadress];
                    [UserDefaults setObjectleForStr:dmodel.tel key:kdianputel];
                    [self setCustomerTitle:[UserDefaults objectForKeyStr:kdianpuName]];
                    
                }
                if (self.dianpuArr.count!=0) {
                    _isClicked = YES;
                }
                
            }else {//为空,没有添加过
                [PronetwayYunFoodHandle shareHandle].gotoweher = @"home";
            }
        }else {
        
            [PronetwayYunFoodHandle shareHandle].gotoweher = @"home";
        }
        
    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        [PronetwayYunFoodHandle shareHandle].gotoweher = @"home";
        
        [self.timeManger pq_close];
       self.timeManger = [TimeManager pq_createTimerWithType:PQ_TIMERTYPE_CREATE_OPEN updateInterval:5 repeatInterval:1 update:^{
            
            [self reloadJosnForgetalldianpulist];
        }];
    }];
}

-(void)dealloc {

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(void)onprsee:(UITapGestureRecognizer *)tap superselef:(UIView *)superself {

    if (superself == _markView) {
        
        //取得所点击的点的坐标
        CGPoint point = [tap locationInView:self.markView];
        // 判断该点在不在区域内
        if (CGRectContainsPoint(_markView.showRect,point))
        {
            DLog(@"----");
            
            self.hidesBottomBarWhenPushed=YES;
            
            if ([[PronetwayYunFoodHandle shareHandle].gotoweher isEqualToString:@"home"]) {
                AdddianpuViewController *adddianpu = [AdddianpuViewController new];
                adddianpu.selectstr = @"home";
                [self.navigationController pushViewController:adddianpu animated:YES];
                self.hidesBottomBarWhenPushed=NO;
                [self ShowMarkViewdismiss];
                
            }else {
                Home_dianpuViewController *next=[[Home_dianpuViewController alloc]init];
                [self.navigationController pushViewController:next animated:YES];
                self.hidesBottomBarWhenPushed=NO;
                [self ShowMarkViewdismiss];
            }
        }
    }else if (superself == _caiPMarkView) {
    
        //取得所点击的点的坐标
        CGPoint point = [tap locationInView:self.markView];
        // 判断该点在不在区域内
        if (CGRectContainsPoint(_caiPMarkView.showRect,point))
        {
            
            [self caiPmarkDismiss];
            
            self.hidesBottomBarWhenPushed = YES;
            Home_CaipinViewController *caipinVC =[Home_CaipinViewController new];
            [self.navigationController pushViewController:caipinVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
