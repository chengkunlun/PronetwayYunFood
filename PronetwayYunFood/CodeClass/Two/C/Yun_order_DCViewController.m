//
//  Yun_order_DCViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/15.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Yun_order_DCViewController.h"
#import "TableViewHeaderView.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import "NSObject+Property.h"
#import "Yun_order_XDViewController.h"
#import "PurchaseCarAnimationTool.h"
#import "diancanListview.h"
#import "StyleCaiPinModel.h"
#import "Home_CaiPinModel.h"

@interface Yun_order_DCViewController ()<UITableViewDelegate, UITableViewDataSource,listtabviewDelegate,UISearchBarDelegate>
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
    CGFloat h;
}

@property (nonatomic, strong) NSMutableArray *categoryData;
@property (nonatomic, strong) NSMutableArray *foodData;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (strong, nonatomic) UIView *searchBgview;

@property (strong, nonatomic) NSMutableArray *FoodselectArr;
@property (strong, nonatomic) UIView *bootomView;

@property (strong, nonatomic) UIButton *shopBtn;
@property (strong, nonatomic) UILabel *shopAllpricelab;
@property (strong, nonatomic) RedBtn *shopOkBtn;
@property (strong, nonatomic) UILabel *circleLab;

@property (strong, nonatomic) NSMutableArray *numbersArr;

@property (strong, nonatomic) NSIndexPath *Selectindexpath;
@property (strong, nonatomic)diancanListview *alertView;

@property (strong, nonatomic) NSMutableArray *FoodArr;
@property (strong, nonatomic) NSMutableArray *HeaderArr;
@property (strong, nonatomic) NSMutableArray *AllSelectCount;

@property (nonatomic) BOOL isAdd;

@property (strong, nonatomic) Home_CaiPinModel *middleModel;

@property (nonatomic) BOOL isreduce;

@property (strong, nonatomic)  searchBarView *searchView;
//搜索
@property (strong, nonatomic)NSMutableArray *searchBarArr;//搜索数组
@property (strong, nonatomic) NSMutableArray *mutiArr;
//tableView
@property (nonatomic,strong) UITableView *skTableView;
@property (nonatomic) BOOL backstion;

//搜索历史view
@property (strong, nonatomic) UIView *SearchheaderView;
@property (strong, nonatomic)UILabel *hostNameLab;

//下单数组
@property (strong, nonatomic) NSMutableArray *placArr;

@property (strong, nonatomic) OkimageView *okimg;
@property (strong, nonatomic)    GuideView *markView;
@property (assign) int maerkshow;




@end

@implementation Yun_order_DCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
  [self setCustomerTitle:@"点餐"];

   UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   rightBtn.frame = CGRectMake(0, 0, 70*newKwith, 40*newKhight);
    
    [rightBtn setTitle:@"重选桌号" forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGB(70, 176, 225) forState:(UIControlStateNormal)];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(issueBton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnitem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnitem;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _selectIndex = 0;
    _isScrollDown = YES;
    
    //解析数据-- 菜品种类
    [self reloadJosnForStyle];

    //默认是可以展示减按钮
    [PronetwayYunFoodHandle shareHandle].showReduceBtn = YES;
    
    [self.view addSubview:self.searchBgview];
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    [self.view addSubview:self.bootomView];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self showMarkView];
//    });
    
}

-(void)backAction {

    if (_backstion == YES) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self Tabviewdissmiss];
    }
}

-(NSMutableArray *)FoodselectArr {

    if (!_FoodselectArr) {
        _FoodselectArr = [[NSMutableArray alloc]init];
    }
    return _FoodselectArr;
}
-(NSMutableArray *)AllSelectCount {
    
    if (!_AllSelectCount) {
        _AllSelectCount = [[NSMutableArray alloc]init];
    }
    return _AllSelectCount;
    
}
-(NSMutableArray *)numbersArr {
    
    if (!_numbersArr) {
        _numbersArr = [[NSMutableArray alloc]init];
    }
    return _numbersArr;
    
}

- (NSMutableArray *)FoodArr
{
    if (!_FoodArr)
    {
        _FoodArr = [NSMutableArray array];
    }
    return _FoodArr;
}
-(NSMutableArray *)HeaderArr {
    
    if (!_HeaderArr) {
        _HeaderArr = [[NSMutableArray alloc]init];
    }
    return _HeaderArr;
    
}
-(NSMutableArray *)searchBarArr {
    
    if (!_searchBarArr) {
        _searchBarArr = [[NSMutableArray alloc]init];
    }
    return _searchBarArr;
    
}
-(NSMutableArray *)mutiArr {
    
    if (!_mutiArr) {
        _mutiArr = [[NSMutableArray alloc]init];
    }
    return _mutiArr;
    
}

