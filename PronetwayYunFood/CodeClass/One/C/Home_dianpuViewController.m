//
//  Home_dianpuViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_dianpuViewController.h"
#import "AdddianpuViewController.h"
#import "kezhuoViewController.h"
#import "dianpuView.h"
#import "dianpuTableViewCell.h"
#import "SelectViewController.h"
#import "dianpuModel.h"
#import "DYdianpuViewController.h"
@interface Home_dianpuViewController ()<UITableViewDelegate,UITableViewDataSource,selectDelegate,addDianpudelegate,guideDelagate>
 @property (strong, nonatomic) UIButton *rightBtn;
@property (strong, nonatomic) dianpuView *dianpuVC;
@property (strong, nonatomic) UITableView *dianpuTab;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIImageView *img;
@property (strong, nonatomic) UILabel *lab;
@property (strong, nonatomic) UIImageView *arrowimg;
@property (strong, nonatomic) NSMutableArray *cellshowArr;
@property (strong, nonatomic) NSMutableArray *ritArr;

@property (strong, nonatomic) OkimageView *okimg;
@property (strong, nonatomic)    GuideView *markView;
@property (strong, nonatomic) GuideView *mangerDeskMarkview;
@property (assign) int maerkshow;

//店铺model
@property (strong, nonatomic) dianpuModel *Dmodel;

@end

@implementation Home_dianpuViewController


