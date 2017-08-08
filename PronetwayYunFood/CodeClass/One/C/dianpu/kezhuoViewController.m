//
//  kezhuoViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "kezhuoViewController.h"
#import "kezhuoView.h"
#import "changekezhuoViewController.h"
#import "Home_CP_FLViewController.h"
#import "kezhuoModel.h"
#import "kezhuofenquModel.h"
#import "Home_helpViewController.h"
#import "DeleteViewController.h"
#import "AddAllkezhuoViewController.h"
#import "CodeModel.h"
@interface kezhuoViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,guideDelagate>
{
    NSIndexPath *tableSelection;
    JWBluetoothManage *manage;
}
@property (strong, nonatomic) kezhuoView *kezhuoVC;
@property (strong, nonatomic) NSMutableArray *TabArr;
@property (nonatomic) NSInteger topcount;
@property (strong, nonatomic) NSMutableArray *collectArr;
@property (strong, nonatomic) UIButton *helpBtn;
@property (strong, nonatomic) UIButton *deleteBtn;

//搜索
@property (nonatomic) BOOL  isback;
@property (strong, nonatomic) NSMutableArray *AllArr;

@property (strong, nonatomic) UICollectionView *searchCollect;
@property (strong, nonatomic) NSMutableArray *searchArr;
@property (strong, nonatomic) UILabel *hostNameLab;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) NSMutableDictionary *mutilDic;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) OkimageView *okimg;
@property (strong, nonatomic) GuideView *markView;
@property (assign) int maerkshow;

@property (strong, nonatomic) GuideView *kezhuoShowmarkView;


@property (strong, nonatomic)RedBtn *dayBtn;

@property (assign) BOOL daySelected;

@property (assign)int writeNumber;

//蓝牙数组
@property (nonatomic, strong) NSMutableArray * dataSource; //设备列表
@property (nonatomic, strong) NSMutableArray * rssisArray; //信号强度 可选择性使用
@property (strong, nonatomic)UIButton *rightBtn;
@property (assign)  BOOL ConnectedSuccess; //是否连接成功
@property (strong, nonatomic) NSMutableArray *codeArr;
//二维码url
@property (strong, nonatomic) NSString *payurl;
//客桌的sid数组
@property (strong, nonatomic) NSMutableArray *tableidArr;

@property (strong, nonatomic)UIButton *btn;

@property (strong, nonatomic) UIBarButtonItem *bar;

@property (strong, nonatomic) UIBarButtonItem *cancelbar;
@property (strong, nonatomic) UIButton *RightCancelbtn;
@property (strong, nonatomic) NSMutableArray *dayArr;


@end

@implementation kezhuoViewController

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    //自动重连蓝牙
    [self Autoconnetct];
    if ([UserDefaults objectForKeyStr:kshowkezhuomanagerfenqu] == nil) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showMarkView];
            
        });
    }
    if ([UserDefaults objectForKeyStr:kshowkezhuomanagerfenqu] != nil&&[UserDefaults objectForKeyStr:kshowdeskManager] == nil) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showKezhuoMarkView];
            
        });
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"客桌管理"];

    
    //蓝牙自动重连
    [self ScanBluetooth];
    
    //请求数据
    [self reloadJosnForfenqu];
    _topcount = 0;
    
    [kNotication addObserver:self selector:@selector(reloadfenqu) name:@"reloadfenqu" object:nil];
    [kNotication addObserver:self selector:@selector(reloadkezhuo) name:@"reloadkezuo" object:nil];
    
    [kNotication addObserver:self selector:@selector(dysuccessByblue) name:@"deskmanagerdySuccess" object:nil];
    
    _kezhuoVC = [[kezhuoView alloc]initWithFrame:kBounds];
    _kezhuoVC.Yun_order_Tab.delegate = self;
    _kezhuoVC.Yun_order_Tab.dataSource = self;
    _kezhuoVC.Yun_order_collect.delegate = self;
    _kezhuoVC.Yun_order_collect.dataSource = self;
    _kezhuoVC.searchVC.searchbar.delegate = self;
    