-(NSMutableArray *)placArr {
    
    if (!_placArr) {
        _placArr = [[NSMutableArray alloc]init];
    }
    return _placArr;
    
}


//重选桌号
-(void)issueBton:(UIButton*)btn {

    DLog(@"重选桌号");
    
}

-(UIView *)searchBgview {

    if (!_searchBgview) {
        _searchBgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(5*newKwith, 12*newKhight, 24*newKwith, 24*newKhight)];
        lab.font = kFont(14);
        lab.text = @"🍴";
        [_searchBgview addSubview:lab];
        
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(lab.endX, 12*newKhight, 60*newKwith, 24*newKhight)];
        lab1.font = kFont(14);
        if ([self.selectStr isEqualToString:@"search"]) {
            
            lab1.text = self.searchModel.numid;
        }else {
            lab1.text = [NSString stringWithFormat:@"%@-%@",self.model.zonename,self.model.numid];
        }
        lab1.textColor = RGB(70, 176, 225);
        [_searchBgview addSubview:lab1];
        
        _searchView = [[searchBarView alloc]initWithFrame:CGRectMake(lab1.endX, 0, kWidth-lab1.endX, 44*newKhight) placeholder:@"请输入菜品"];
        _searchView.searchbar.delegate = self;
        _searchView.searchbar.showsCancelButton = NO;
        [_searchBgview addSubview:_searchView];
        
    }
    return _searchBgview;
}
//底部弹出购物车按钮
-(UIView *)bootomView {

    if (!_bootomView) {
        _bootomView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight-kNavBarHAndStaBarH, kWidth, 44*newKhight)];
        _bootomView.backgroundColor = kWhiteColor;
        
        _shopBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _shopBtn.frame = CGRectMake(37*newKwith, 12*newKhight, 26*newKwith, 21*newKhight);
        [_shopBtn setImage:kimage(@"Yun_order_shopBtn") forState:(UIControlStateNormal)];
        [_bootomView addSubview:_shopBtn];
        UIButton *bfBTn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kWidth/2, 44*newKhight)];
        [bfBTn addTarget:self action:@selector(alertList:) forControlEvents:(UIControlEventTouchUpInside)];
        [_bootomView addSubview:bfBTn];
        
        _shopAllpricelab = [[UILabel alloc]initWithFrame:CGRectMake(_shopBtn.endX+25*newKwith, 0, kWidth, 44*newKhight)];
        _shopAllpricelab.textColor = kRedColor;
        _shopAllpricelab.text = @"";
        _shopAllpricelab.font = kFont(14);
        [_bootomView addSubview:_shopAllpricelab];
        
        _shopOkBtn = [[RedBtn alloc]initWithFrame:CGRectMake(kWidth/2, 0, kWidth/2, 44*newKhight) text:@"选好了"];
        [_shopOkBtn addTarget:self action:@selector(shopOkBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_bootomView addSubview:_shopOkBtn];
        
        _circleLab = [[UILabel alloc]initWithFrame:CGRectMake(_shopBtn.endX-5*newKwith, _shopBtn.Y-5*newKhight, 16*newKwith, 16*newKhight)];
        _circleLab.textColor = kWhiteColor;
        _circleLab.backgroundColor = kRedColor;
        _circleLab.textAlignment = NSTextAlignmentCenter;
        _circleLab.font = kFont(12);
        _circleLab.layer.masksToBounds = YES;
        _circleLab.layer.cornerRadius = _circleLab.height/2;
        [_bootomView addSubview:_circleLab];
        
    }
    return _bootomView;
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

