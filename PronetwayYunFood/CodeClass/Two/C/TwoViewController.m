//
//  TwoViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/10.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "TwoViewController.h"
#import "YunOrderView.h"
#import "Yun_order_DCViewController.h"
#import "DCSearchTableViewCell.h"
#import "searchModel.h"
#import "FishMealViewController.h"
#define kheaderIdentifier @"headerIdentifier"
#define kfooterIdentifier @"footerIdentifier"
@interface TwoViewController ()
@property (strong, nonatomic) YunOrderView *orderVC;

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

@property (strong, nonatomic) NSMutableDictionary *mutilDic;
@property (strong, nonatomic) TimeManager *timerManager;

@property (strong, nonatomic) OkimageView *okimg;
@property (strong, nonatomic) GuideView *markView;
@property (assign) int maerkshow;
@property (strong, nonatomic) NSTimer *ShowMarktimr;
//是否展示
@property (assign) BOOL isShow;

@end

@implementation TwoViewController

-(void)viewWillAppear:(BOOL)animated {
    //进入页面就重新请求一次
    //_tableindex = nil;
    [self reloadJosnForfenqu];
    
    [self.timerManager pq_open];
}

-(void)viewDidDisappear:(BOOL)animated {

    [self.timerManager pq_close];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"点餐"];
    
    
    self.timerManager = [TimeManager pq_createTimerWithType:PQ_TIMERTYPE_CREATE_OPEN updateInterval:5 repeatInterval:1 update:^{
        [self reloadJosnForfenqu];
        DLog(@"点餐桌面更新--更新");
    }];
    
    _orderVC = [[YunOrderView alloc]initWithFrame:kBounds];
    _orderVC.Yun_order_Tab.delegate = self;
    _orderVC.Yun_order_Tab.dataSource = self;
    _orderVC.Yun_order_collect.delegate = self;
    _orderVC.Yun_order_collect.dataSource = self;
    _orderVC.searchController.searchBar.delegate = self;
    self.definesPresentationContext=YES;

    [_orderVC.Yun_order_collect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    
    [self.view addSubview:_orderVC];
 
    //接收通知
    [kNotificationCenter addObserver:self selector:@selector(reloadJosnForstatus) name:@"reloadForxiadanstatus" object:nil];
    
}

