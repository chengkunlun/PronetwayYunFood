//
//  ThreeViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/10.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "ThreeViewController.h"
#import "Yun_incomeMoneyView.h"
#import "Income_NodesknumberViewController.h"
#import "Yun_order_DCViewController.h"
#import "DCSearchTableViewCell.h"
#import "kezhuoModel.h"
#import "collectHeaderView.h"
#import "IncomeListViewController.h"
#import "FishMealViewController.h"

#define kheaderIdentifier @"headerIdentifier"
#define kfooterIdentifier @"footerIdentifier"

@interface ThreeViewController ()
@property (strong, nonatomic) UIButton *issueButton;
@property (strong, nonatomic)Yun_incomeMoneyView *incomeMoneyVC;


//所有桌子的数组
@property (strong, nonatomic) NSMutableArray *AlldeskArr;

//tableView
@property (nonatomic,strong) UITableView *skTableView;

//搜索历史view
@property (strong, nonatomic)UILabel *hostNameLab;

@property (strong, nonatomic) UICollectionView *searchCollect;
@property (strong, nonatomic) NSMutableArray *searchArr;
@property (strong, nonatomic) UIView *headerView;
//排序的
@property (strong, nonatomic) NSMutableArray *PaisearchArr;
//数据本地处理;
@property (strong, nonatomic) NSMutableDictionary *mutilDic;
@property (strong, nonatomic) TimeManager *timerManager;

//蒙板处理
@property (strong, nonatomic) OkimageView *okimg;
@property (strong, nonatomic) GuideView *markView;
@property (assign) int maerkshow;
@property (strong, nonatomic) NSTimer *showmarkTimr;
@property (assign) BOOL isShow;

@end

@implementation ThreeViewController

-(void)viewWillAppear:(BOOL)animated {
    //请求数据
    [self reloadJosnForfenqu];
    
    [self.timerManager pq_open];
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [self.timerManager pq_close];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.timerManager = [TimeManager pq_createTimerWithType:PQ_TIMERTYPE_CREATE_OPEN updateInterval:5 repeatInterval:1 update:^{
        
        [self reloadJosnForfenqu];
        DLog(@"收银桌面更新--更新");
        
    }];

    [self setCustomerTitle:@"收银"];
    _incomeMoneyVC = [[Yun_incomeMoneyView alloc]initWithFrame:kBounds];

    _incomeMoneyVC.Yun_order_Tab.delegate = self;
    _incomeMoneyVC.Yun_order_Tab.dataSource = self;
    _incomeMoneyVC.Yun_order_collect.delegate = self;
    _incomeMoneyVC.Yun_order_collect.dataSource = self;
    self.definesPresentationContext=YES;
    [_incomeMoneyVC.Yun_order_collect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    _incomeMoneyVC.searchController.searchBar.delegate = self;
    [self.view addSubview:_incomeMoneyVC];
    [self addrightBtn];
    
}

-(void)addrightBtn{

    UIImage *issueImage = kimage(@"Yun_income_rightBtn");
    self.issueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.issueButton.frame = CGRectMake(0, 0, 70*newKwith, 40*newKhight);
    [_issueButton setImage:issueImage forState:UIControlStateNormal];
    
    [_issueButton setTitle:@"无桌号收银" forState:UIControlStateNormal];
    [_issueButton setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    _issueButton.titleLabel.font = [UIFont systemFontOfSize:11];
    
    [_issueButton addTarget:self action:@selector(issueBton:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat totalHeight = (_issueButton.imageView.frame.size.height + _issueButton.titleLabel.frame.size.height);
    
    // 设置按钮图片偏移
    [_issueButton setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - _issueButton.imageView.frame.size.height), 0.0, 0.0, -_issueButton.titleLabel.frame.size.width)];
    // 设置按钮标题偏移
    [_issueButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -_issueButton.imageView.frame.size.width, -(totalHeight - _issueButton.titleLabel.frame.size.height),0.0)];
    
    //添加到导航条
    UIBarButtonItem *leftBarButtomItem = [[UIBarButtonItem alloc]initWithCustomView:_issueButton];
    self.navigationItem.rightBarButtonItem = leftBarButtomItem;

    
}
-(void)issueBton:(UIButton *)btn {

    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[Income_NodesknumberViewController new] animated:YES];
    self.hidesBottomBarWhenPushed =NO;
    DLog(@"无桌号收银");
    
}
-(NSMutableArray *)Yun_order_TabArr {
    
    if (!_Yun_order_TabArr) {
        _Yun_order_TabArr = [[NSMutableArray alloc]init];
    }
    return _Yun_order_TabArr;
}
-(NSMutableArray *)collectArr {
    
    if (!_collectArr) {
        _collectArr = [[NSMutableArray alloc]init];
    }
    return _collectArr;
}
- (NSMutableArray *)searchArr
{
    if (!_searchArr)
    {
        _searchArr = [NSMutableArray array];
    }
    return _searchArr;
}
- (NSMutableArray *)AlldeskArr
{
    if (!_AlldeskArr)
    {
        _AlldeskArr = [NSMutableArray array];
    }
    return _AlldeskArr;
    
}