-(void)viewWillAppear:(BOOL)animated {

    [self reloaJosnForgetAllList];

    if ([UserDefaults objectForKeyStr:kshowMengbanHome] != nil) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([UserDefaults objectForKeyStr:kshowDMhome] == nil) {
                [self showMarkView];
            }
        });
    }
    if ([UserDefaults objectForKeyStr:kshowdeskManager] == nil && [UserDefaults objectForKeyStr:kshowMengbanHome] !=nil && [UserDefaults objectForKeyStr:kshowDMhome] != nil) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self showDeskMarkView];

        });
        
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle:@"店面设置"];
    
    
    _ritArr = [NSMutableArray arrayWithObjects:@"店铺名称",@"店铺电话",@"开始营业时间",@"结束营业时间",@"店铺地址",@"营业账号", nil];
    
   // UIBarButtonItem *rit = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    //self.navigationItem.rightBarButtonItem = rit;
    
    [self addrightBtn];
    
    _dianpuVC = [[dianpuView alloc]initWithFrame:kBounds];
    [self.view addSubview:_dianpuVC];
    [_dianpuVC.kezhuobtn addTarget:self action:@selector(kezhuoClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_dianpuVC.dybtn addTarget:self action:@selector(dyClick:) forControlEvents:(UIControlEventTouchUpInside)];

    //添加tabview
    [self.view addSubview:self.dianpuTab];
    //添加头视图
    [self.view addSubview:self.headerView];
    
    // 接收新增和修改的通知
   // [kNotificationCenter addObserver:self selector:@selector(reloadJosnForgetAll) name:@"reloadJosnforAlldianpu" object:nil];
    
    
    // Do any additional setup after loading the view.
}
#pragma ---- 懒加载 ----
-(NSMutableArray *)AlldianpuArr {
    if (!_AlldianpuArr) {
        _AlldianpuArr = [[NSMutableArray alloc]init];
    }
    return _AlldianpuArr;
}
-(NSMutableArray *)cellshowArr {
    if (!_cellshowArr) {
        _cellshowArr = [[NSMutableArray alloc]init];
    }
    return _cellshowArr;
}
//返回按钮实现方法
-(void)backAction {
    
    if ([self.selectStr isEqualToString:@"home"]) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark --- 实现代理方法 ---
//select代理方法
-(void)onpressSelectDianpu {
    
    [self reloaJosnForgetAllList];
}

//新增店铺返回最新的
-(void)adddianpuArr:(NSArray *)Arr {
//重新赋值,更新信息
    
    NSMutableArray *mutolArr = [NSMutableArray array];
    if (Arr.count != 0) {
        
        for (NSDictionary *dict in Arr) {
            
            dianpuModel *model = [dianpuModel setUpModelWithDictionary:dict];
            [mutolArr addObject:model];
            
        }
        if (mutolArr.count!=0) {
            [self.cellshowArr removeAllObjects];
            dianpuModel *model = mutolArr[0];
            [UserDefaults setObjectleForStr:model.sid key:ksid];
            [self.cellshowArr addObject:model.name];
            [self.cellshowArr addObject:model.tel];
            [self.cellshowArr addObject:model.starttime];
            [self.cellshowArr addObject:model.endtime];
            [self.cellshowArr addObject:model.address];
            [UserDefaults setObjectleForStr:model.address key:kadress];
            [UserDefaults setObjectleForStr:model.name key:kdianpuName];
            [UserDefaults setObjectleForStr:model.tel key:kdianputel];
            _lab.text = model.name;
            [self.dianpuTab reloadData];
        }
    }
}

-(void)dyClick:(UIButton *)btn {

    DYdianpuViewController *dyVC = [DYdianpuViewController new];
    [self.navigationController pushViewController:dyVC animated:YES];
    
}
//切换店铺 -- 营业账号无权限
-(void)headViewclick:(UITapGestureRecognizer *)tap {
    
    if (![ValidateUtil checkuserType]) {
        
        [WSProgressHUD showImage:nil status:@"暂无权限!"];
        return;
    }

    SelectViewController *seleVC = [[SelectViewController alloc]init];
    seleVC.selectstr = @"选择店铺";
    seleVC.delegate = self;
    seleVC.selectArr = self.AlldianpuArr;
    [self.navigationController pushViewController:seleVC animated:YES];
}

-(UIView *)headerView {

    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 5*newKwith, kWidth, 44*newKhight)];
        _headerView.backgroundColor = RGB(222, 222, 222);
        UIView *whbgView = [[UIView alloc]initWithFrame:CGRectMake(10, 7*newKhight, kWidth-20*newKwith, 30*newKhight)];
        whbgView.backgroundColor = kWhiteColor;
        whbgView.layer.masksToBounds = YES;
        whbgView.layer.cornerRadius = 5;
        [_headerView addSubview:whbgView];
        
        _img = [[UIImageView alloc]initWithFrame:CGRectMake(5*newKwith, 8*newKhight, 18*newKwith, 14*newKhight)];
        _img.image = kimage(@"Yun_dianpu_dianpu");
        [whbgView addSubview:_img];
        
        _lab = [[UILabel alloc]initWithFrame:CGRectMake(_img.endX+5*newKwith, 0, kWidth, 30*newKhight)];
        _lab.textColor = kRedColor;
        _lab.font = kFont(15);
        _lab.text = @"";
        [whbgView addSubview:_lab];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headViewclick:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [whbgView addGestureRecognizer:tap];
    }
    return _headerView;
    
}

#pragma  mark --------- 添加tabview --------
-(UITableView *)dianpuTab {

    if (!_dianpuTab) {
        _dianpuTab = [[UITableView alloc]initWithFrame:CGRectMake(15*newKwith, 59*newKhight, kWidth-30*newKwith, kHeight-103*newKhight-kNavBarHAndStaBarH)];
        
        _dianpuTab.delegate = self;
        _dianpuTab.dataSource = self;
        [_dianpuTab registerClass:[dianpuTableViewCell class] forCellReuseIdentifier:@"dianpucell"];
        _dianpuTab.backgroundColor = kCbgColor;
        _dianpuTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _dianpuTab;
}

//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _cellshowArr.count;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  1;
    
}

//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    dianpuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dianpucell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[dianpuTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"dianpucell"];
    }
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 5;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.cellshowArr.count!=0) {
        cell.lab1.text = self.cellshowArr[indexPath.section];
        cell.lab2.text = self.ritArr[indexPath.section];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth-30*newKwith, 10*newKhight)];
    vi.backgroundColor = kCbgColor;
    return vi;
    
}