#pragma 长按排序
    [_kezhuoVC.Yun_order_Tab xy_rollViewOriginalDataBlock:^NSArray *{
        //
        DLog(@"你好~");
        return self.TabArr; // 返回当前的数据给tableView内部处理
        
    } callBlckNewDataBlock:^(NSArray *newData) {
        
        // 回调处理完成的数据给外界
        [self.TabArr removeAllObjects];
        [self.TabArr addObjectsFromArray:newData];
        
        NSMutableArray *plteStrArr = [NSMutableArray arrayWithCapacity:10];
        for (int i = 0; i<self.TabArr.count; i++) {
            
        kezhuofenquModel *model = self.TabArr[i];
            [plteStrArr addObject:model.sid];
        }
       NSString *plateStr = [plteStrArr componentsJoinedByString:@","];
        
        DLog(@"拼接之后的字符串是 %@",plateStr);
        NSLog(@"--%ld--",self.TabArr.count);
        
        NetworkManger *manger = [NetworkManger new];
        [manger paixuFenqu:plateStr];
        manger.Addkezuofenqusuccessblock = ^{
            DLog(@"成功 -- ");
        };
    }];
    [_kezhuoVC.fenquBtn addTarget:self action:@selector(fenquClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_kezhuoVC.kezhuoBtn addTarget:self action:@selector(kezhuoClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_kezhuoVC.allBtn addTarget:self action:@selector(allbtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:_kezhuoVC];
    
    _dayBtn = [[RedBtn alloc]initWithFrame:CGRectMake(0, kHeight-44*newKhight-kNavBarHAndStaBarH, kWidth, 44*newKhight) text:@"打印客桌二维码"];
    [_dayBtn addTarget:self action:@selector(daybtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_dayBtn];
    
    [self addRightView];

    
       // Do any additional setup after loading the view.
}

//选中赋值
-(void)selected:(NSMutableArray *)Arr {

    [Arr enumerateObjectsUsingBlock:^(kezhuoModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        model.selected = YES;
        [Arr replaceObjectAtIndex:idx withObject:model];
    }];
}
//打印完成 -- 取消选中
-(void)cancelSelected:(NSMutableArray *)Arr {

    [Arr enumerateObjectsUsingBlock:^(kezhuoModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        model.selected = NO;
        [Arr replaceObjectAtIndex:idx withObject:model];
    }];
    
    _cancelbar = nil;
    _RightCancelbtn = nil;
}

//装tableid的数组
-(NSMutableArray *)tableidArr {
    if (!_tableidArr) {
        _tableidArr = [[NSMutableArray alloc]init];
    }
    return _tableidArr;
}
//加密之后的数组
-(NSMutableArray *)codeArr {
    if (!_codeArr) {
        _codeArr = [[NSMutableArray alloc]init];
    }
    return _codeArr;
}
//装打印的数组
-(NSMutableArray *)dayArr {
    if (!_dayArr) {
        _dayArr = [[NSMutableArray alloc]init];
    }
    return _dayArr;
}

-(void)setupCancelBtn {

    _RightCancelbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _RightCancelbtn.frame = CGRectMake(0, 0, 60*newKwith, 30*newKhight);
    [_RightCancelbtn setTitle:@"取消" forState:(UIControlStateNormal)];
    _RightCancelbtn.titleLabel.font = kFont(16);
    _RightCancelbtn.hidden = NO;
    [_RightCancelbtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [_RightCancelbtn addTarget:self action:@selector(rightcancelClick:) forControlEvents:(UIControlEventTouchUpInside)];
    _cancelbar = [[UIBarButtonItem alloc]initWithCustomView:_RightCancelbtn];
    self.navigationItem.rightBarButtonItem = _cancelbar;
    
}
#pragma mark-- 通知方法 --
-(void)dysuccessByblue {
    
    [self dysuccess];
}

-(void)dysuccess {

    [WSProgressHUD showImage:nil status:@"打印成功!"];
    //打印按钮重置为可点击
    _dayBtn.enabled = YES;
    [_dayBtn setTitle:@"打印客桌二维码" forState:(UIControlStateNormal)];
    [self cancelSelected:self.AllArr];
    [self addRightView];
    
    //重置collect的cell的点击事件
    _daySelected = NO;
    [_kezhuoVC.Yun_order_collect reloadData];

}

// --- 取消 ---
-(void)rightcancelClick:(UIButton *)btn {

    [_dayBtn setTitle:@"打印客桌二维码" forState:(UIControlStateNormal)];
    [self cancelSelected:self.AllArr];
    [_kezhuoVC.Yun_order_collect reloadData];
    [self addRightView];
    _daySelected = NO;
}
//打印客桌二维码
-(void)daybtnClick:(UIButton *)btn {

    if (self.collectArr.count==0) {
        
        [WSProgressHUD showImage:nil status:@"请先添加客桌"];
        return;
    }
//    if ([btn.titleLabel.text isEqualToString:@"确定打印选中客桌"]) {
//        
//        //先检测是否选中了客桌
//        if ([self checkDesk:self.collectArr]) {
//            [WSProgressHUD showImage:nil status:@"请选中需要打印的客桌!"];
//            //btn.selected = NO;
//            return;
//        }else {
//        
//            _btn.selected = NO;
//        }
//    }
    btn.selected = !btn.selected;
    
    if ([btn.titleLabel.text isEqualToString:@"打印客桌二维码"]) {
        btn.selected = YES;
       
    }
    
    if (btn.selected == YES) {
        [btn setTitle:@"确定打印选中客桌" forState:(UIControlStateNormal)];
        _daySelected = YES;
        //collectview变色
        _rightBtn= nil;
        _btn = nil;
        _bar = nil;
      //添加取消按钮
        [self setupCancelBtn];
        //改变选中状态
        [self selected:self.collectArr];
        
        [_kezhuoVC.Yun_order_collect reloadData];
        
//        //选中抖动
//        for (Yun_order_deskCollectionViewCell *cell in [_kezhuoVC.Yun_order_collect visibleCells]) {
//            [self starShake:cell];
//        }
        
    }else {
//
        if (_ConnectedSuccess == NO) {
            
            BluetoothListViewController *blueVC = [BluetoothListViewController new];
            blueVC.manager =   manage;
            blueVC.deviceArray = self.dataSource;
            blueVC.rissArr = self.rssisArray;
            blueVC.placStr = [self loadPlacStr];
            blueVC.collectArr = self.collectArr;
            blueVC.selectStr = @"Yun_DeskManager";
            [self.navigationController pushViewController:blueVC animated:YES];
            return;
            
        }
        //--开始批量打印--
        Alert *alert = [Alert new];
        [alert alert:@"确定批量打印选中客桌?"];
        alert.alert.OKBlock = ^{
            DLog(@"批量打印");
            //--打印完成之后,让按钮可以编辑--
            btn.enabled = NO;
            [self reloadJosnForcode:[self loadPlacStr]];
        };
    }
}

//检测是不是全部取消了
-(BOOL)checkDesk:(NSMutableArray *)Arr {

    for (kezhuoModel *model in Arr) {
        
        if (model.selected == YES) {
            
            return NO;
            break;
        }
        
    }
    return YES;
}

-(NSString *)loadPlacStr {

    [self.tableidArr removeAllObjects];
    [self.collectArr enumerateObjectsUsingBlock:^(kezhuoModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (model.selected == YES) {
            
            [self.tableidArr addObject:model];
        }
    }];
    
    NSMutableArray *plaeArr = [NSMutableArray array];
    [self.tableidArr enumerateObjectsUsingBlock:^(kezhuoModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [plaeArr addObject:model.sid];
    }];
    
    NSString *plateStr = [plaeArr componentsJoinedByString:@","];
    return plateStr;
}

//获取所有加密之后的字符串
-(void)reloadJosnForcode:(NSString *)placStr {

    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kkezhuoCode1,[UserDefaults objectForKeyStr:ksid],kkezhuoCode2,placStr];
    DLog(@"获取code的url -- %@",url);
    
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            NSArray *arr = dic[@"eimdata"];
            for (NSDictionary *dict in arr) {
                CodeModel *model = [CodeModel setUpModelWithDictionary:dict];
                [self.codeArr addObject:model];
            }
            DLog(@"codeArr count --  %ld",self.codeArr.count);
            
            [self.collectArr enumerateObjectsUsingBlock:^(kezhuoModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [self.codeArr  enumerateObjectsUsingBlock:^(CodeModel *codemodel, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if ([codemodel.tableid isEqualToString:model.sid]) {
                        
                        NSString *payurl = [NSString stringWithFormat:@"%@%@%@",kIpandPort,kkezhuoCode3,codemodel.ordercode];
                     DLog(@" --- name %@  \n numid %@",model.zonename ,model.numid);
                        
                [self write:model payurl:payurl];
                        
                    }
                }];
            }];
        }else {
            [WSProgressHUD showImage:nil status:@"获取加密二维码出错"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}
-(void)backAction {

    if (_isback == YES) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self Tabviewdissmiss];
    }
}

#pragma mark --通知方法 ---
-(void)reloadfenqu {
//请求数据
    [self reloadJosnForfenqu];
}
-(void)reloadkezhuo {
    
    [self reloadJosnForfenqu];
    
}
-(NSMutableArray *)TabArr {
    
    if (!_TabArr) {
        _TabArr = [[NSMutableArray alloc]init];
    }
    return _TabArr;
}
-(NSMutableArray *)collectArr {
    
    if (!_collectArr) {
        _collectArr = [[NSMutableArray alloc]init];
    }
    return _collectArr;
}
-(NSMutableArray *)searchArr {
    
    if (!_searchArr) {
        _searchArr = [[NSMutableArray alloc]init];
    }
    return _searchArr;
}
-(NSMutableArray *)AllArr {
    
    if (!_AllArr) {
        _AllArr = [[NSMutableArray alloc]init];
    }
    return _AllArr;
}
//新增分区
-(void)fenquClick:(UIButton *)btn {

    [self adddeskfenqu];
    
}
//客桌分区
-(void)adddeskfenqu {

    Home_CP_FLViewController *flVC = [Home_CP_FLViewController new];
    flVC.selectstr = @"客桌分区";
    [self.navigationController pushViewController:flVC animated:YES];
}

//新增课桌
-(void)kezhuoClick:(UIButton *)btn {
    
    changekezhuoViewController *kezhuoVC = [changekezhuoViewController new];
    if (self.TabArr.count == 0) {
        
        [WSProgressHUD showImage:nil status:@"请先添加分区"];
        
        return;
    }
    kezhuoVC.kezhuoArr = self.TabArr;
    if (self.TabArr.count!=0) {
        if (tableSelection.row<self.TabArr.count) {
            
            kezhuoVC.model = self.TabArr[tableSelection.row];
        }
    }
    [self.navigationController pushViewController:kezhuoVC animated:YES];
}

//批量添加客桌
-(void)allbtnClick:(UIButton *)btn {

    [self addAlldesk];
}
//批量添加客桌
-(void)addAlldesk {

    if (self.TabArr.count == 0) {
        [WSProgressHUD showImage:nil status:@"请先添加分区"];
        return;
    }
    AddAllkezhuoViewController *kezhuoVC = [AddAllkezhuoViewController new];
    
    kezhuoVC.allArr = self.TabArr;
    
    if (self.TabArr.count!=0) {
        if (self.TabArr.count>tableSelection.row) {
            kezhuoVC.model = self.TabArr[tableSelection.row];
            
        }else {
            kezhuoVC.model = self.TabArr[0];
        }
    }
    [self.navigationController pushViewController:kezhuoVC animated:YES];
}

//添加右上角按钮
-(void)addRightView {

     UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80*newKwith, 40*newKhight)];
    
    _deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _deleteBtn.frame = CGRectMake(0, 0, 50*newKwith, 40*newKhight);
    [_deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    _deleteBtn.titleLabel.font = kFont(12);
     [_deleteBtn setImage:kimage(@"Yun_dianpu_delete") forState:(UIControlStateNormal)];
    [_deleteBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop  imageTitleSpace:5*newKhight];
    
    [_deleteBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [rightButtonView addSubview:_deleteBtn];
    
    //右按钮
    _btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _btn.frame = CGRectMake(40*newKwith, 0, 50*newKwith,40*newKhight);
    [_btn setTitle:@"帮助" forState:(UIControlStateNormal)];
    _btn.titleLabel.font = kFont(12);
    [_btn setImage:kimage(@"Yun_home_caipin_wenhao") forState:(UIControlStateNormal)];
    [_btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop  imageTitleSpace:5*newKhight];
    [_btn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [_btn addTarget:self action:@selector(helpBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [rightButtonView addSubview:_btn];
    
   _bar = [[UIBarButtonItem alloc]initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = _bar;
    
}
//删除 --
-(void)deleteClick:(UIButton *)btn {
    if (![ValidateUtil checkuserType]) {
        
        [WSProgressHUD showImage:nil status:@"暂无权限"];
        return;
    }

    DeleteViewController *deleVC = [DeleteViewController new];
    [self.navigationController pushViewController:deleVC animated:YES];
}
-(void)helpBtn:(UIButton *)btn {

    self.hidesBottomBarWhenPushed = YES;
     Home_helpViewController *helpeVC =  [Home_helpViewController new];
    helpeVC.selectStr = @"kezhuomanager";
 [self.navigationController pushViewController:helpeVC animated:YES];
}

//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _TabArr.count;
}

//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KezhuoleftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yun_tabcell"forIndexPath:indexPath];
    if (cell == nil) {
    cell = [[KezhuoleftTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"yun_tabcell"];
    }
    kezhuofenquModel *model = self.TabArr[indexPath.row];
    cell.name.text = model.name;
    
    return cell;
}

//cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableSelection = indexPath;
    _topcount++;
    //KezhuoleftTableViewCell *cell = [tableView cellForRowAtIndexPath:tableSelection];
    switch (_topcount)
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
    DLog(@" -- %ld ",indexPath.row);
}

-(void)cancelOther:(NSMutableArray *)AllArr {

    
    
    
}
//单击事件
-(void)singleTap {

    _topcount = 0;
    kezhuofenquModel *model = self.TabArr[tableSelection.row];

    @try {
        self.collectArr = _mutilDic[model.sid];
        
        if (_daySelected == YES) {
            
            [self selected:self.collectArr];

        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    [_kezhuoVC.Yun_order_collect reloadData];
   // [self reloadjosnByzoneid:model.sid];

}

//双击事件
-(void)doubleTap {

    _topcount = 0;
    Home_CP_FLViewController *flVC = [Home_CP_FLViewController new];
    flVC.selectstr = @"修改客桌分区";
    flVC.kezhuofenqumodel = self.TabArr[tableSelection.row];
    [self.navigationController pushViewController:flVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 60*newKhight;
}

#pragma  mark ----- collectview 的代理 -----
/**
 * 代理方法
 */
//定义展示的Section的个数  ---  分区
-( NSInteger )numberOfSectionsInCollectionView:( UICollectionView *)collectionView
{
    return 1 ;
}
//定义展示的UICollectionViewCell的个数
-( NSInteger )collectionView:( UICollectionView *)collectionView numberOfItemsInSection:( NSInteger )section
{
    if (collectionView == _searchCollect) {
        
        return _searchArr.count;
    }else {
        return _collectArr.count;
    }
}
/**
 *  展示cell
 */
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Yun_order_deskCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier :@"Yun_order_colleect" forIndexPath :indexPath];
    cell.backgroundColor = kWhiteColor;
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 2;
    cell.layer.borderColor = [kyellowcolor CGColor];
    cell.layer.borderWidth = 1;
    
    if (collectionView == _searchCollect) {
        kezhuoModel *model = self.searchArr[indexPath.row];
        cell.mangerModel = model;

    }else {
        //管理界面
        kezhuoModel *model = self.collectArr[indexPath.row];
        cell.mangerModel = model;
    }
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {

    
   
}

//UICollectionView被选中时调用的方法
-(void)collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath
{
   // Yun_order_deskCollectionViewCell * cell = ( Yun_order_deskCollectionViewCell *)[collectionView cellForItemAtIndexPath :indexPath];
    //cell.backgroundColor = RGB(245, 153, 0);
    
    if (collectionView == _searchCollect) {
        changekezhuoViewController *changeVC = [changekezhuoViewController new];

        kezhuoModel *model = self.searchArr[indexPath.row];
        changeVC.selectStr = @"change";
        changeVC.kezhuoModel = model;
        changeVC.model = self.searchArr[indexPath.row];
        changeVC.kezhuoArr = self.TabArr;
        [self.navigationController pushViewController:changeVC animated:YES];
        
    }else {
    
        if (_daySelected == YES) {
            kezhuoModel *model = self.collectArr[indexPath.row];

            if (model.selected == YES) {
                DLog(@"选中");
            model.selected = NO;
            [self.collectArr replaceObjectAtIndex:indexPath.row withObject:model];
               
          // Yun_order_deskCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
             //   [self starShake:cell];
                
                
            }else {
                
                model.selected = YES;
                [self.collectArr replaceObjectAtIndex:indexPath.row withObject:model];
            }
            
            [_kezhuoVC.Yun_order_collect reloadData];
            
        }else {
            changekezhuoViewController *changeVC = [changekezhuoViewController new];
            kezhuoModel *model = self.collectArr[indexPath.row];
            changeVC.selectStr = @"change";
            changeVC.kezhuoModel = model;
            changeVC.kezhuoArr = self.TabArr;
            if (tableSelection == nil) {
                changeVC.model = self.TabArr[0];
            }else {
                changeVC.model = self.TabArr[tableSelection.row];
            }
            [self.navigationController pushViewController:changeVC animated:YES];
        }
    }
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
//查询分区
-(void)reloadJosnForfenqu {

    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kquerykezhuofenqu1,[UserDefaults objectForKeyStr:ksid],kquerykezhuofenqu2,@""];
    DLog(@"查询客桌分区的url %@",url);
    
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            NSArray *arr = dic[@"eimdata"];
            
            if (arr.count == 0) {
                
                return ;
            }else {
            
                [UserDefaults setObjectleForStr:@"YES" key:kshowkezhuomanagerfenqu];
            }
            
            [self.TabArr removeAllObjects];
            
            for (NSDictionary *dict in arr) {
                
            kezhuofenquModel *model = [kezhuofenquModel setUpModelWithDictionary:dict];
            [self.TabArr addObject:model];
                
            }
            //获取所有数组
            [self reloadjosnByzoneid:@""];
         
            [_kezhuoVC.Yun_order_Tab reloadData];
            
         if (arr.count!=0) {
            
             if (tableSelection.row<self.TabArr.count) {
                 
            [_kezhuoVC.Yun_order_Tab selectRowAtIndexPath:[NSIndexPath indexPathForRow:tableSelection.row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
                 
             }else {
             
                [_kezhuoVC.Yun_order_Tab selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
             }
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
    url = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kCXByzoneid1,zoneid,kCXByzoneid2,[UserDefaults objectForKeyStr:ksid]];
    
    DLog(@"查询所有客桌的url %@",url);
    
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            NSArray *arr = dic[@"eimdata"];
            if (kStringIsEmpty(zoneid)) {//全部
            [self.AllArr removeAllObjects];
            [self.collectArr removeAllObjects];
                
                for (NSDictionary *dict in arr) {
                    
            kezhuoModel *model = [kezhuoModel setUpModelWithDictionary:dict];
            [self.AllArr addObject:model];
                
                }
            //重新排序之后的数据
            _mutilDic = [PaidateTools paidate:self.AllArr];
                
            if (tableSelection == nil) {
                if (self.TabArr.count!=0) {
                    kezhuofenquModel *model = self.TabArr[0];
                    _collectArr = _mutilDic[model.sid];
                }
            }else {
            
                if (self.TabArr.count!=0) {
                    if (self.TabArr.count>tableSelection.row) {
                        kezhuofenquModel *fenmodel = self.TabArr[tableSelection.row];
                        _collectArr = _mutilDic[fenmodel.sid];
                        
                    }else {
                    
                        kezhuofenquModel *fenmodel = self.TabArr[0];
                        _collectArr = _mutilDic[fenmodel.sid];
                    }
                }
            }
            [_kezhuoVC.Yun_order_collect reloadData];
        }
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

    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
    [cancelBtn setTitleColor:ksearchBarCancelTextColor forState:(UIControlStateNormal)];
    cancelBtn.titleLabel.font = kFont(ksearchBarCancelTextFont);
    [self.view addSubview:self.searchCollect];
    
    if (self.searchArr.count!=0) {
        [self.view addSubview:self.headerView];

        [UIView animateWithDuration:0.3 animations:^{
            _searchCollect.frame = CGRectMake(0 , 44*newKhight*2, kWidth, kHeight-kNavBarHAndStaBarH-44*newKhight);
        }];
    }
}
//搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [_kezhuoVC.searchVC.searchbar resignFirstResponder];
    
    if (_searchArr.count == 0) {
        
        [WSProgressHUD showImage:nil status:@"无匹配项"];
    }
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
        _searchCollect = [[UICollectionView alloc]initWithFrame:CGRectMake(0 , 44*newKhight, kWidth, kHeight-kNavBarHAndStaBarH-44*newKhight) collectionViewLayout:layout];
        //注册cell
        [_searchCollect registerClass:[Yun_order_deskCollectionViewCell class] forCellWithReuseIdentifier:@"Yun_order_colleect"];
        _searchCollect.delegate = self;
        _searchCollect.dataSource = self;
       // _searchCollect.backgroundColor = [UIColor clearColor];
        _searchCollect.backgroundColor = kWhiteColor;
        _isback = NO;
    }
    return _searchCollect;
}
-(void)Tabviewdissmiss {
    
    [_kezhuoVC.searchVC.searchbar resignFirstResponder];
    _kezhuoVC.searchVC.searchbar.showsCancelButton = NO;
    _isback = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _searchCollect.alpha = 0;
        _headerView.alpha = 0;
    } completion:^(BOOL finished) {
        _searchCollect = nil;
        _headerView = nil;
        [_headerView removeFromSuperview];
        [_searchCollect removeFromSuperview];
    }];
}
//模糊查询
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.searchArr removeAllObjects];
    for (int i = 0; i < self.AllArr.count; i++) {
        kezhuoModel *model = self.AllArr[i];
        NSString *string =model.numid ;
        NSString *name = model.zonename;
        if (string.length >= searchText.length) {
            if([string rangeOfString:searchText].location !=NSNotFound)
            {
                [_searchArr addObject:model];
            }else if ([name rangeOfString:searchText].location !=NSNotFound){
                [_searchArr addObject:model];
            }
        }
    }
    _hostNameLab.text = @"🔍结果";
    [self.searchCollect reloadData];
}

-(UIView *)headerView {
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 44*newKhight, kWidth, 44*newKhight)];
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
    _markView.delegate = self;
    _markView.showRect = CGRectMake(0, 50*newKhight+kNavBarHAndStaBarH, 75*newKwith, 55*newKhight);
    _markView.markText = @"课桌根据区域分区，例如 A、B、C、D区等";
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.markView];
}

