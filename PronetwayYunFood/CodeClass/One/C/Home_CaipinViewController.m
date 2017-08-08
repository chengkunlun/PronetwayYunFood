//
//  Home_CaipinViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/17.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_CaipinViewController.h"
#import "Home_caipinView.h"
#import "Home_AddCaiKindViewController.h"
#import "Home_helpViewController.h"
#import "StyleCaiPinModel.h"
#import "Home_CaiPinModel.h"

//联动 tabview
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import "CategoryModel.h"
#import "NSObject+Property.h"
#import "TableViewHeaderView.h"


@interface Home_CaipinViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,guideDelagate>
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
    NSIndexPath *tableSelection;
}

@property (nonatomic, strong) NSMutableArray *categoryData;
@property (nonatomic, strong) NSMutableArray *foodData;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (strong, nonatomic) UIView *TopView;
@property (strong, nonatomic) UIView *searchBgview;

@property (strong, nonatomic) Home_caipinView *caipinVC;

@property (nonatomic) int tapCount;

@property (strong, nonatomic) NSMutableArray *FoodArr;
@property (strong, nonatomic) NSMutableArray *HeaderArr;
@property (strong, nonatomic)NSMutableArray *searchBarArr;//搜索数组

//搜索框
//searchController

//tableView
@property (nonatomic,strong) UITableView *skTableView;
@property (nonatomic) BOOL backstion;

//搜索历史view
@property (strong, nonatomic) UIView *SearchheaderView;
@property (strong, nonatomic)UILabel *hostNameLab;

@property (nonatomic) BOOL isSelectsort;//是否排序了

@property (strong, nonatomic) OkimageView *okimg;
@property (strong, nonatomic)    GuideView *markView;
@property (assign) int maerkshow;

@property (strong, nonatomic) OkimageView *okimg1;
@property (strong, nonatomic)  GuideView *markView1;
@property (strong, nonatomic) GuideView *caiPstyleMarkview;
@property (strong, nonatomic) GuideView *showcaimark;
@property (strong, nonatomic) GuideView *showmutilstyle;
@property (strong, nonatomic) GuideView *showmutilCaiP;



@property (assign) int maerkshow1;
@property (strong, nonatomic) NSTimer *showMarkTimr;

@property (assign) BOOL isshow;

@end

@implementation Home_CaipinViewController


-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
   // [UserDefaults setObjectleForStr:nil key:kshowCaimutilMode];

    if ([UserDefaults objectForKeyStr:kshowCaiPstyle] == nil) {//展示分类
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self showcaiPstyle];

        });
    }
    if ([UserDefaults objectForKeyStr:kshowCaiPstyle] != nil&&[UserDefaults objectForKeyStr:kshowCai] == nil && [UserDefaults objectForKeyStr:kshowCaimutilStyle] != nil) {//展示菜品
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self showcai];
            
        });
        
    }
    if ([UserDefaults objectForKeyStr:kshowCaiPstyle] != nil&&[UserDefaults objectForKeyStr:kshowCai] == nil && [UserDefaults objectForKeyStr:kshowCaimutilStyle] == nil) {//展示分类引导
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self showmutilStylecai];//
        });
        
    }
    
    if ([UserDefaults objectForKeyStr:kshowCaiPstyle] != nil&&[UserDefaults objectForKeyStr:kshowCai] != nil && [UserDefaults objectForKeyStr:kshowCaimutilStyle] != nil &&[UserDefaults objectForKeyStr:kshowCaimutilMode] == nil) {
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self showmutilCaip];

        });
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self setCustomerTitle:@"菜品管理"];
    
