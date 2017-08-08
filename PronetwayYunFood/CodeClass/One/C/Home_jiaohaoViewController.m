//
//  Home_jiaohaoViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/18.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_jiaohaoViewController.h"
#import "Home_jiaohao.h"
#import "AddViewController.h"
#import "paidui_listModel.h"
#import "leisureModel.h"
#import "CklSoundPlayer.h"
#import "paiHaoModel.h"
@interface Home_jiaohaoViewController ()<UITableViewDelegate ,UITableViewDataSource>
@property (strong, nonatomic) Home_jiaohao *jiaohao;
@property (strong, nonatomic) UIButton *rightBtn;
@property (strong, nonatomic) NSMutableArray *jiaoArr;
@property (strong, nonatomic) NSMutableArray *codeArr;
@property (strong, nonatomic) NSIndexPath *tabindex;
@property (strong, nonatomic) NSMutableArray *leishowArr;
@property (strong, nonatomic) TimeManager *timerManager;
@property (strong, nonatomic) NSMutableArray *mutilCodeArr;
@property (strong, nonatomic) NSMutableArray *sectionArr;
@property (strong, nonatomic) NSMutableArray *NextGetArr;
@property (strong, nonatomic) NSMutableArray *NextDelArr;


@property (strong, nonatomic) OkimageView *okimg;
@property (strong, nonatomic)    GuideView *markView;
@property (assign) int maerkshow;


@end

@implementation Home_jiaohaoViewController

-(void)viewWillAppear:(BOOL)animated {

    
   // [self reloadjosnForshow:NO];
}

-(void)viewDidDisappear:(BOOL)animated {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"叫号"];
    
   _jiaohao = [[Home_jiaohao alloc]initWithFrame:kBounds];
    [self.view addSubview:_jiaohao];
    [_jiaohao.NextBtn addTarget:self action:@selector(nextClick:) forControlEvents:(UIControlEventTouchUpInside)];
    _jiaohao.JHTabview.delegate = self;
    _jiaohao.JHTabview.dataSource = self;
    
    [self addrightBtn];
    
    [self reloadJosnForGteAllList];
    
    [kNotificationCenter addObserver:self selector:@selector(reloadjosn) name:@"reloadjosnForpaiduiGetlist" object:nil];
    
    if ([UserDefaults objectForKeyStr:kshowPD] == nil) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self showMarkView];
        });
    }
}

-(NSMutableArray *)jiaoArr {

    if (!_jiaoArr) {
        _jiaoArr = [[NSMutableArray alloc]init];
    }
    return _jiaoArr;
}
-(NSMutableArray *)mutilCodeArr {
    
    if (!_mutilCodeArr) {
        _mutilCodeArr = [[NSMutableArray alloc]init];
    }
    return _mutilCodeArr;
}

-(NSMutableArray *)sectionArr {
    
    if (!_sectionArr) {
        _sectionArr = [[NSMutableArray alloc]init];
    }
    return _sectionArr;
}
-(NSMutableArray *)NextGetArr {
    
    if (!_NextGetArr) {
        _NextGetArr = [[NSMutableArray alloc]init];
    }
    return _NextGetArr;
}
-(NSMutableArray *)NextDelArr {
    
    if (!_NextDelArr) {
        _NextDelArr = [[NSMutableArray alloc]init];
    }
    return _NextDelArr;
}