-(void)dissmissfenqu {

    [UIView animateWithDuration:0.3 animations:^{
        self.markView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.markView removeFromSuperview];
        [PronetwayYunFoodHandle shareHandle].caiPinRight = @"";
    }];
}

-(void)dismissskezhuo {
    [UIView animateWithDuration:0.3 animations:^{
        self.kezhuoShowmarkView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.kezhuoShowmarkView removeFromSuperview];
        [PronetwayYunFoodHandle shareHandle].caiPinRight = @"";
    }];

}
-(void)showKezhuoMarkView {

    _kezhuoShowmarkView = [[GuideView alloc]initWithFrame:kBounds];
    _kezhuoShowmarkView.fullShow = YES;
    [PronetwayYunFoodHandle shareHandle].caiPinRight = @"right";
    _kezhuoShowmarkView.model = GuideViewCleanModeRoundRect;
    _kezhuoShowmarkView.showRect = CGRectMake(90*newKwith,50*newKhight+kNavBarHAndStaBarH, 130*newKwith, 60*newKhight);
    _kezhuoShowmarkView.delegate = self;
    _kezhuoShowmarkView.markText = @"在此批量新增客桌!";
    [[UIApplication sharedApplication].keyWindow addSubview:_kezhuoShowmarkView];
    
}