#pragma 长按排序
    [self.leftTableView xy_rollViewOriginalDataBlock:^NSArray *{
        //
        DLog(@"你好~");
        return self.categoryData; // 返回当前的数据给tableView内部处理
        
    } callBlckNewDataBlock:^(NSArray *newData) {
        
        // 回调处理完成的数据给外界
        [self.categoryData removeAllObjects];
        [self.categoryData addObjectsFromArray:newData];
        
        _isSelectsort = YES;//确定已经排序了
        //排序之后确定位置头数组的位置
        [self distinguish:self.categoryData caipin:self.FoodArr];
        
        //右边更新数据 排序之后的数据更新
        [self pai:self.FoodArr];
        
        NSLog(@"--%ld--",self.categoryData.count);
    }];
    _tapCount = 0;//设置第三方变量来确定点是双击还是单击
    
    _caipinVC = [[Home_caipinView alloc]initWithFrame:kBounds];
    _caipinVC.searchController.searchBar.delegate = self;
    self.definesPresentationContext=YES;

    [_caipinVC.CP_cpBtn addTarget:self action:@selector(addCaikind:) forControlEvents:(UIControlEventTouchUpInside)];
    [_caipinVC.CP_FLBtn addTarget:self action:@selector(FlBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:_caipinVC];
    
    //右按钮
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(0, 0, 18*newKwith,18*newKhight);
    [btn setImage:kimage(@"Yun_home_caipin_wenhao") forState:(UIControlStateNormal)];
    UIBarButtonItem *leftBarButtomItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [btn addTarget:self action:@selector(RightBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = leftBarButtomItem;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _selectIndex = 0;
    _isScrollDown = YES;
    
    //解析数据-- 菜品种类
    [self reloadJosnForStyle];

    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    _backstion = YES;
    
   #pragma mark -- 接收通知 --
    [kNotificationCenter addObserver:self selector:@selector(gun) name:@"gunleft" object:nil];
    [kNotificationCenter addObserver:self selector:@selector(addCaipin) name:@"reloadjosnForcaipin" object:nil];
    [kNotificationCenter addObserver:self selector:@selector(addCaipinstylejosn) name:@"reloadJosnForstyleCaipin" object:nil];
    
}
//返回按钮的点击事件
-(void)backAction {

    if (_backstion == YES) {
        
        if (_isSelectsort == YES) {//是否排序
            
            NSMutableArray *plteStrArr = [NSMutableArray arrayWithCapacity:10];
            for (int i = 0; i<self.categoryData.count; i++) {
                
                kezhuofenquModel *model = self.categoryData[i];
                [plteStrArr addObject:model.sid];
            }
            NSString *plateStr = [plteStrArr componentsJoinedByString:@","];
            //排序
            NetworkManger *manger = [NetworkManger new];
            [manger paixuForsort:plateStr] ;
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else {
    
        [self Tabviewdissmiss];
    }
}

#pragma mark --- 实现通知方法 ---
-(void)gun {

    _selectIndex = tableSelection.row;
    if (self.HeaderArr.count>_selectIndex) {
        
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else {
    
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.HeaderArr.count-1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
    _tapCount = 0;
    
}
//添加菜品完成之后刷新
-(void)addCaipin {

    [self reloadJosnforCaipin:@""];
}

-(void)addCaipinstylejosn {

    [self reloadJosnForStyle];
}


-(void)RightBtnClick:(UIButton *)btn {

    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[Home_helpViewController new] animated:YES];
}

//添加菜品
-(void)addCaikind:(UIButton *)btn {

    [self addcaiP];
    //self.hidesBottomBarWhenPushed  = NO;
}

//添加分类
-(void)FlBtnClick:(UIButton *)btn {

    [self addstyle];
}
//添加分类
-(void)addstyle {

    if (kStringIsEmpty([UserDefaults objectForKeyStr:ksid])) {
        
        [WSProgressHUD  showImage:nil status:@"请先新增店铺"];
        
        return;
    }
    Home_CP_FLViewController *flVC =  [Home_CP_FLViewController new];
    flVC.selectstr = @"添加分类";
    [self .navigationController pushViewController:flVC animated:YES];
    

}
//添加菜品
-(void)addcaiP {
    if (kStringIsEmpty([UserDefaults objectForKeyStr:ksid])) {
        
        [WSProgressHUD  showImage:nil status:@"请先新增店铺"];
        return;
    }
    if (self.categoryData.count == 0) {
        
        [WSProgressHUD  showImage:nil status:@"请先添加分类"];
        return;
    }
    self.hidesBottomBarWhenPushed = YES;
    Home_AddCaiKindViewController *addcaiVC = [Home_AddCaiKindViewController new];
    addcaiVC.caipinArr = self.categoryData;
    addcaiVC.styleModel = self.categoryData[tableSelection.row];
    // addcaiVC.selectStr = @"";
    [self.navigationController pushViewController:addcaiVC animated:YES];
}

#pragma mark - Getters
- (NSMutableArray *)categoryData
{
    if (!_categoryData)
    {
        _categoryData = [NSMutableArray array];
    }
    return _categoryData;
}

- (NSMutableArray *)foodData
{
    if (!_foodData)
    {
        _foodData = [NSMutableArray array];
    }
    return _foodData;
}

- (NSMutableArray *)FoodArr
{
    if (!_FoodArr)
    {
        _FoodArr = [NSMutableArray array];
    }
    return _FoodArr;
}
- (NSMutableArray *)HeaderArr
{
    if (!_HeaderArr)
    {
        _HeaderArr = [NSMutableArray array];
    }
    return _HeaderArr;
}
- (NSMutableArray *)searchBarArr
{
    if (!_searchBarArr)
    {
        _searchBarArr = [NSMutableArray array];
    }
    return _searchBarArr;
}


- (UITableView *)leftTableView
{
    if (!_leftTableView)
    {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 124*newKhight, 80*newKwith, kHeight-kTabBarH-kNavBarHAndStaBarH+6*newKhight-80*newKhight)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 55*newKhight;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView
{
    if (!_rightTableView)
    {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(80*newKwith, 124*newKhight, kWidth - 80*newKwith, kHeight -kTabBarH-kNavBarHAndStaBarH+6*newKhight-80*newKhight)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 80*newKhight;
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView registerClass:[RightTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Right];
       // _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _rightTableView;
}

#pragma mark - TableView DataSource Delegate
//分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_leftTableView == tableView)
    {
        return 1;
    }else if (_skTableView == tableView) {
    
        return 1;
    }
    else
    {
        return self.categoryData.count;
    }
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_leftTableView == tableView)
    {
        return self.categoryData.count;
    }else if (_skTableView == tableView) {
        
        return _searchBarArr.count;
    }
    else
    {
        if (self.foodData.count>section) {
            
        return [self.foodData[section] count];

        }else {
        
            return 0;
        }
        
        return 0;
    }
}
//展示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
        
        StyleCaiPinModel *model = self.categoryData[indexPath.row];
        cell.name.text = model.name;
        
        return cell;
    }
    else if (_skTableView == tableView) {
        
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Right forIndexPath:indexPath];
        Home_CaiPinModel *model = self.searchBarArr[indexPath.row];
        cell.caiPmodel = model;
        return cell;    }
    else
    {
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Right forIndexPath:indexPath];
        Home_CaiPinModel *model = self.foodData[indexPath.section][indexPath.row];
        cell.caiPmodel = model;
        return cell;
    }
}
//返回头视图行高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView)
    {
        return 20*newKhight;
    }
    return 0;
}
//返回行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_leftTableView == tableView) {
        
        return 55*newKhight;
    }
    return 88*newKhight;
}
//--- 返回表头 ---
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView)
    {
        TableViewHeaderView *view = [[TableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 20*newKhight)];
        if (self.HeaderArr.count>section) {
            Home_CaiPinModel *model = [self.foodData[section]lastObject];
            view.name.text = model.headerName;
        }
        return view;
    }
    return nil;
}
// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView) && !_isScrollDown && _rightTableView.dragging)
    {
        [self selectRowAtIndexPath:section];
    }
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView) && _isScrollDown && _rightTableView.dragging)
    {
        [self selectRowAtIndexPath:section + 1];
    }
}
//tabview的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (_leftTableView == tableView){
        tableSelection = indexPath;
        _tapCount++;
        switch (_tapCount)
        {
            case 1: //single tap
                [self performSelector:@selector(singleTap) withObject: nil afterDelay:.4];
                break;
            case 2: //double tap
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTap) object:nil];
                [self performSelector:@selector(doubleTap) withObject: nil];
                break;
            default:
                break;
        }
        
    }else if (_skTableView == tableView) {
    
        self.hidesBottomBarWhenPushed = YES;
        Home_AddCaiKindViewController *change = [Home_AddCaiKindViewController new];
        change.selectStr = @"菜品修改";
        if (self.searchBarArr.count>indexPath.row) {
            change.caiModel = self.searchBarArr[indexPath.row];
        }
        change.caipinArr = self.categoryData;
        [self.navigationController pushViewController:change animated:YES];
        //隐藏搜索的tabview
       // [self Tabviewdissmiss];
    }
    else{
        
        self.hidesBottomBarWhenPushed = YES;
        Home_AddCaiKindViewController *change = [Home_AddCaiKindViewController new];
        change.selectStr = @"菜品修改";
        change.caiModel = self.foodData[indexPath.section][indexPath.row];
        change.caipinArr = self.categoryData;
        [self.navigationController pushViewController:change animated:YES];
        
        NSLog(@"你点了右边第 %ld ",indexPath.row);
    }
}
#pragma mark -------- 当拖动右边TableView的时候，处理左边TableView --------