-(void)backAction {

    if ([PronetwayYunFoodHandle shareHandle].isToreadjosn ==YES) {
        
        NetworkManger *manger = [NetworkManger new];
        [manger paiduiupdate];
        manger.Addkezuofenqusuccessblock = ^{
            [PronetwayYunFoodHandle shareHandle].isToreadjosn = NO;
        [self.navigationController popViewControllerAnimated:YES];

        };
    }else {
    
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(NSMutableArray *)leishowArr {

    if (!_leishowArr) {
        _leishowArr = [[NSMutableArray alloc]init];
    }
    return _leishowArr;
}

-(void)reloadjosn {

    [self reloadJosnForGteAllList];
}

-(void)addrightBtn {
    
    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80*newKwith, 40*newKhight)];
    
    _rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _rightBtn.frame = CGRectMake(0, 0, 50*newKwith, 40*newKhight);
    [_rightBtn addTarget:self action:@selector(onpress1:) forControlEvents:(UIControlEventTouchUpInside)];
    [_rightBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    _rightBtn.titleLabel.font = kFont(12);
    //_rightBtn.hidden = YES;
    [_rightBtn setImage:kimage(@"Yun_dianpu_delete") forState:(UIControlStateNormal)];
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
    [btn addTarget:self action:@selector(onpress2:) forControlEvents:(UIControlEventTouchUpInside)];
    [rightButtonView addSubview:btn];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = bar;
    
}

//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _jiaoArr.count;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  1;
    
}
#pragma mark ------------ 展示cell -------------
//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jiaohaocell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[JHTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"jiaohaocell"];
    }
    cell.model = self.jiaoArr[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma mark -------- cell的点击事件 ---------
//cell 的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _tabindex = indexPath;
    _rightBtn.hidden = NO;
    if (self.jiaoArr.count>indexPath.section) {
        paidui_listModel *listModel = self.jiaoArr[indexPath.section];
        [self biaoModel:listModel Arr:self.jiaoArr];
       // [self reloadJosnForNext:listModel.sid];

    }
}

-(void)biaoModel:(paidui_listModel *)model Arr:(NSMutableArray *)listArr {

    [listArr enumerateObjectsUsingBlock:^(paidui_listModel *listModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([model.code isEqualToString:listModel.code]) {
            
            listModel.selected = YES;
            
        }else {
        
            listModel.selected = NO;
        }
    }];
    
    [_jiaohao.JHTabview reloadData];
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 20*newKhight;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 20*newKhight)];
    view.backgroundColor = kCbgColor;
    return view;
}
-(void)onpress1:(UIButton *)sender { //删除
    
    Alert *alrt = [[Alert alloc]init];
    if (self.jiaoArr.count>_tabindex.section) {
        paidui_listModel *model = self.jiaoArr[_tabindex.section];
        [alrt alert:[NSString stringWithFormat:@"是否删除选中桌子: %@",model.code]];

    }else {
        return;
    }
    alrt.alert.OKBlock = ^{
            paidui_listModel *model = self.jiaoArr[_tabindex.section];
             NetworkManger *manger = [NetworkManger new];
            [manger deletepaiduilist:model];
    };
}
-(void)onpress2:(UIButton *)sender {//新增按钮点击
    AddViewController *addView = [AddViewController new];
    addView.codearr = [self selectArr:self.mutilCodeArr];
    addView.maxArr = [self addminAndMaxArr:self.jiaoArr];
    
    [self.navigationController pushViewController:addView animated:YES];
}