//view的点击事件
-(void)onprsee:(UITapGestureRecognizer *)tap superselef:(UIView *)superself {

    if (superself == _markView) {//添加分区
        //取得所点击的点的坐标
        CGPoint point = [tap locationInView:self.markView];
        // 判断该点在不在区域内
        if (CGRectContainsPoint(_markView.showRect,point))
        {
            DLog(@"----");
            [self dissmissfenqu];
            [self adddeskfenqu];
        }
        
    }else if (superself == _kezhuoShowmarkView) {//批量添加客桌
    
        //取得所点击的点的坐标
        CGPoint point = [tap locationInView:self.kezhuoShowmarkView];
        // 判断该点在不在区域内
        if (CGRectContainsPoint(_kezhuoShowmarkView.showRect,point))
        {
            DLog(@"----");
            [self dismissskezhuo];
            [self addAlldesk];
        }

        
    }
    
    
    
}


-(void)ScanBluetooth {
    
    self.dataSource = @[].mutableCopy;
    self.rssisArray = @[].mutableCopy;
    manage = [JWBluetoothManage sharedInstance];
    WeakType(self);
    [manage beginScanPerpheralSuccess:^(NSArray<CBPeripheral *> *peripherals, NSArray<NSNumber *> *rssis) {
        weakself.dataSource = [NSMutableArray arrayWithArray:peripherals];
        weakself.rssisArray = [NSMutableArray arrayWithArray:rssis];
    } failure:^(CBManagerState status) {
        [WSProgressHUD showImage:nil status:[self getBluetoothErrorInfo:status]];
    }];
    
    manage.disConnectBlock = ^(CBPeripheral *perpheral, NSError *error) {
        NSLog(@"设备已经断开连接！");
        [WSProgressHUD showImage:nil status:@"设备已断开连接"];
        [weakself setCustomerTitle:@"蓝牙已断开"];
        
        weakself.rightBtn.hidden = NO;
    };
}