// 当拖动右边TableView的时候，处理左边TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UISrcollViewDelegate
// 标记一下RightTableView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;
    
    UITableView *tableView = (UITableView *) scrollView;
    if (_rightTableView == tableView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

//侧滑删除选中左边,右边跟着滚动
-(void)delectSelectAndScroll:(NSIndexPath *)index {

    StyleCaiPinModel *model = self.categoryData[index.row];
    
    [self.HeaderArr enumerateObjectsUsingBlock:^(StyleCaiPinModel *headerModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([headerModel.sid isEqualToString:model.sid]) {
            
            [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:[headerModel.headerLocation integerValue] ] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            *stop = YES;
        }
    }];
    _tapCount = 0;

}

//单击事件 -- 右边跟着滚动
- (void)singleTap
{
    _selectIndex = tableSelection.row;
    
           //找到这个在左边是否有对应的,有的话
        StyleCaiPinModel *model = self.categoryData[tableSelection.row];
        [self.HeaderArr enumerateObjectsUsingBlock:^(StyleCaiPinModel *headerModel, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([headerModel.sid isEqualToString:model.sid]) {
                
                
            //删除  //滚动到删除的最后一个时,没有数据的分区必须删除,不然会cresh
                NSArray *arr = self.foodData[[headerModel.headerLocation integerValue]];
                if (arr.count!=0) {
                [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:[headerModel.headerLocation integerValue] ] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                *stop = YES;
                }
            }
        }];
    
    _tapCount = 0;
}

- (void)doubleTap
{
    _tapCount = 0;
      Home_CP_FLViewController *FLVC = [Home_CP_FLViewController new];
    
    StyleCaiPinModel *model = self.categoryData[tableSelection.row];
    FLVC.styModel = model;
    [self.navigationController pushViewController:FLVC animated:YES];
    
    
    DLog(@"%ld - %ld",tableSelection.section,tableSelection.row);
}

#pragma  mark -------------------- 按钮的左滑事件 ---------------------
//设置可删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    //if (_leftTableView == tableView) {
        return YES;
    //}
    //return NO;
}