//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.Yun_order_TabArr.count;
    
}
//展示cell---tabview
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Yun_leftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yun_income_tabcell"forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[Yun_leftTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"yun_income_tabcell"];
    }
    
    if (self.Yun_order_TabArr.count>indexPath.row) {
        
        kezhuofenquModel *model = self.Yun_order_TabArr[indexPath.row];
        cell.name.text = model.name;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 1*newKhight;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *headerVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width, 1*newKhight)];
    headerVC.backgroundColor = kblackColor;
    return headerVC;
    
}
//cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [PronetwayYunFoodHandle shareHandle].Incometableindex = indexPath;
    
    kezhuofenquModel *model = self.Yun_order_TabArr[indexPath.row];
    
    @try {
        self.collectArr = _mutilDic[model.sid];
        
    } @catch (NSException *exception) {
        
        
    } @finally {
        
    }
    [_incomeMoneyVC.Yun_order_collect reloadData];
    
}
/**
 * 代理方法
 */
//定义展示的Section的个数  ---  分区
-( NSInteger )numberOfSectionsInCollectionView:( UICollectionView *)collectionView
{
    if (collectionView == _searchCollect) {
        
        return _PaisearchArr.count;
    }
    return 1 ;
}
//定义展示的UICollectionViewCell的个数
-( NSInteger )collectionView:( UICollectionView *)collectionView numberOfItemsInSection:( NSInteger )section
{
    if (collectionView == _searchCollect) {
        
        return [_PaisearchArr[section] count];
    }
    return _collectArr.count;
}
/**
 *  展示cell
 */
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    Yun_order_deskCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier :@"Yun_income_colleect" forIndexPath :indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 2;
    
    if (collectionView == _searchCollect) {//搜索框
        
        cell.incomeSearchModel = self.PaisearchArr[indexPath.section][indexPath.row];
    }else {
        cell.incomeModel = self.collectArr[indexPath.row];
        
    }
    return cell;
}
//UICollectionView被选中时调用的方法
-(void)collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath
{
    kezhuoModel *model = self.collectArr[indexPath.row];
    if ([model.status isEqualToString:@"0"]) {//已支付   0是未支付
        [WSProgressHUD showImage:nil status:@"空闲客桌"];
        return;
    }
    if ([model.status isEqualToString:@"1"] && [model.paystatus isEqualToString:@"1"]) {
        FishMealViewController *fishVC =[FishMealViewController new];
        fishVC.model = model;
        [self.navigationController pushViewController:fishVC animated:YES];
        return;
    }
    IncomeListViewController *list = [IncomeListViewController new];
    list.model = _collectArr[indexPath.row];
    [self.navigationController pushViewController:list animated:YES];
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath
{
    return CGSizeMake (85*newKwith, 85*newKhight);
}

//定义每个UICollectionView 的边距
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section
{
    return UIEdgeInsetsMake ( 10 , 10 , 10 , 10 );
    
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10*newKwith;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.1*newKhight;
}
//返回headerView和footview
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _searchCollect) {
        
        NSString *reuseIdentifier;
        if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
            reuseIdentifier = kfooterIdentifier;
        }else{
            reuseIdentifier = kheaderIdentifier;
        }
        
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        view.backgroundColor = kWhiteColor;
        
        for (UIView *view1 in view.subviews) {
            
            [view1 removeFromSuperview];
        }
        collectHeaderView *header  = [[collectHeaderView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        [view addSubview:header];
        NSMutableArray *arr = [NSMutableArray array];
        arr = self.PaisearchArr[indexPath.section];
        if (arr.count!=0) {
            kezhuoModel *model = arr[0];
            header.title.text = [NSString stringWithFormat:@" 分区 : %@",model.zonename];
        }
        return view;
        
    }else {
        
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:kheaderIdentifier   forIndexPath:indexPath];
        
        return view;
        
    }
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (collectionView == _searchCollect) {
        
        CGSize size={kWidth,44*newKhight};
        return size;
        
    }
    CGSize size={0.01,0.01};
    return size;
}