- (UITableView *)leftTableView
{
    if (!_leftTableView)
    {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 80, kHeight-kTabBarH-kNavBarHAndStaBarH+6*newKhight)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 55;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
        [_leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView
{
    if (!_rightTableView)
    {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(80*newKwith, 44*newKhight, kWidth - 80*newKwith, kHeight -kTabBarH-kNavBarHAndStaBarH+6*newKhight)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 80*newKhight;
        _rightTableView.showsVerticalScrollIndicator = NO;
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        //[_rightTableView registerClass:[RightTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Right];
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
    }else if (tableView == _skTableView) {
    
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
    }else if (tableView == _skTableView){
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
        
         StyleCaiPinModel*model = self.categoryData[indexPath.row];
        cell.name.text = model.name;
        
        return cell;
    }else if (tableView == _skTableView) {
    
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)indexPath.section, (long)[indexPath row]];//以indexPath来唯一确定cell
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[RightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        Home_CaiPinModel *model = self.searchBarArr[indexPath.row];
        cell.DCcaiPmodel = model;
        
        [cell.addBtn addTarget:self action:@selector(SearchbtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
         [cell.reduceBtn addTarget:self action:@selector(reducebtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
        cell.reduceBtn.tag = kYun_dc_searchtabbtnTag;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)indexPath.section, (long)[indexPath row]];//以indexPath来唯一确定cell
        //重用机制
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[RightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        Home_CaiPinModel *model = self.foodData[indexPath.section][indexPath.row];
        cell.DCcaiPmodel = model;
        
        [cell.addBtn addTarget:self action:@selector(TabbtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
         [cell.reduceBtn addTarget:self action:@selector(reducebtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView)
    {
        return 20*newKhight;
    }
    return 0;
}
#pragma mark -------------- 展示分区 ---------------
//展示分区--表头
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
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
#warning 需要修改的 ,最好拿到左边的点击事件在右边的头数组中的位置
    if (_leftTableView == tableView)
    {
        _selectIndex = indexPath.row;
//        if (_selectIndex<self.HeaderArr.count) {
//            
//        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//            
//        }else {
            //找到这个在左边是否有对应的,有的话
            StyleCaiPinModel *model = self.categoryData[_selectIndex];
            
            [self.HeaderArr enumerateObjectsUsingBlock:^(StyleCaiPinModel *headerModel, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([headerModel.sid isEqualToString:model.sid]) {
                    
                    [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:[headerModel.headerLocation integerValue] ] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                    *stop = YES;
                }
            }];
        }
       
    //}
    else {
        
       // tableView .userInteractionEnabled = NO;
       //NSLog(@"你点了右边第 %ld ",indexPath.row);
    }
}
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

#pragma  mark ------------------购物车 增加减少按钮 ----------------
//弹出页面加按钮点击事件
-(void)onpressaddBtn:(Home_CaiPinModel *)model  selectArr:(NSMutableArray *)selectArr{
//重新赋值
    ///[self.FoodselectArr removeAllObjects];
    //self.FoodselectArr = selectArr;
    //计算钱
    [self computeMoney:selectArr];
    
    NSIndexPath *indexpath = model.selectIndexPath;
    NSMutableArray *date = self.foodData[indexpath.section];
    [date replaceObjectAtIndex:indexpath.row withObject:model];
    [self.rightTableView reloadData];
}
//弹出按钮减少事件
-(void)onpressreduceBtn:(Home_CaiPinModel *)model selectArr:(NSMutableArray *)selectArr{
//重新赋值
   // [self.FoodselectArr removeAllObjects];
   // self.FoodselectArr = selectArr;
//计算钱
    [self computeMoney:selectArr];
    
    NSIndexPath *indexpath = model.selectIndexPath;
    NSMutableArray *date = self.foodData[indexpath.section];
    [date replaceObjectAtIndex:indexpath.row withObject:model];
    [self.rightTableView reloadData];
    
}


//弹出已经选中的listview
-(void)alertList:(UIButton *)btn {

    if (self.FoodselectArr.count ==0) {
        DLog(@"<--没有选择-->");
        return;
    }else {
        
        if (self.FoodselectArr.count<6) {//44*self.FoodselectArr.count-- 超过6个
            h = 44*newKhight*self.FoodselectArr.count;
        }else {//44 *6
            h = 44*7;
        }
       _alertView = [[diancanListview alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kNavBarHAndStaBarH-44*newKhight) height:h+44*newKhight];
        _alertView.alertListArr = self.FoodselectArr;
        _alertView.delegate  =self;
        btn.enabled = NO;
        WeakType(self);
        _alertView.clearBlock = ^{//清空操作
            //重新请求一次数据
            [weakself reloadJosnforCaipinkeword:@""];
            
            [weakself.FoodselectArr removeAllObjects];
            [weakself.AllSelectCount removeAllObjects];
            weakself.circleLab.text = [NSString stringWithFormat:@"%ld",weakself.FoodselectArr.count];
            [PronetwayYunFoodHandle shareHandle].showReduceBtn = NO;
            [weakself.rightTableView reloadData];//刷新--减少按钮不展示..
            weakself.shopAllpricelab.text = @"¥ 0 ";
            
            btn.enabled = YES;
        };
        _alertView.addBlock = ^{//弹出listview加按钮事件
            [weakself.AllSelectCount addObject:@"1"];
             weakself.circleLab.text  = [NSString stringWithFormat:@"%ld",weakself.AllSelectCount.count];
            
        };
        _alertView.reduceBlock = ^{//弹出listview减按钮事件
            
            [weakself.AllSelectCount removeLastObject];
            if (weakself.AllSelectCount.count == 0) {
                
                btn.enabled = YES;
            }
           weakself.circleLab.text  = [NSString stringWithFormat:@"%ld",weakself.AllSelectCount.count];

        };
        _alertView.clickbacgroundBlock = ^{//点击背景图
            
            btn.enabled = YES;
        };
        [self.view addSubview:self.alertView];
        
    }
}

#pragma mark -----搜索框点击事件
//加
- (void)SearchbtnClick:(UIButton *)sender event:(id)event {

    [PronetwayYunFoodHandle shareHandle].showReduceBtn = YES;

    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_skTableView];
    NSIndexPath *indexPath= [_skTableView indexPathForRowAtPoint:currentTouchPosition];
    //加入购物车动画
    RightTableViewCell *cell = [_skTableView cellForRowAtIndexPath:indexPath];
    cell.reduceBtn.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        
    cell.reduceBtn.frame = CGRectMake(kWidth-180*newKwith, 42.5*newKhight, 25*newKwith, 25*newKhight);
        
    } completion:^(BOOL finished) {
        cell.numberLab.hidden = NO;
        //修改数据
        Home_CaiPinModel *model = self.searchBarArr[indexPath.row];
        
        if (self.FoodselectArr.count!=0) {//已经有
            
            for (Home_CaiPinModel *selectmodel in self.FoodselectArr) {//遍历已选择的
                
                if ([model.sid isEqualToString:selectmodel.sid]) {//已选择的和当前点击的相等 已选择的model不添加,更改footdata选择后的model---相同已有
                    _isAdd = NO;
                    self.middleModel = selectmodel;
                    break;
                }else {//遍历完成所有之后再添加..
                    _isAdd = YES;
                }
            }
            if (_isAdd == YES) {//不同
                model.selectnumber++;
               // NSMutableArray *date = self.foodData[indexPath.section];
                //[date replaceObjectAtIndex:indexPath.row withObject:model];
               // model.selectIndexPath = indexPath;
                [self.searchBarArr replaceObjectAtIndex:indexPath.row withObject:model];
                [self.FoodselectArr addObject:model];
            }else {
                _middleModel.selectnumber++;
                //NSMutableArray *date = self.foodData[indexPath.section];
                [self.searchBarArr replaceObjectAtIndex:indexPath.row withObject:_middleModel];
            }
        }else {
            model.selectnumber++;
           // NSMutableArray *date = self.foodData[indexPath.section];
            [self.searchBarArr replaceObjectAtIndex:indexPath.row withObject:model];
           // model.selectIndexPath = indexPath;
            [self.FoodselectArr addObject:model];
            
        }
#pragma mark --- 计算钱 ---
        //计算钱
        [self computeMoney:self.FoodselectArr];
        //全部刷新
        [self.skTableView reloadData];
        
         Home_CaiPinModel *searmodel = self.searchBarArr[indexPath.row];
#pragma mark --- 更改右边数据源 ---
        
        [self.FoodArr enumerateObjectsUsingBlock:^(Home_CaiPinModel *leftmodel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([model.sid isEqualToString:leftmodel.sid]) {
                
                NSIndexPath *index = [NSIndexPath indexPathForRow:leftmodel.row inSection:leftmodel.session];
                searmodel.selectIndexPath = index;
                
                NSMutableArray *date = self.foodData[leftmodel.session];
                [date replaceObjectAtIndex:leftmodel.row withObject:searmodel];
                //[PronetwayYunFoodHandle shareHandle].showReduceBtn = YES;
                //加入购物车动画
                RightTableViewCell *cell = [_rightTableView cellForRowAtIndexPath:leftmodel.indexpah];
                
                cell.reduceBtn.hidden = NO;
                cell.numberLab.hidden = NO;
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                cell.reduceBtn.frame = CGRectMake(kWidth-180*newKwith, 42.5*newKhight, 25*newKwith, 25*newKhight);
                    
                } completion:^(BOOL finished) {
                    
                    
                }];
                
                [self.rightTableView reloadData];

                *stop = YES;
            }
        }];
    }];
    
    if (indexPath!= nil)
    {
        DLog(@"%ld -- %ld",indexPath.section,indexPath.row);
        
        //总数目 --
        [self.AllSelectCount addObject:@"1"];
        if (_FoodselectArr.count==0) {//没有,弹出并添加
            
            [UIView animateWithDuration:0.3 animations:^{
                //弹出
                _bootomView.frame = CGRectMake(0, kHeight-kNavBarHAndStaBarH-44*newKhight, kWidth, 44*newKhight);
                _circleLab.text = @"1";
            } completion:^(BOOL finished) {
                //加入购物车动画
                CGRect rect = [_skTableView rectForRowAtIndexPath:indexPath];
                //获取当前cell 相对于self.view 当前的坐标
                rect.origin.y = rect.origin.y - [_skTableView contentOffset].y;
                CGRect imageViewRect = _skTableView.frame;
                imageViewRect.origin.y = rect.origin.y+imageViewRect.origin.y;
                
                [[PurchaseCarAnimationTool shareTool]startAnimationandView:cell.imageV andRect:imageViewRect andFinisnRect:CGPointMake(37*newKwith, kHeight-kNavBarHAndStaBarH-44) andFinishBlock:^(BOOL finisn){
                    [PurchaseCarAnimationTool shakeAnimation:_shopBtn];
                }];
            }];
        }else {//已经有了,往里面添加
            
            //加入购物车动画
            CGRect rect = [_rightTableView rectForRowAtIndexPath:indexPath];
            //获取当前cell 相对于self.view 当前的坐标
            rect.origin.y = rect.origin.y - [_rightTableView contentOffset].y;
            CGRect imageViewRect = _rightTableView.frame;
            imageViewRect.origin.y = rect.origin.y+imageViewRect.origin.y+20;
            //红圈
            _circleLab.text = [NSString stringWithFormat:@"%ld",self.AllSelectCount.count];
            [[PurchaseCarAnimationTool shareTool]startAnimationandView:cell.imageV andRect:imageViewRect andFinisnRect:CGPointMake(37*newKwith, kHeight-kNavBarHAndStaBarH) andFinishBlock:^(BOOL finisn){
                
                [PurchaseCarAnimationTool shakeAnimation:_shopBtn];
            }];
        }
    }
}

#pragma  mark ------------------右边tabview上按钮的点击事件 ----------------
//右边添加事件事件
- (void)TabbtnClick:(UIButton *)sender event:(id)event
{
    [PronetwayYunFoodHandle shareHandle].showReduceBtn = YES;
    
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_rightTableView];
    NSIndexPath *indexPath= [_rightTableView indexPathForRowAtPoint:currentTouchPosition];
    //加入购物车动画
    RightTableViewCell *cell = [_rightTableView cellForRowAtIndexPath:indexPath];
    
    cell.reduceBtn.hidden = NO;

    [UIView animateWithDuration:0.3 animations:^{
        
    cell.reduceBtn.frame = CGRectMake(kWidth-180*newKwith, 42.5*newKhight, 25*newKwith, 25*newKhight);
        
    } completion:^(BOOL finished) {
        cell.numberLab.hidden = NO;
        //修改数据
        Home_CaiPinModel *model = self.foodData[indexPath.section][indexPath.row];
        
        if (self.FoodselectArr.count!=0) {//已经有
            
            for (Home_CaiPinModel *selectmodel in self.FoodselectArr) {//遍历已选择的

                if ([model.sid isEqualToString:selectmodel.sid]) {//已选择的和当前点击的相等 已选择的model不添加,更改footdata选择后的model---相同已有
                    _isAdd = NO;
                    self.middleModel = selectmodel;
                    break;
                }else {//遍历完成所有之后再添加..
                    _isAdd = YES;
                }
            }
            if (_isAdd == YES) {//不同
                model.selectnumber++;
                NSMutableArray *date = self.foodData[indexPath.section];
                [date replaceObjectAtIndex:indexPath.row withObject:model];
                model.selectIndexPath = indexPath;
                [self.FoodselectArr addObject:model];
            }else {
                _middleModel.selectnumber++;
                NSMutableArray *date = self.foodData[indexPath.section];
                [date replaceObjectAtIndex:indexPath.row withObject:_middleModel];
            }
        }else {
            model.selectnumber++;
            NSMutableArray *date = self.foodData[indexPath.section];
            [date replaceObjectAtIndex:indexPath.row withObject:model];
            model.selectIndexPath = indexPath;
            [self.FoodselectArr addObject:model];
            
        }
#pragma mark --- 计算钱 ---
        //计算钱
        [self computeMoney:self.FoodselectArr];
        

        //全部刷新
        [self.rightTableView reloadData];
        
    }];
    if (indexPath!= nil)
    {
        DLog(@"%ld -- %ld",indexPath.section,indexPath.row);

        //总数目 --
        [self.AllSelectCount addObject:@"1"];
        if (_FoodselectArr.count==0) {//没有,弹出并添加
            
            [UIView animateWithDuration:0.3 animations:^{
                //弹出
            _bootomView.frame = CGRectMake(0, kHeight-kNavBarHAndStaBarH-44*newKhight, kWidth, 44*newKhight);
                 _circleLab.text = @"1";
            } completion:^(BOOL finished) {
                //加入购物车动画
                CGRect rect = [_rightTableView rectForRowAtIndexPath:indexPath];
                //获取当前cell 相对于self.view 当前的坐标
                rect.origin.y = rect.origin.y - [_rightTableView contentOffset].y;
                CGRect imageViewRect = _rightTableView.frame;
                imageViewRect.origin.y = rect.origin.y+imageViewRect.origin.y;
                
                [[PurchaseCarAnimationTool shareTool]startAnimationandView:cell.imageV andRect:imageViewRect andFinisnRect:CGPointMake(37*newKwith, kHeight-kNavBarHAndStaBarH-44) andFinishBlock:^(BOOL finisn){
                    [PurchaseCarAnimationTool shakeAnimation:_shopBtn];
                }];
            }];
        }else {//已经有了,往里面添加
        
            //加入购物车动画
            CGRect rect = [_rightTableView rectForRowAtIndexPath:indexPath];
            //获取当前cell 相对于self.view 当前的坐标
            rect.origin.y = rect.origin.y - [_rightTableView contentOffset].y;
            CGRect imageViewRect = _rightTableView.frame;
            imageViewRect.origin.y = rect.origin.y+imageViewRect.origin.y+20;
            //红圈
            _circleLab.text = [NSString stringWithFormat:@"%ld",self.AllSelectCount.count];
            [[PurchaseCarAnimationTool shareTool]startAnimationandView:cell.imageV andRect:imageViewRect andFinisnRect:CGPointMake(37*newKwith, kHeight-kNavBarHAndStaBarH) andFinishBlock:^(BOOL finisn){
                
                [PurchaseCarAnimationTool shakeAnimation:_shopBtn];
            }];
        }
    }
}

//右边减少事件事件 / ---- /搜索框按钮减少事件
- (void)reducebtnClick:(UIButton *)sender event:(id)event
{
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    
    CGPoint currentTouchPosition;
    NSIndexPath *indexPath;
    RightTableViewCell *cell;

    if (sender.tag == kYun_dc_searchtabbtnTag) {
        currentTouchPosition = [touch locationInView:_skTableView];
        indexPath = [_skTableView indexPathForRowAtPoint:currentTouchPosition];
        cell = [_skTableView cellForRowAtIndexPath:indexPath];
    }else {
     currentTouchPosition = [touch locationInView:_rightTableView];
     indexPath = [_rightTableView indexPathForRowAtPoint:currentTouchPosition];
     cell = [_rightTableView cellForRowAtIndexPath:indexPath];
    }
    
       if (indexPath!= nil)
    {
        //减少
        //修改数据
        Home_CaiPinModel *model ;
        
        if (sender.tag == kYun_dc_searchtabbtnTag) {
            
            model = self.searchBarArr[indexPath.row];
        }else {
        
            model = self.foodData[indexPath.section][indexPath.row];
        }
        
        for (Home_CaiPinModel *selectmodel in self.FoodselectArr) {
            
            if ([model.sid isEqualToString:selectmodel.sid]) {//有 相同
                
                if (selectmodel.selectnumber == 1) {
                    [UIView animateWithDuration:0.5 animations:^{
                        cell.reduceBtn.frame = CGRectMake(kWidth-125*newKwith, 42.5*newKhight, 25*newKwith, 25*newKhight);
                        
                    } completion:^(BOOL finished) {
                        
                        cell.reduceBtn.hidden = YES;
                        cell.numberLab.hidden = YES;
                        
                    }];
                   //删除这个model;
                    [self.FoodselectArr removeObject:selectmodel];
                    selectmodel.selectnumber--;
                    if (sender.tag == kYun_dc_searchtabbtnTag) {//模糊搜索
                        
                        [self.searchBarArr replaceObjectAtIndex:indexPath.section withObject:selectmodel];
                    }else {
                    
                        NSMutableArray *date = self.foodData[indexPath.section];
                        [date replaceObjectAtIndex:indexPath.row withObject:selectmodel];
                    }
                    
                }else {
                
                    model.selectnumber--;
                    if (sender.tag == kYun_dc_searchtabbtnTag) {//模糊搜索
                        [self.searchBarArr replaceObjectAtIndex:indexPath.row withObject:model];
                    }else {
                    
                        NSMutableArray *date = self.foodData[indexPath.section];
                        [date replaceObjectAtIndex:indexPath.row withObject:model];
                    }
                }
                
                break;
            }
        }
        
        //计算钱
        [self computeMoney:self.FoodselectArr];
        
        if (sender.tag == kYun_dc_searchtabbtnTag) {//模糊搜索
            [self.skTableView reloadData];
        }else {
            //全部刷新
            [self.rightTableView reloadData];
        }
#pragma mark --- 更新数据源操作 ---/ 改变右边菜品列表的菜品选中数量 减少/
        
        if (sender.tag == kYun_dc_searchtabbtnTag) {
            Home_CaiPinModel *searmodel = self.searchBarArr[indexPath.row];
            
            [self.FoodArr enumerateObjectsUsingBlock:^(Home_CaiPinModel *leftmodel, NSUInteger idx, BOOL * _Nonnull stop) {
                NSIndexPath *index = [NSIndexPath indexPathForRow:leftmodel.row inSection:leftmodel.session];
                searmodel.selectIndexPath =index;
                NSMutableArray *date = self.foodData[leftmodel.session];
                [date replaceObjectAtIndex:leftmodel.row withObject:searmodel];
                //[PronetwayYunFoodHandle shareHandle].showReduceBtn = YES;
                //加入购物车动画
                [self.rightTableView reloadData];
                *stop = YES;
                
            }];

        }
        
        //对数据源进行操作
        if (self.FoodselectArr.count!=0) {
            
            [self.AllSelectCount removeLastObject];
            
        _circleLab.text = [NSString stringWithFormat:@"%ld",self.AllSelectCount.count];
            
        }else {
            [self.AllSelectCount removeLastObject];
            _circleLab.text = @"0";

        }
    }
}
#pragma mark --- 选好了 ----
-(void)shopOkBtnClick:(RedBtn *)btn{

    if (self.AllSelectCount.count == 0) {
        [WSProgressHUD showImage:nil status:@"请选择菜品"];
        return;
    }
    
    NetworkManger *manger = [NetworkManger new];
    [manger addsFood:@"" tableid:self.model.sid content:[self contentJosn]];
    manger.Addkezuofenqusuccessblock = ^{
        
        Yun_order_XDViewController *xdVC =  [Yun_order_XDViewController new];
        xdVC.selectArr = self.FoodselectArr;
        xdVC.AllPrice = _shopAllpricelab.text;
        xdVC.model = self.model;
        [WSProgressHUD showImage:nil status:@"生成成功"];
        [self.navigationController pushViewController:xdVC animated:YES];
    };
    
   // DLog(@" --- %@",[self contentJosn]);
    
    
}

//解析数据 -- 获取所有种类
-(void)reloadJosnForStyle {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",kIpandPort,kInquireStyle1,[UserDefaults objectForKeyStr:ksid]];
    DLog(@"查询菜品种类的 -- %@",urlStr);
    [CKLRequestManger GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            NSArray *arr = dic[@"eimdata"];
            [self.categoryData removeAllObjects];
            for (NSDictionary *dict in arr) {
                StyleCaiPinModel *model = [StyleCaiPinModel setUpModelWithDictionary:dict];
                [self.categoryData addObject:model];
            }
            
            if (self.categoryData.count!=0) {
                //刷新数据
                [self.leftTableView reloadData];
                
                [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
                
                //获取右边数据
                [self reloadJosnforCaipinkeword:@""];
            }else {
            
                [WSProgressHUD showImage:nil status:@"请至首页添加菜品"];
            }
           
        }else if ([dic[@"result"] isEqualToString:@"8"]) {
        
            [WSProgressHUD showImage:nil status:@"请至首页添加菜品"];

        }else {
            [WSProgressHUD showImage:nil status:@"请求错误"];
            
        }
    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
        [WSProgressHUD showImage:nil status:@"服务器出错"];
    }];
}