//滑动删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return UITableViewCellEditingStyleDelete;

}

//滑动删除begin预处理
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView == _leftTableView) {
        DLog(@"你侧滑了第 -- %ld  个",indexPath.row);
        [self delectSelectAndScroll:indexPath];
    }
    DLog(@"滑动删除开始");
}

//滑动删除结束处理
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath*)indexPath
{
        DLog(@"滑动删除结束");
    
    if (tableView == _leftTableView) {
        
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section] animated:YES scrollPosition:UITableViewScrollPositionNone];
        
    }
}

//修改左滑的按钮的字
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    return @"删除";
}

#pragma mark ---- 删除菜品分类 ----
//左滑点击事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_leftTableView == tableView) {//左边的tabview ---- 种类
        if (editingStyle == UITableViewCellEditingStyleDelete) { //删除事件
            StyleCaiPinModel *model = self.categoryData[indexPath.row];
            Alert *alert = [Alert new];
            [alert alert:[NSString stringWithFormat:@"是否确认删除 :%@",model.name]];
            alert.alert.OKBlock = ^{
                
            [self.categoryData removeObjectAtIndex:indexPath.row];//tableview数据源

               // [self deletestyle:model.sid];
                
                NetworkManger *manger = [NetworkManger new];
                [manger deleteCaiStyle:model.sid];
                
            manger.Addkezuofenqusuccessblock = ^{//成功
                
                if (![self.categoryData count]) { //删除此行后数据源为空
                    [self.leftTableView deleteSections: [NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationBottom];
                } else {
                    [self.leftTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                }
            };
        };
            alert.alert.CancelBlock = ^{
                
        NSIndexPath *indexPatht=[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        [_leftTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPatht,nil] withRowAnimation:UITableViewRowAnimationRight];
                
        [_leftTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:(UITableViewScrollPositionNone)];
                DLog(@"你点了取消");
            };
            
      }
    }else {//右边的tabview --- 菜品
    
        if (editingStyle == UITableViewCellEditingStyleDelete) {//删除事件
            Alert *alert = [Alert new];
            
            NSMutableArray *arr = [NSMutableArray array];
            arr = self.foodData[indexPath.section];
            Home_CaiPinModel *model = arr[indexPath.row];
            
            [alert alert:[NSString stringWithFormat:@"是否确认删除 :%@?",model.name]];
            alert.alert.OKBlock = ^{
                
                //删除数据请求
                NetworkManger *manger = [NetworkManger new];
                [manger delet:model.sid];
                manger.Addkezuofenqusuccessblock = ^{
                    [WSProgressHUD showImage:nil status:@"删除成功"];
                    
                    [arr removeObjectAtIndex:indexPath.row];//tableview数据源
                    if (![self.foodData count]) { //删除此行后数据源为空
                        [self.leftTableView deleteSections: [NSIndexSet indexSetWithIndex: indexPath.section] withRowAnimation:UITableViewRowAnimationBottom];
                    } else {
                        [self.rightTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    }
                    //滑动删除右边,当数据为最后一个时,删除成功后,把对应的头视图显示的分区删除
                    
//                    [self.foodData enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL * _Nonnull stop) {
//                        
//                        if (arr.count == 0) {
//                            
//                            [self.foodData removeObjectAtIndex:idx];
//                      //      [self.rightTableView reloadData];
//                            *stop = YES;
//                        }
//                    }];
                };
            };
            
            alert.alert.CancelBlock = ^{
                
                NSIndexPath *indexPatht=[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [_rightTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPatht,nil] withRowAnimation:UITableViewRowAnimationRight];
                
                [_rightTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:(UITableViewScrollPositionNone)];
                DLog(@"你点了取消");
            };
        }
    }
}

//解析数据 -- 获取所有种类
-(void)reloadJosnForStyle {
    [WSProgressHUD showWithStatus:@"正在获取菜品.."];

    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",kIpandPort,kInquireStyle1,[UserDefaults objectForKeyStr:ksid]];
    DLog(@"查询菜品种类的 -- %@",urlStr);
    [CKLRequestManger GET:urlStr parameters:nil success:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD dismiss];
            NSArray *arr = dic[@"eimdata"];
            [self.categoryData removeAllObjects];
            
        for (NSDictionary *dict in arr) {
        StyleCaiPinModel *model = [StyleCaiPinModel setUpModelWithDictionary:dict];
        [self.categoryData addObject:model];
               
            }
            if (self.categoryData.count!=0) {
                
                //刷新数据
                [self.leftTableView reloadData];
                
                if (tableSelection!=nil) {
                [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:tableSelection.row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
                }else {
                    
                    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
                }
            }
            //获取右边数据
            [self reloadJosnforCaipin:@""];
        }else {
        
            [WSProgressHUD showImage:nil status:@"请添加菜品"];
            [WSProgressHUD dismiss];
        }
        
    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
        [WSProgressHUD showImage:nil status:@"服务器出错"];
    }];
}