-(void)Autoconnetct {
    WeakType(self);
    
    [manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
            
            [WSProgressHUD showImage:nil status:@"连接成功"];
            _ConnectedSuccess = YES;
            [weakself setCustomerTitle:[NSString stringWithFormat:@"已连接%@",perpheral.name]];
            weakself.rightBtn.hidden = YES;
            
            
        }else{
            [WSProgressHUD showImage:nil status:@"自动连接失败"];
            [WSProgressHUD showImage:nil status:error.domain];
            weakself.rightBtn.hidden = NO;
        }
    }];
}

-(void)ritBtnClick {
    
    [self Autoconnetct];
}


-(void)write:(kezhuoModel *)model payurl:(NSString *)payurl {
    
    if (manage.stage != JWScanStageCharacteristics) {
        [WSProgressHUD showImage:nil status:@"打印机正在准备中 .."];
        return;
    }
    NSData *mainData = [[self getPrinter:model payurl:payurl] getFinalData];
    
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
            
            [self dysuccess];
            // [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            NSLog(@"写入错误---:%@",error);
        }
    }];
}


- (JWPrinter *)getPrinter:(kezhuoModel *)model payurl:(NSString *)payurl;
{
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *title = [UserDefaults objectForKeyStr:kdianpuName];
    NSString *str1 = [NSString stringWithFormat:@"桌号 :%@ %@",[model.zonename substringFromIndex:1],model.numid];
    [printer appendText:title alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
    [printer appendText:str1 alignment:HLTextAlignmentCenter fontSize:0x9];
    
    [printer appendNewLine];
    // 二维码
    
    if (payurl!=nil) {
        
        [printer appendQRCodeWithInfo:payurl size:8];
  
    }
    [printer appendNewLine];
    
    [printer appendText:@"请随身携带好贵重物品,谨防遗落!" alignment:1];
    
    return printer;
}
-(NSString *)getBluetoothErrorInfo:(CBManagerState)status{
    NSString * tempStr = @"未知错误";
    switch (status) {
        case CBManagerStateUnknown:
            tempStr = @"未知错误";
            break;
        case CBManagerStateResetting:
            tempStr = @"正在重置";
            break;
        case CBManagerStateUnsupported:
            tempStr = @"设备不支持蓝牙";
            break;
        case CBManagerStateUnauthorized:
            tempStr = @"蓝牙未被授权";
            break;
        case CBManagerStatePoweredOff:
            tempStr = @"蓝牙关闭";
            break;
        default:
            break;
    }
    return tempStr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