-(void)addrightBtn {

    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80*newKwith, 40*newKhight)];
    
    _rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _rightBtn.frame = CGRectMake(0, 0, 50*newKwith, 40*newKhight);
    [_rightBtn addTarget:self action:@selector(press2) forControlEvents:(UIControlEventTouchUpInside)];
    [_rightBtn setTitle:@"修改" forState:(UIControlStateNormal)];
    _rightBtn.titleLabel.font = kFont(12);
    [_rightBtn setImage:kimage(@"Yun_dianpu_change") forState:(UIControlStateNormal)];
    [_rightBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop  imageTitleSpace:5*newKhight];
    [_rightBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [rightButtonView addSubview:_rightBtn];
    
    //右按钮
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(40*newKwith, 0, 50*newKwith,40*newKhight);
    [btn setTitle:@"新增" forState:(UIControlStateNormal)];
    btn.titleLabel.font = kFont(12);
    [btn setImage:kimage(@"icon_plus") forState:(UIControlStateNormal)];
    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop  imageTitleSpace:5*newKhight];
    [btn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(press) forControlEvents:(UIControlEventTouchUpInside)];
    [rightButtonView addSubview:btn];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = bar;
    
}

//修改-----
-(void)press2 {
    
    if (![ValidateUtil checkuserType]) {
        
        [WSProgressHUD showImage:nil status:@"暂无权限!"];
        return;
    }

     AdddianpuViewController *addVC = [AdddianpuViewController new];
     addVC.selectstr = @"change";
   
    if (self.cellshowArr.count!=0) {
        addVC.model = _Dmodel;
        addVC.ChangeArr = self.cellshowArr;
    }
     [self.navigationController pushViewController:addVC animated:YES];
}
//新增
-(void)press {
    if (![ValidateUtil checkuserType]) {
        
        [WSProgressHUD showImage:nil status:@"暂无权限!"];
        return;
    }
    AdddianpuViewController *addVC = [AdddianpuViewController new];
    addVC.delegate = self;
    [self.navigationController pushViewController:addVC animated:YES];
}
//课桌管理
-(void)kezhuoClick:(UIButton *)btn {

 [self.navigationController pushViewController:[kezhuoViewController new] animated:YES];
}

//获取所有店铺信息
-(void)reloaJosnForgetAllList {
    
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
            //获取成功
            NSArray *arr = dic[@"eimdata"];
            
            if (arr.count == 0) {
                return ;
            }
            if (arr.count!=0) {
                
            [PronetwayYunFoodHandle shareHandle].gotoweher = @"";//下次就不获取了
            [self.AlldianpuArr removeAllObjects];
                
            for (NSDictionary *dict in arr) {
                
            dianpuModel *model = [dianpuModel setUpModelWithDictionary:dict];
            [self.AlldianpuArr addObject:model];
            
          }
                
                if (kStringIsEmpty([UserDefaults objectForKeyStr:ksid])) {//第一次默认的
                    
                    if (self.AlldianpuArr.count!=0) {
                    dianpuModel *model = self.AlldianpuArr[0];
                        _Dmodel = model;
                    [UserDefaults setObjectleForStr:model.sid key:ksid];
                    [self.cellshowArr addObject:model.name];
                    [self.cellshowArr addObject:model.tel];
                    [self.cellshowArr addObject:model.starttime];
                    [self.cellshowArr addObject:model.endtime];
                    [self.cellshowArr addObject:model.address];
                    [self.cellshowArr addObject:model.username];
                    [UserDefaults setObjectleForStr:model.address key:kadress];
                    [UserDefaults setObjectleForStr:model.name key:kdianpuName];
                        [UserDefaults setObjectleForStr:model.tel key:kdianputel];

                        _lab.text = model.name;
                        [self.dianpuTab reloadData];
                    return ;
                }
            }
                for (dianpuModel *model in self.AlldianpuArr) {//上次选中的
                    
                    if ([[UserDefaults objectForKeyStr:ksid] isEqualToString:model.sid]) {
                        //先删除数据
                        [self.cellshowArr removeAllObjects];
                        //赋值 -- 修改时候用
                        _Dmodel = model;

                        [self.cellshowArr addObject:model.name];
                        [self.cellshowArr addObject:model.tel];
                        [self.cellshowArr addObject:model.starttime];
                        [self.cellshowArr addObject:model.endtime];
                        [self.cellshowArr addObject:model.address];
                        [self.cellshowArr addObject:model.username];
                        _lab.text = model.name;
                        [UserDefaults setObjectleForStr:model.address key:kadress];
                        [UserDefaults setObjectleForStr:model.name key:kdianpuName];
                        [UserDefaults setObjectleForStr:model.tel key:kdianputel];

                        [self.dianpuTab reloadData];
                        break;
                    }
                }
         }else {//为空,没有添加过
             
             
    }
            
      }else {
            
            
        }
        
    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
        
    }];
    
    
}