-(void)reloadJosnforCaipin:(NSString *)keyword {

    [WSProgressHUD showWithStatus:@"正在获取菜品.."];

    NSString *urlStr;
    if (kStringIsEmpty(keyword)) {
        
         urlStr = [NSString stringWithFormat:@"%@%@%@",kIpandPort,kCXcaipin,[UserDefaults objectForKeyStr:ksid]];
    }else {
    
        urlStr = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kCXcaipin,[UserDefaults objectForKeyStr:ksid],kCXcaipin1,keyword];
    }
    DLog(@"查询菜品的 -- %@",urlStr);
    [CKLRequestManger GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD dismiss];
        NSArray *arr = dic[@"eimdata"];
            
            if (kStringIsEmpty(keyword)) {
                [self.FoodArr removeAllObjects];
                [self.foodData removeAllObjects];
                for (NSDictionary *dict in arr) {
             Home_CaiPinModel *model = [Home_CaiPinModel setUpModelWithDictionary:dict];
             [self.FoodArr addObject:model];
                    
                }
                // 找到对应的头
                [self distinguish:self.categoryData caipin:self.FoodArr];
                
                //赋值处理-- 添加菜品model对应的表头
                [self AddpropertyCagateArr:self.categoryData foodArr:self.FoodArr];
                //排序
                [self pai:self.FoodArr];
                //展示把表头区分开
                [WSProgressHUD dismiss];
                
            }else { //模糊搜索
                [WSProgressHUD dismiss];

                [self.searchBarArr removeAllObjects];
                for (NSDictionary *dict in arr) {
                    Home_CaiPinModel *model = [Home_CaiPinModel setUpModelWithDictionary:dict];
                    [self.searchBarArr addObject:model];
                }
                [self.skTableView reloadData];
            }
        }else {
        
            [WSProgressHUD dismiss];
        }
    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
        [WSProgressHUD showImage:nil status:@"服务器出错"];
        
    }];
}