//下一桌  get
-(void)reloadJosnForNext:(NSString *)type {

    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kjiaohGet,[UserDefaults objectForKeyStr:ksid],kjiaohGet1,type];
    DLog(@"下一桌 get %@",url);
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"]isEqualToString:@"0"]) {
        
            NSArray *arr = dic[@"eimdata"];
        
            if (arr.count == 0) {
                
                return ;
            }
            [self.NextGetArr removeAllObjects];
            
            for (NSDictionary *dictt in arr) {
                paiHaoModel *model = [paiHaoModel setUpModelWithDictionary:dictt];
                [self.NextGetArr addObject:model];
            }
            
            paiHaoModel *modelll = self.NextGetArr[0];
            DLog(@"get ---> %@",modelll.orderno);
            
            //冒泡排序 -- 从小到大
            [self paiMinToMax:self.NextGetArr];
            //删除
            if (self.NextGetArr.count == 0) {
                [WSProgressHUD showImage:nil status:@"此类型已经无人排队"];
                return;
            }
            paidui_listModel *model = self.jiaoArr[_tabindex.section];
            [self nextDel:self.NextGetArr[0] index:0 type:model.sid];
            
        }else if ([dic[@"result"]isEqualToString:@"1"]) {
        
            [WSProgressHUD showImage:nil status:@"此类型已经无人排队"];
        }
        else {
            [WSProgressHUD showImage:nil status:@"获取错误"];
        }
    } failure:^(NSError *error) {
        
        [WSProgressHUD showImage:nil status:@"服务器错误"];
    }];
}
//删除 -- 下一桌
-(void)nextDel:(paiHaoModel *)model index:(NSUInteger )index type:(NSString *)type {

    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",kIpandPort,kjiaohDel1,[UserDefaults objectForKeyStr:ksid],kjiaohDel2,type,kjiaohDel3,model.orderno];
    DLog(@"下一桌del -- %@",url);
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        DLog(@"del -- %@",dic);
        
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@""];
            
            [self playSound:[NSString stringWithFormat:@"下一桌%@00%@",model.typecode,model.orderno]];
            //删除nextgetArr在数组的位置
            [self.NextGetArr removeObjectAtIndex:index];
            
            [self reloadjosnForshow:NO];
            
        }else {
            
            [WSProgressHUD showImage:nil status:@"删除错误"];
        }
        
        
    } failure:^(NSError *error) {
        
        [WSProgressHUD showImage:nil status:@"服务器错误"];
    }];
    
}


-(void)paiMinToMax:(NSMutableArray *)Arr {

    for (int i = 0 ; i < [Arr count] - 1; i++) {
        for (int j = 0 ; j < [Arr count] - 1 - i; j++) {
            paiHaoModel *jmodel = Arr[j];
            paiHaoModel *JJmodel = Arr[j+1];
            if ([jmodel.addtime intValue]  > [JJmodel.addtime intValue] )//字符串转换int比较大小
            {
                [Arr exchangeObjectAtIndex:j withObjectAtIndex:(j+1)];
            }
        }
    }
}