#pragma 实现通知方法
-(void)reloadJosnForstatus {

    [self reloadJosnForfenqu];
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
    
        Yun_leftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yun_order_tabcell"forIndexPath:indexPath];
        if (cell == nil) {
            
            cell = [[Yun_leftTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"yun_order_tabcell"];
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
    
    [PronetwayYunFoodHandle shareHandle].tableindex = indexPath;
    
    kezhuofenquModel *model = self.Yun_order_TabArr[indexPath.row];
    
    @try {
        self.collectArr = _mutilDic[model.sid];
        
    } @catch (NSException *exception) {
        
        
    } @finally {
        
    }
    [_orderVC.Yun_order_collect reloadData];
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
    
    Yun_order_deskCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier :@"Yun_order_colleect" forIndexPath :indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 2;
    
    if (collectionView == _searchCollect) {//搜索框
        
        cell.dcsearchModel = self.PaisearchArr[indexPath.section][indexPath.row];
    }else {
    cell.model = self.collectArr[indexPath.row];

    }
    return cell;
}
//UICollectionView被选中时调用的方法
-(void)collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath
{
    
    if (collectionView == _searchCollect) {
        Yun_order_DCViewController *yunDCVC = [Yun_order_DCViewController new];
        yunDCVC.model = self.searchArr[indexPath.row];
        [self.navigationController pushViewController:yunDCVC animated:YES];
        
    }else {
        kezhuoModel *model = self.collectArr[indexPath.row];
        
        if ([model.status isEqualToString:@"1"] && [model.paystatus isEqualToString:@"1"]) {
            FishMealViewController *fishVC =[FishMealViewController new];
            fishVC.model = model;
            [self.navigationController pushViewController:fishVC animated:YES];
            return;
        }
        Yun_order_DCViewController *yunDCVC = [Yun_order_DCViewController new];
        yunDCVC.model = model;
        [self.navigationController pushViewController:yunDCVC animated:YES];
    }

}

//collectview代理
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
            
            [_orderVC.Yun_order_Tab reloadData];
            
            if (arr.count!=0) {
                [_orderVC.Yun_order_Tab selectRowAtIndexPath:[NSIndexPath indexPathForRow:[PronetwayYunFoodHandle shareHandle].tableindex.row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
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
    
    url = [NSString stringWithFormat:@"%@%@%@%@",kIpandPort,@"/pronline/Msg?FunName@orderEditOdtable",kCXByzoneid2,[UserDefaults objectForKeyStr:ksid]];
        
       DLog(@"查询所有 客桌的url %@",url);
    
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            NSArray *arr = dic[@"eimdata"];
            
            
                if (arr.count == 0) {
                    [WSProgressHUD showImage:nil status:@"无数据"];
                    return ;
                }
                [self.AlldeskArr removeAllObjects];
                for (NSDictionary *dict in arr) {
                kezhuoModel *model = [kezhuoModel setUpModelWithDictionary:dict];
                [self.AlldeskArr addObject:model];
                    
                }
        //    DLog(@"alldeskArr -- %ld",self.AlldeskArr.count);
            
            _mutilDic = [PaidateTools paidate:self.AlldeskArr];
            
            if ([PronetwayYunFoodHandle shareHandle].tableindex == nil) {
                if (self.Yun_order_TabArr.count!=0) {
                    
                    kezhuofenquModel *model = self.Yun_order_TabArr[0];
                    _collectArr = _mutilDic[model.sid];
                }
            }else {
                if (self.Yun_order_TabArr.count!=0) {
                    
                    kezhuofenquModel *model = self.Yun_order_TabArr[[PronetwayYunFoodHandle shareHandle].tableindex.row];
                    _collectArr = _mutilDic[model.sid];
                }
                
            }
            
            if (self.AlldeskArr.count>1||self.AlldeskArr.count==1) {
                
                if (_isShow == NO) {
                    if ([UserDefaults objectForKeyStr:kshowDC] == nil) {
                        
                        _ShowMarktimr = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(metathDelay) userInfo:nil repeats:NO];
                        _isShow = YES;
                    }
                }
            }
            
            [_orderVC.Yun_order_collect reloadData];
            
        }else {
            
            DLog(@"查询客桌分区失败 %@",dic);
        }
        
    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
    }];
}

-(void)metathDelay {

    [self showMarkView];
    
}

#pragma mark ------------------- 搜索 ---------------
//开始编辑
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
    
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
    [cancelBtn setTitleColor:ksearchBarCancelTextColor forState:(UIControlStateNormal)];
    cancelBtn.titleLabel.font = kFont(ksearchBarCancelTextFont);
    
    [_orderVC.searchController.view addSubview:self.searchCollect];
    self.tabBarController.tabBar.hidden = YES;
    if (self.searchArr.count!=0) {
        [_orderVC.searchController.view addSubview:self.headerView];
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
        [_searchCollect registerClass:[Yun_order_deskCollectionViewCell class] forCellWithReuseIdentifier:@"Yun_order_colleect"];
        _searchCollect.delegate = self;
        _searchCollect.dataSource = self;
        //注册头视图
        [self.searchCollect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
        _searchCollect.backgroundColor = kWhiteColor;
    }
    
    return _searchCollect;
}
-(void)Tabviewdissmiss {
    
    [_orderVC.searchview.searchbar resignFirstResponder];
    _orderVC.searchview.searchbar.showsCancelButton = NO;
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
  //  DLog(@"dateMutablearray %@",dateMutablearray);
    
    self .PaisearchArr = dateMutablearray;
    [self.searchCollect reloadData];
    
}
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
    _markView.markText = @"黄色表示客桌被占用\n白色表示客桌空闲";
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    
    [_markView addSubview:self.okimg];
    
    WeakType(self);
    self.okimg.Click = ^{
        
        [UIView animateWithDuration:0.3 animations:^{
            [UserDefaults setObjectleForStr:@"YES" key:kshowDC];
            weakself.markView.alpha = 0;
        } completion:^(BOOL finished) {
            [PronetwayYunFoodHandle shareHandle].caiPinRight = @"";
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