//右边头排序处理 处理数据
-(void)distinguish:(NSMutableArray *)cagateArr caipin:(NSMutableArray *)caipinArr {

    [self.HeaderArr removeAllObjects];
    
    NSInteger i =  0;
    for (StyleCaiPinModel *stylemodel in cagateArr) {
        
        for (Home_CaiPinModel *caimodel in caipinArr) {
            
            if ([stylemodel.sid isEqualToString:caimodel.classifyid]) {
                
                stylemodel.headerLocation = [NSString stringWithFormat:@"%ld",i++];
                [self.HeaderArr addObject:stylemodel];
                break;
            }
        }
    }
    DLog(@"头数组的个数--> %ld",self.HeaderArr.count);
}

-(void)AddpropertyCagateArr:(NSMutableArray *)CagateArr foodArr:(NSMutableArray *)foodArr {

    [CagateArr enumerateObjectsUsingBlock:^(StyleCaiPinModel *styModel, NSUInteger idex, BOOL * _Nonnull stop) {
        
        [foodArr enumerateObjectsUsingBlock:^(Home_CaiPinModel *caiModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([caiModel.classifyid isEqualToString:styModel.sid]) {
                
                caiModel.headerName = styModel.name;
                [foodArr replaceObjectAtIndex:idx withObject:caiModel];
            }
        }];
    }];

   //Home_CaiPinModel *model = foodArr[0];
   //DLog(@"%@",model.headerName);
}
//处理数据
-(void)pai:(NSMutableArray *)foodArr {
    
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    NSArray *array1 =  self.FoodArr;
    NSMutableArray *array = [NSMutableArray arrayWithArray:array1];
    
    for (int i = 0; i < array.count; i ++) {
        Home_CaiPinModel *imodel = array[i];
        NSString *string = imodel.classifyid;
        NSMutableArray *tempArray = [@[] mutableCopy];
        [tempArray addObject:imodel];
        for (int j = i+1; j < array.count; j ++) {
            Home_CaiPinModel *jmodel = array[j];
            NSString *jstring = jmodel.classifyid;
           // DLog(@"jstring:%@",jstring);
            if([string isEqualToString:jstring]){
              //  DLog(@"jvalue = kvalue");
               // @autoreleasepool {
                    [tempArray addObject:jmodel];
                    [array removeObjectAtIndex:j];
               // }
                j=j-1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
   // self.foodData = dateMutablearray;
    DLog(@"dateMutablearray %@",dateMutablearray);
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dateMutablearray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL * _Nonnull stop) {
        Home_CaiPinModel *model = arr[0];
        NSString *key = model.classifyid;
        [dict setObject:arr forKey:key];
    }];
    
    NSLog(@"Finadict %@",dict);
    
    NSMutableArray *temp = [NSMutableArray array];
    NSMutableArray *finArr = [NSMutableArray array];
    for (int i = 0; i<self.categoryData.count; i++) {
        StyleCaiPinModel *model = self.categoryData[i];
        NSString *str = model.sid;
        
        @try {
            temp = dict[str];
            [finArr addObject:temp];
            
        } @catch (NSException *exception) {
            DLog(@"--");
        } @finally {
            
        }
    }
    
    NSLog(@"finar %@",finArr);
    
    self.foodData = finArr;
    
    [self.rightTableView reloadData];
    
    
}


-(void)dealloc {

    [_showMarkTimr invalidate];
    _showMarkTimr = nil;
    [kNotificationCenter removeObserver:self];
    
}

#pragma  mark --- seachbardelegate ---- 
//开始编辑
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    //修改取消按钮的颜色
    [searchBar setShowsCancelButton:YES animated:YES];
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
    [cancelBtn setTitleColor:ksearchBarCancelTextColor forState:(UIControlStateNormal)];
    cancelBtn.titleLabel.font = kFont(ksearchBarCancelTextFont);
    
    [_caipinVC.searchController.view addSubview:self.skTableView];
    if (self.searchBarArr.count>0) {
        
        self.skTableView.tableHeaderView = self.SearchheaderView;
        _hostNameLab.text = @"历史结果";
    }
}
//点击搜索是 触发事件
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _hostNameLab.text = @"🔍结果";
    if (self.searchBarArr.count==0) {
        
        [WSProgressHUD showImage:nil status:@"无匹配项"];
    }
    [searchBar resignFirstResponder]; //searchBar失去焦点
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
    cancelBtn.enabled = YES; //把enabled设置为yes
    
}
//取消按钮的点击事件
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {

    [self Tabviewdissmiss];
}
//模糊查询
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.searchBarArr removeAllObjects];
    for (int i = 0; i < self.FoodArr.count; i++) {
        Home_CaiPinModel *model = self.FoodArr[i];
        NSString *string =model.name ;
        if (string.length >= searchText.length) {
            
            if([string rangeOfString:searchText].location !=NSNotFound)
            {
                [_searchBarArr addObject:model];
            }
        }
    }
    _hostNameLab.text = @"🔍结果";
   // [searchBar resignFirstResponder];
    [self.skTableView reloadData];
}
-(UITableView*)skTableView {

    if (!_skTableView) {
        _skTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHAndStaBarH, kWidth, kHeight-kNavBarHAndStaBarH) style:(UITableViewStylePlain)];
        
        _skTableView.delegate = self;
        _skTableView.dataSource = self;
        _skTableView.rowHeight = 80*newKhight;
        _skTableView.showsVerticalScrollIndicator = NO;
        [_skTableView registerClass:[RightTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Right];
        _skTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _backstion = NO;
    }
    return _skTableView;
}