-(void)reloadJosnforCaipinkeword:(NSString *)keword{
    
    NSString *urlStr;

    if (kStringIsEmpty(keword)) {
        
        urlStr = [NSString stringWithFormat:@"%@%@%@",kIpandPort,kCXcaipin,[UserDefaults objectForKeyStr:ksid]];
    }else {
        
        urlStr = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kCXcaipin,[UserDefaults objectForKeyStr:ksid],kCXcaipin1,keword];
    }
    
    DLog(@"查询菜品的 -- %@",urlStr);
    [CKLRequestManger GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            NSArray *arr = dic[@"eimdata"];
            if (kStringIsEmpty(keword)) {
                
                if (arr.count == 0) {
                    
                    [WSProgressHUD showImage:nil status:@"请至首页添加菜品"];
                    return ;
                }
                [self.FoodArr removeAllObjects];
                [self.foodData removeAllObjects];
                
                for (NSDictionary *dict in arr) {
                    Home_CaiPinModel *model = [Home_CaiPinModel setUpModelWithDictionary:dict];
                    if (![model.status isEqualToString:@"1"]) {
                        
                        [self.FoodArr addObject:model];
                    }
                }
                //排序  --- 头数组
                [self distinguish:self.categoryData caipin:self.FoodArr];
                //添加属性
                [self AddpropertyCagateArr:self.categoryData foodArr:self.FoodArr];
                // [self paixy:self.FoodArr];
                [self pai];
                //确定下来每个模型所在位置
                [self GiveModelSetidex:self.foodData];
            }
            else { //模糊搜索
                if (arr.count == 0) {
                    [WSProgressHUD showImage:nil status:@"无匹配项"];
                    return ;
                }
                
                [self.searchBarArr removeAllObjects];
                for (NSDictionary *dict in arr) {
                    Home_CaiPinModel *model = [Home_CaiPinModel setUpModelWithDictionary:dict];
                    [self.searchBarArr addObject:model];
                }
                [self.skTableView reloadData];
            }
            
        }
        
    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
        [WSProgressHUD showImage:nil status:@"服务器出错"];
    }];
}
//头数组的添加--
-(void)distinguish:(NSMutableArray *)cagateArr caipin:(NSMutableArray *)caipinArr {
    
    [self.HeaderArr removeAllObjects];
    int i = 0;
    for (StyleCaiPinModel *stylemodel in cagateArr) {
        
        for (Home_CaiPinModel *caimodel in caipinArr) {
            
            if ([stylemodel.sid isEqualToString:caimodel.classifyid]) {
                stylemodel.headerLocation = [NSString stringWithFormat:@"%d",i];
                i++;
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
    
   // Home_CaiPinModel *model = foodArr[0];
   // DLog(@"%@",model.headerName);
}
#pragma  mark -------------对数组进行排序操作 ---------------
-(void)pai {
    
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    NSArray *array1 = self.FoodArr;
    NSMutableArray *array = [NSMutableArray arrayWithArray:array1];
    for (int i = 0; i < array.count; i ++) {
        Home_CaiPinModel *imodel = array[i];
        NSString *string = imodel.classifyid;
        NSMutableArray *tempArray = [@[] mutableCopy];
        [tempArray addObject:imodel];
        for (int j = i+1; j < array.count; j ++) {
            Home_CaiPinModel *jmodel = array[j];
            NSString *jstring = jmodel.classifyid;
            // NSLog(@"jstring:%@",jstring);
            if([string isEqualToString:jstring]){
                // NSLog(@"jvalue = kvalue");
                [tempArray addObject:jmodel];
                [array removeObjectAtIndex:j];
                j -= 1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
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
    
    //NSLog(@"finar %@",finArr);
    self.foodData = finArr;
    [self.rightTableView reloadData];
}
#pragma 确定下来每个模型的位置
-(void)GiveModelSetidex:(NSMutableArray *)foodData {
    
    for (int i= 0; i<foodData.count; i++) {
        
        NSArray *arr = foodData[i];
        for (int j = 0; j<arr.count; j++) {
            
            Home_CaiPinModel *model = arr[j];
            model.session = i;
            model.row = j;
        }
    }
    //DLog(@"%@",foodData);
}

#pragma mark -- 计算钱
-(void)computeMoney:(NSMutableArray *)Arr {

    //计算钱
    float all = 0.00;
    for (Home_CaiPinModel *model in Arr) {
        
        all += [model.price integerValue]*model.selectnumber;
    }
    all = all/100;
    _shopAllpricelab.text = [NSString stringWithFormat:@"¥ %0.2f",all];
}


#pragma  mark --- seachbardelegate ----
//开始编辑
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    //[self.searchBarArr removeAllObjects];
    
//    [UIView animateWithDuration:0.3 animations:^{
       _searchView.searchbar.showsCancelButton = YES;
//    }];
    [_searchView.searchbar becomeFirstResponder];
    [self.view addSubview:self.skTableView];
    
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
    [self.skTableView reloadData];
}
-(UITableView*)skTableView {
    
    if (!_skTableView) {
        _skTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44*newKhight, kWidth, kHeight-kNavBarHAndStaBarH-44*newKhight) style:(UITableViewStylePlain)];
        
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

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {

    [self Tabviewdissmiss];
}


-(void)Tabviewdissmiss {
    
    [_searchView.searchbar resignFirstResponder];
    _searchView.searchbar.showsCancelButton = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _skTableView.alpha = 0;
        
    } completion:^(BOOL finished) {
        _backstion = YES;
        _skTableView = nil;
        _searchView.searchbar.text = @"";
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

-(NSString *)contentJosn {
    NSString *placstr;
    [self.placArr removeAllObjects];
    [self.FoodselectArr enumerateObjectsUsingBlock:^(Home_CaiPinModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
       NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:model.sid,@"id",[NSString stringWithFormat:@"%ld",model.selectnumber],@"num", nil];
        
        //NSString *str = [StringUtil dictionaryToJson:dic];
        [self.placArr addObject:dic];
    }];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:self.placArr forKey:@"data"];
    //字典转字符串
    placstr = [StringUtil dictionaryToJson:dict];
    DLog(@"placstr %@",placstr);

    NSString *plac = [placstr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    DLog(@"%@",plac);
    return plac;
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
    _markView.model = GuideViewCleanModeRoundRect;
    //markView.guideColor = kCbgColor;
    _markView.showRect = CGRectMake(kWidth-44*newKwith, kNavBarHAndStaBarH+103*newKhight, 30*newKwith, 30*newKhight);
    _markView.markText = @"点击将菜品加入购物车";
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    
    [_markView addSubview:self.okimg];
    
    WeakType(self);
    self.okimg.Click = ^{
        
        [UIView animateWithDuration:0.3 animations:^{
            
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