//解析数据获取所有数据
-(void)reloadJosnForGteAllList {

    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",kIpandPort,kpaidui_getlist,[UserDefaults objectForKeyStr:ksid]];
    DLog(@"排队叫号%@",urlStr);
    [CKLRequestManger GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"]isEqualToString:@"0"]) {
            NSArray *arr = dic[@"eimdata"];
            
            [self.jiaoArr removeAllObjects];
            [self.mutilCodeArr removeAllObjects];
            [arr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                paidui_listModel *model = [paidui_listModel setUpModelWithDictionary:dict];
                [self.jiaoArr addObject:model];
                [self.mutilCodeArr addObject:model.code];
            }];
            
            if (self.jiaoArr.count == 0) {
                _rightBtn.hidden = YES;
                _tabindex = nil;
            }else {
                _rightBtn.hidden = NO;
            }
           // _tabindex = nil;
            
            [self reloadjosnForshow:YES];
            
        }else if ([dic[@"result"]isEqualToString:@"1"]) {
            
            [WSProgressHUD showImage:nil status:@"请先新增叫号类型"];
        }
        else {
            [WSProgressHUD showImage:nil status:@"查询出错"];
        }
    } failure:^(NSError *error) {
        DLog(@"%@",error);
    }];
}
//获取客桌空闲状态
-(void)reloadjosnForshow:(BOOL)scroTotop{

    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",kIpandPort,kpaidui_leisure,[UserDefaults objectForKeyStr:ksid]];
    DLog(@"获取客桌空闲状态%@",urlStr);
    
    [CKLRequestManger GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *arr = dic[@"eimdata"];
            if (arr.count == 0) {
                return ;
            }
            
            [arr enumerateObjectsUsingBlock:^(NSDictionary * dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                leisureModel *model = [leisureModel setUpModelWithDictionary:dict];
                [self.leishowArr addObject:model];
            }];
            
            //有桌子,比较一下.找到空闲桌
            if (self.jiaoArr.count!=0) {
                
            [self paixu:self.leishowArr jiaoArr:self.jiaoArr];
            }
            //找到之前桌子对应的model
            if (self.jiaoArr.count>_tabindex.section) {
                
            paidui_listModel *listModel = self.jiaoArr[_tabindex.section];
            [self biaoModel:listModel Arr:self.jiaoArr];
                
            }
            [_jiaohao.JHTabview reloadData];
            
        }else {
            [WSProgressHUD showImage:nil status:@"更新失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}


//根据类型匹配空闲桌
-(void)paixu:(NSMutableArray *)leisureArr jiaoArr:(NSMutableArray *)jiaoArr {

    [jiaoArr enumerateObjectsUsingBlock:^(paidui_listModel * listModel, NSUInteger listidx, BOOL * _Nonnull stop) {
        
        [leisureArr enumerateObjectsUsingBlock:^(leisureModel *leiModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([listModel.sid isEqualToString:leiModel.tpyeid]) {
                
                listModel.totque = leiModel.totque;
                listModel.totidle = leiModel.totidle;
                
                [jiaoArr replaceObjectAtIndex:listidx withObject:listModel];
                
            }
        }];
    }];
}

//去重
-(NSArray *)selectArr:(NSMutableArray *)Arr {

   self.codeArr = [NSMutableArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F", nil];
    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",Arr];
    NSArray * filter = [self.codeArr filteredArrayUsingPredicate:filterPredicate];
    return filter;
    
}

//添加各个桌子的最大值,最小值
-(NSMutableArray *)addminAndMaxArr:(NSMutableArray *)Arr {

    [self.sectionArr removeAllObjects];
    [Arr enumerateObjectsUsingBlock:^(paidui_listModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *mutArr = [NSMutableArray array];
        [mutArr addObject:model.minnum];
        [mutArr addObject:model.maxnum];
        [self.sectionArr addObject:mutArr];
    }];
    
    return  self.sectionArr ;
}


-(void)nextClick:(RedBtn *)btn {
    
    if (self.jiaoArr.count == 0) {
        [WSProgressHUD showImage:nil status:@"请先新增客桌类型!"];
        return;
    }
  
    if (self.jiaoArr.count>_tabindex.section) {
        
        paidui_listModel *model = self.jiaoArr[_tabindex.section];
        [self reloadJosnForNext:model.sid];

    }
}


-(void)playSound:(NSString *)str {

    CklSoundPlayer *player = [CklSoundPlayer SDSoundPlayerInit];
    [player setDefaultWithVolume:-1.0 rate:0.5 pitchMultiplier:-1.0];
    [player play:str];
    
}

#pragma mark -- 蒙板页 --

-(OkimageView *)okimg {
    
    
    if (!_okimg) {
        _okimg = [[OkimageView alloc]initWithFrame:CGRectMake((kWidth-140*newKwith)/2, kHeight-118*newKhight-70*newKhight, 140*newKwith, 118*newKhight)];
    }
    
    
    return _okimg;
}

-(void)showMarkView {
    
    _markView = [[GuideView alloc]initWithFrame:kBounds];
    _markView.fullShow = YES;
    _markView.model = GuideViewCleanModeRoundRect;
    //markView.guideColor = kCbgColor;
    _markView.showRect = CGRectMake(kWidth-48*newKwith, kStatusBarH, 34*newKwith, 40*newKhight);
    _markView.markText = @"在此添加叫号分类";
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    
    [_markView addSubview:self.okimg];
    
    WeakType(self);
    self.okimg.Click = ^{
    
            [UIView animateWithDuration:0.3 animations:^{
                [UserDefaults setObjectleForStr:@"YES" key:kshowPD];
                weakself.markView.alpha = 0;
            } completion:^(BOOL finished) {
                [weakself.markView removeFromSuperview];
            }];
        
    };
    
    [window addSubview:weakself.markView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