-(OkimageView *)okimg {
    
    
    if (!_okimg) {
        _okimg = [[OkimageView alloc]initWithFrame:CGRectMake((kWidth-140*newKwith)/2, kHeight-118*newKhight-70*newKhight, 140*newKwith, 118*newKhight)];
    }
    
    
    return _okimg;
}

-(void)showMarkView {
    
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    
    _markView = [[GuideView alloc]initWithFrame:kBounds];
    _markView.fullShow = YES;
    _markView.model = GuideViewCleanModeRoundRect;
    //markView.guideColor = kCbgColor;
    _markView.showRect = CGRectMake(0, kNavBarHAndStaBarH, kWidth, 44*newKhight);
    _markView.markText = @"如果您有多家门店可以在此选择当前要展示的店铺";
    [_markView addSubview:self.okimg];
    
    WeakType(self);
    self.okimg.Click = ^{
        //取消对店铺的提示
        [UserDefaults setObjectleForStr:@"YES" key:kshowDMhome];
        
        [weakself showmarkdismiss];
        
        if ([kUserDefaults objectForKey:kshowdeskManager] == nil) {
            
            [weakself showDeskMarkView];
        }
        
    };
    
    [window addSubview:weakself.markView];
}

-(void)showDeskMarkView {
    _mangerDeskMarkview = [[GuideView alloc]initWithFrame:kBounds];
    _mangerDeskMarkview.fullShow = YES;
    _mangerDeskMarkview.model = GuideViewCleanModeRoundRect;
    //markView.guideColor = kCbgColor;
    _mangerDeskMarkview.showRect = CGRectMake(kWidth/2+5*newKwith, kHeight-44*newKhight+5*newKhight, kWidth/2, 44*newKhight);
    [PronetwayYunFoodHandle shareHandle].dianpuright = @"dianpuright";
    _mangerDeskMarkview.markText = @"在此添加并\n管理您的客桌!";
    _mangerDeskMarkview.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:_mangerDeskMarkview];
}
-(void)showmarkdismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.markView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.markView removeFromSuperview];
    }];
}
-(void)deskmanagerdismiss {

    [UIView animateWithDuration:0.3 animations:^{
        self.mangerDeskMarkview.alpha = 0;
    } completion:^(BOOL finished) {
        [PronetwayYunFoodHandle shareHandle].dianpuright = @"";
        
        [self.mangerDeskMarkview removeFromSuperview];
    }];
}

-(void)onprsee:(UITapGestureRecognizer *)tap superselef:(UIView *)superself {

    if (superself == _mangerDeskMarkview) {
        
        CGPoint point = [tap locationInView:self.mangerDeskMarkview];
        // 判断该点在不在区域内
        if (CGRectContainsPoint(_mangerDeskMarkview.showRect,point))
        {
            DLog(@"----");
            //展示
            [self deskmanagerdismiss];
            
            [self.navigationController pushViewController:[kezhuoViewController new] animated:YES];
        }
    }
}

-(void)dealloc {

    [kNotication removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