-(void)Tabviewdissmiss {

    [_caipinVC.searchVC.searchbar resignFirstResponder];
    _caipinVC.searchVC.searchbar.showsCancelButton = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _skTableView.alpha = 0;
        
    } completion:^(BOOL finished) {
        _backstion = YES;
        _skTableView = nil;
        [_skTableView removeFromSuperview];
    }];
}
-(UIView *)SearchheaderView {
    
    if (!_SearchheaderView) {
        
        _SearchheaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        _hostNameLab  = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kWidth, 44*newKhight)];
        _hostNameLab.textColor = rgba(85, 85, 85, 1);
        _hostNameLab.font = kFont(13);
        _hostNameLab.text = @"历史结果";
        [_SearchheaderView addSubview:_hostNameLab];
        
        UIView *lin =[[UIView alloc]initWithFrame:CGRectMake(10, 43*newKhight, kWidth, 1)];
        lin.backgroundColor = kCbgColor;
        [_SearchheaderView addSubview:lin];
        
    }
    return _SearchheaderView;
}

//点击空白处收回键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}


#pragma mark -- 蒙板引导 --
-(OkimageView *)okimg {
    
    
    if (!_okimg) {
        _okimg = [[OkimageView alloc]initWithFrame:CGRectMake((kWidth-140*newKwith)/2, kHeight-118*newKhight-70*newKhight, 140*newKwith, 118*newKhight)];
    }
    return _okimg;
}

-(OkimageView *)okimg1 {
    
    if (!_okimg1) {
        _okimg1 = [[OkimageView alloc]initWithFrame:CGRectMake((kWidth-140*newKwith)/2, kHeight-118*newKhight-70*newKhight, 140*newKwith, 118*newKhight)];
    }
    return _okimg1;
}


-(void)showcaiPstyle {

    _caiPstyleMarkview = [[GuideView alloc]initWithFrame:kBounds];
    _caiPstyleMarkview.fullShow = YES;
    _caiPstyleMarkview.model = GuideViewCleanModeRoundRect;
    _caiPstyleMarkview.showRect = CGRectMake(5, kNavBarHAndStaBarH+kStatusBarH+40*newKhight, 70*newKwith, 50*newKhight);
    _caiPstyleMarkview.delegate = self;
    _caiPstyleMarkview.markText = @"请先添加菜品分类";
    [[UIApplication sharedApplication].keyWindow addSubview:_caiPstyleMarkview];
    
}