//查询分区
-(void)reloadJosnForfenqu {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kquerykezhuofenqu1,[UserDefaults objectForKeyStr:ksid],kquerykezhuofenqu2,@""];
    DLog(@"查询客桌分区的url %@",url);
    
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            NSArray *arr = dic[@"eimdata"];
            
            [self.Yun_order_TabArr removeAllObjects];
            
            for (NSDictionary *dict in arr) {
                
                kezhuofenquModel *model = [kezhuofenquModel setUpModelWithDictionary:dict];
                [self.Yun_order_TabArr addObject:model];
            }
            if (arr.count!=0) {
                
                [self reloadjosnByzoneid:@""];
            }
            [_incomeMoneyVC.Yun_order_Tab reloadData];
            
            if (arr.count!=0) {
                [_incomeMoneyVC.Yun_order_Tab selectRowAtIndexPath:[NSIndexPath indexPathForRow:[PronetwayYunFoodHandle shareHandle].Incometableindex.row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            }
        }else {
            
            DLog(@"查询客桌分区失败 %@",dic);
        }
        
    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
    }];
}
//根据分区查找数目
-(void)reloadjosnByzoneid:(NSString *)zoneid {
    
    NSString *url;
    //获取所有的
        
    url = [NSString stringWithFormat:@"%@%@%@%@%@%@",kIpandPort,@"/pronline/Msg?FunName@orderEditOdtable",kCXByzoneid2,[UserDefaults objectForKeyStr:ksid],@"&start=0",@"&limit=1000"];
    
    DLog(@"查询客桌的url %@",url);
    
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            NSArray *arr = dic[@"eimdata"];
            //获取所有
                if (arr.count == 0) {
                    [WSProgressHUD showImage:nil status:@"无数据"];
                    return ;
                }
                [self.AlldeskArr removeAllObjects];
                for (NSDictionary *dict in arr) {
                    kezhuoModel *model = [kezhuoModel setUpModelWithDictionary:dict];
                    if ([model.status isEqualToString:@"1"]) {
                        [self.AlldeskArr addObject:model];
                    }
                }
            
            DLog(@"我的天 %ld",self.AlldeskArr.count);
            
            _mutilDic = [PaidateTools paidate:self.AlldeskArr];
            
            
            if ([PronetwayYunFoodHandle shareHandle].Incometableindex == nil) {
                
                if (self.AlldeskArr.count!=0) {
                    
                    kezhuofenquModel *model = self.Yun_order_TabArr[0];
                    _collectArr = _mutilDic[model.sid];
                } else {
                
                    [_collectArr removeAllObjects];
                }
            }else {
            
                if (self.AlldeskArr.count!=0) {
                    
                    kezhuofenquModel *model = self.Yun_order_TabArr[[PronetwayYunFoodHandle shareHandle].Incometableindex.row];
                    _collectArr = _mutilDic[model.sid];
                }else {
                
                    [_collectArr removeAllObjects];
                }
                
            }
        
            //展示蒙板页面
            if (self.AlldeskArr.count>1||self.AlldeskArr.count==1) {
                
                if (_isShow == NO) {
                    if ([UserDefaults objectForKeyStr:kshowSYHome] == nil) {
                        
                       _showmarkTimr  = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(metathDelay) userInfo:nil repeats:NO];
                        _isShow = YES;
                    }
                }
            }

            
            [_incomeMoneyVC.Yun_order_collect reloadData];
            
                DLog(@"alldeskArr -- %ld",self.AlldeskArr.count);
        
        }else {
            
            DLog(@"查询客桌分区失败 %@",dic);
        }
        
    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
    }];
}

#pragma mark ------------------- 搜索 ---------------
//开始编辑
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
    [cancelBtn setTitleColor:ksearchBarCancelTextColor forState:(UIControlStateNormal)];
    cancelBtn.titleLabel.font = kFont(ksearchBarCancelTextFont);
    [_incomeMoneyVC.searchController.view addSubview:self.searchCollect];
    self.tabBarController.tabBar.hidden = YES;
    
    if (self.searchArr.count!=0) {
        [_incomeMoneyVC.searchController.view addSubview:self.headerView];
        [UIView animateWithDuration:0.3 animations:^{
            _searchCollect.frame = CGRectMake(0 , kNavBarHAndStaBarH+44, kWidth, kHeight-kNavBarHAndStaBarH-44);
        }];
    }
}

//搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    if (_searchArr.count == 0) {
        [WSProgressHUD showImage:nil status:@"无匹配项"];
    }
    [searchBar resignFirstResponder]; //searchBar失去焦点
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
    cancelBtn.enabled = YES; //把enabled设置为yes
    
}
//取消
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self Tabviewdissmiss];
}
//搜索collectview
-(UICollectionView *)searchCollect {
    
    if (!_searchCollect) {
        
        //先实例化一个层
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //创建collectionview
        _searchCollect = [[UICollectionView alloc]initWithFrame:CGRectMake(0 , kNavBarHAndStaBarH, kWidth, kHeight-kNavBarHAndStaBarH) collectionViewLayout:layout];
        //注册cell
        [_searchCollect registerClass:[Yun_order_deskCollectionViewCell class] forCellWithReuseIdentifier:@"Yun_income_colleect"];
        _searchCollect.delegate = self;
        _searchCollect.dataSource = self;
        //注册头视图
        [self.searchCollect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
        _searchCollect.backgroundColor = kWhiteColor;
    }
    
    return _searchCollect;
}
-(void)Tabviewdissmiss {
    
    [_incomeMoneyVC.searchview.searchbar resignFirstResponder];
    _incomeMoneyVC.searchview.searchbar.showsCancelButton = NO;
    self.tabBarController.tabBar.hidden = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        _searchCollect.alpha = 0;
        _headerView.alpha = 0;
        ///_orderVC.whbgView.alpha = 0;
        
    } completion:^(BOOL finished) {
        _searchCollect = nil;
        _headerView = nil;
        [_headerView removeFromSuperview];
        [_searchCollect removeFromSuperview];
        // [_orderVC.whbgView removeFromSuperview];
    }];
}
//模糊查询
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.searchArr removeAllObjects];
    [self.PaisearchArr removeAllObjects];
    for (int i = 0; i < self.AlldeskArr.count; i++) {
        kezhuoModel *model = self.AlldeskArr[i];
        NSString *string =model.numid ;
        NSString *name = model.zonename;
        if (string.length >= searchText.length) {
            if([string rangeOfString:searchText].location !=NSNotFound)
            {
                [self.searchArr addObject:model];
            }else if ([name rangeOfString:searchText].location !=NSNotFound){
                [self.searchArr addObject:model];
            }
        }
    }
    _hostNameLab.text = @"🔍结果";
    DLog(@"搜索结果 search -- %ld",self.searchArr.count);
    
    //if (self.searchArr.count!=0) {
    
    [self pai:self.searchArr];
    // }
    //[self.searchCollect reloadData];
}

-(UIView *)headerView {
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHAndStaBarH, kWidth, 44*newKhight)];
        _hostNameLab  = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kWidth, 44*newKhight)];
        _hostNameLab.textColor = rgba(85, 85, 85, 1);
        _hostNameLab.font = kFont(13);
        _hostNameLab.text = @"历史结果";
        _headerView.backgroundColor = kWhiteColor;
        [_headerView addSubview:_hostNameLab];
        
        UIView *lin =[[UIView alloc]initWithFrame:CGRectMake(10, 43*newKhight, kWidth, 1)];
        lin.backgroundColor = kCbgColor;
        [_headerView addSubview:lin];
    }
    return _headerView;
}

//排序根据sid 放到相同种类的
-(void)pai:(NSMutableArray*)Arr {
    
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    NSArray *array1 =  Arr;
    NSMutableArray *array = [NSMutableArray arrayWithArray:array1];
    
    for (int i = 0; i < array.count; i ++) {
        kezhuoModel *imodel = array[i];
        NSString *string = imodel.zoneid;
        NSMutableArray *tempArray = [@[] mutableCopy];
        [tempArray addObject:imodel];
        for (int j = i+1; j < array.count; j ++) {
            kezhuoModel *jmodel = array[j];
            NSString *jstring = jmodel.zoneid;
            DLog(@"jstring:%@",jstring);
            if([string isEqualToString:jstring]){
                DLog(@"jvalue = kvalue");
                [tempArray addObject:jmodel];
                [array removeObjectAtIndex:j];
                j=j-1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
    // self.foodData = dateMutablearray;
    DLog(@"dateMutablearray %@",dateMutablearray);
    
    self .PaisearchArr = dateMutablearray;
    [self.searchCollect reloadData];
    
}
//输入框上移 类似于微信的效果


//蒙板效果
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
    [PronetwayYunFoodHandle shareHandle].caiPinRight = @"right";
    _markView.showRect = CGRectMake(90*newKwith, kNavBarHAndStaBarH+60*newKhight, 85*newKwith, 85*newKhight);
    _markView.markText = @"黄色表示正在用餐\n红色表示已经支付!";
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    
    [_markView addSubview:self.okimg];
    
    WeakType(self);
    self.okimg.Click = ^{
        
        [UIView animateWithDuration:0.3 animations:^{
            [UserDefaults setObjectleForStr:@"YES" key:kshowSYHome];
            weakself.markView.alpha = 0;
        } completion:^(BOOL finished) {
            [PronetwayYunFoodHandle shareHandle].caiPinRight = @"";
            [weakself.markView removeFromSuperview];
        }];
        
    };
    
    [window addSubview:weakself.markView];
}

-(void)metathDelay {

    [self showMarkView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