-(void)showcai {

    _showcaimark = [[GuideView alloc]initWithFrame:kBounds];
    _showcaimark.fullShow = YES;
    _showcaimark.model = GuideViewCleanModeRoundRect;
    [PronetwayYunFoodHandle shareHandle].caiPinRight = @"right";
    _showcaimark.showRect = CGRectMake(self.leftTableView.endX+15*newKwith, kNavBarHAndStaBarH+kStatusBarH+40*newKhight,kWidth-110*newKwith, 50*newKhight);
    _showcaimark.markText = @"点击此处添加菜品";
    _showcaimark.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:_showcaimark];
    
}

-(void)showmutilStylecai {//菜品分类指示
    
    _showmutilstyle = [[GuideView alloc]initWithFrame:kBounds];
    _showmutilstyle.fullShow = YES;
    _showmutilstyle.model = GuideViewCleanModeRoundRect;
    _showmutilstyle.showRect = CGRectMake(0, _leftTableView.Y+kNavBarHAndStaBarH, 80*newKwith, 55*newKhight);
    _showmutilstyle.markText = @"1左滑删除该分类\n2双击进入编辑";
    [[UIApplication sharedApplication].keyWindow addSubview:_showmutilstyle];
      [_showmutilstyle addSubview:self.okimg];
    WeakType(self);
    self.okimg.Click = ^{//我知道了点击事件
        [UserDefaults setObjectleForStr:@"YES" key:kshowCaimutilStyle];

        [weakself dismissmutilstyle];
        
        [weakself showcai];
    
    };
    
}

-(void)showmutilCaip {

    _showmutilCaiP = [[GuideView alloc]initWithFrame:kBounds];
    _showmutilCaiP.fullShow = YES;
    _showmutilCaiP.model = GuideViewCleanModeRoundRect;
    [PronetwayYunFoodHandle shareHandle].caiPinRight = @"right";
    _showmutilCaiP.showRect = CGRectMake(self.leftTableView.endX+15*newKwith, self.leftTableView.Y+kNavBarHAndStaBarH+kStatusBarH+5*newKhight,kWidth-100*newKwith, 80*newKhight);
    _showmutilCaiP.markText = @"1左滑删除该分类\n2单击进入编辑";
    [[UIApplication sharedApplication].keyWindow addSubview:_showmutilCaiP];
    [_showmutilCaiP addSubview:self.okimg1];
    WeakType(self);
    self.okimg1.Click = ^{//我知道了点击事件
        [UserDefaults setObjectleForStr:@"YES" key:kshowCaimutilMode];
        [weakself dismissmutilcai];
        
    };
    
}


-(void)dismissstyle {

    [UIView animateWithDuration:0.3 animations:^{
        
        self.caiPstyleMarkview.alpha = 0;
        
    } completion:^(BOOL finished) {
        [PronetwayYunFoodHandle shareHandle].caiPinRight = @"";
        [self.caiPstyleMarkview removeFromSuperview];
    }];
    
}

-(void)dismisscai {

    [UIView animateWithDuration:0.3 animations:^{
        
        self.showcaimark.alpha = 0;
        
    } completion:^(BOOL finished) {
        [PronetwayYunFoodHandle shareHandle].caiPinRight = @"";
        [self.showcaimark removeFromSuperview];
    }];
}

-(void)dismissmutilstyle {

    [UIView animateWithDuration:0.3 animations:^{
        
        self.showmutilstyle.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self.showmutilstyle removeFromSuperview];
        [PronetwayYunFoodHandle shareHandle].caiPinRight = @"";
    }];

    
}

-(void)dismissmutilcai {

    [UIView animateWithDuration:0.3 animations:^{
        [PronetwayYunFoodHandle shareHandle].caiPinRight = @"";
        self.showmutilCaiP.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self.showmutilCaiP removeFromSuperview];
    }];
}
//点击事件
-(void)onprsee:(UITapGestureRecognizer *)tap superselef:(UIView *)superself {

    if (superself == _caiPstyleMarkview) {
        
        CGPoint point = [tap locationInView:self.caiPstyleMarkview];
        
        if (CGRectContainsPoint(self.caiPstyleMarkview.frame, point)) {
            
            [self dismissstyle];
            [self addstyle];
            DLog(@"添加分类");
        }
    }else if (superself == _showcaimark) {
        CGPoint point = [tap locationInView:self.showcaimark];
        if (CGRectContainsPoint(self.showcaimark.frame, point)) {
            [self dismisscai];
            [self addcaiP];
            DLog(@"添加分类");
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
