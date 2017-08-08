//
//  DeleteViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/27.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "DeleteViewController.h"
#import "deleteleftTableViewCell.h"
#import "deletrightCollectionViewCell.h"
@interface DeleteViewController ()<TDAlertViewDelegate>

@property (strong, nonatomic) NSIndexPath *LeftSelectedindex;
@property (strong, nonatomic) NSIndexPath *rigHtindex;
@property (strong, nonatomic) NSMutableArray *RightSelectArr;
@property (strong, nonatomic) NSMutableArray *LeftSelectArr;

@property (nonatomic) BOOL okBtnselected;
@property (strong, nonatomic) NSMutableArray *AllArr;

@property (strong, nonatomic) NSMutableDictionary *mutilDic;
@end

@implementation DeleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"删除"];
   // [self rightView];
    
    [self.view addSubview:self.searchBgView];
    
    [self.view addSubview:self.Yun_order_Tab];
    [self.view addSubview:self.Yun_order_collect];
    
    //默认选中第一个
    [self reloadJosnForfenqu];
    
    // Do any additional setup after loading the view.
}
#pragma mark --- 懒加载 ---
-(NSMutableArray *)rightcollectArr {

    if (!_rightcollectArr) {
        _rightcollectArr = [[NSMutableArray alloc]init];
    }
    return _rightcollectArr;
}

-(NSMutableArray *)leftTabArr {
    
    if (!_leftTabArr) {
        _leftTabArr = [[NSMutableArray alloc]init];
    }
    return _leftTabArr;
}
-(NSMutableArray *)LeftSelectArr {
    
    if (!_LeftSelectArr) {
        _LeftSelectArr = [[NSMutableArray alloc]init];
    }
    return _LeftSelectArr;
}
-(NSMutableArray *)RightSelectArr {
    
    if (!_RightSelectArr) {
        _RightSelectArr = [[NSMutableArray alloc]init];
    }
    return _RightSelectArr;
}
-(NSMutableArray *)AllArr {
    
    if (!_AllArr) {
        _AllArr = [[NSMutableArray alloc]init];
    }
    return _AllArr;
}

-(void)backAction {

    if ([self check]) {
        
     [self.navigationController popViewControllerAnimated:YES];
        
    }else {
    
        TDAlertItem *item1 = [[TDAlertItem alloc] initWithTitle:@"取消"];
        TDAlertItem *item2 = [[TDAlertItem alloc] initWithTitle:@"确认"];
        item2.titleColor = [UIColor redColor];
        TDAlertView *alert = [[TDAlertView alloc] initWithTitle:@"温馨提示" message:@"您还没有点击完成,是否退出" items:@[item1,item2] delegate:self];
        alert.hideWhenTouchBackground = NO;
        [alert show];
        alert.OKBlock = ^{

            [self.navigationController popViewControllerAnimated:YES];
        };
    }
}

//完成
//-(void)rightView {
//
//    UIButton *rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    rightBtn.frame = CGRectMake(0, 0, 50*newKwith, 40*newKhight);
//    [rightBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
//    [rightBtn setTitle:@"完成" forState:(UIControlStateNormal)];
//    rightBtn.titleLabel.font = kFont(15);
//    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:(UIControlEventTouchUpInside)];
//    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = bar;
//}

-(UIView *)searchBgView {

    if (!_searchBgView) {
        _searchBgView = [[UIView alloc]initWithFrame:CGRectMake(10*newKwith, 0, kWidth-20*newKwith, 40*newKhight)];
        _searchBgView.backgroundColor = kWhiteColor;
    }
    return _searchBgView;
}
-(UITableView *)Yun_order_Tab {
    
    if (!_Yun_order_Tab) {
        _Yun_order_Tab = [[UITableView alloc]initWithFrame:CGRectMake(0, _searchBgView.endY+10*newKhight, 80*newKwith, kHeight) style:(UITableViewStylePlain)];
        _Yun_order_Tab.rowHeight = 60*newKhight;
        [_Yun_order_Tab registerClass:[deleteleftTableViewCell class] forCellReuseIdentifier:@"tabcell"];
        _Yun_order_Tab.delegate = self;
        _Yun_order_Tab.dataSource = self;
        _Yun_order_Tab.backgroundColor = kCbgColor;
        _Yun_order_Tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _Yun_order_Tab;
}
#pragma mark --- collectionview创建集合视图 ---
-(UICollectionView *)Yun_order_collect {
    
    if (!_Yun_order_collect) {
        
        //先实例化一个层
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //创建collectionview
        _Yun_order_collect = [[UICollectionView alloc]initWithFrame:CGRectMake(_Yun_order_Tab.endX , _Yun_order_Tab.Y, kWidth-(_Yun_order_Tab.endX ), kHeight-kNavBarHAndStaBarH-44*newKhight-kTabBarH) collectionViewLayout:layout];
        _Yun_order_collect.delegate = self;
        _Yun_order_collect.dataSource = self;
        //注册cell
        [_Yun_order_collect registerClass:[deletrightCollectionViewCell class] forCellWithReuseIdentifier:@"colleect"];
        _Yun_order_collect.backgroundColor = [UIColor clearColor];
    }
    return _Yun_order_collect;
}
//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.leftTabArr.count;
}
//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    deleteleftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tabcell"forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[deleteleftTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"tabcell"];
    }
    [cell.deleteTabbtn addTarget:self action:@selector(TabbtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    kezhuofenquModel *model = self.leftTabArr[indexPath.row];
    cell.name.text = model.name;
    
    return cell;
}
//cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   //默认选中的位置
    _LeftSelectedindex = indexPath;
    
    kezhuofenquModel *model = self.leftTabArr[indexPath.row];
    
    @try {
        self.rightcollectArr = _mutilDic[model.sid];
        
    } @catch (NSException *exception) {
        
        
    } @finally {
        
    }
    [_Yun_order_collect reloadData];
    DLog(@" -- %ld ",indexPath.row);
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
    return self.rightcollectArr.count;
}
/**
 *  展示cell
 */
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    deletrightCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier :@"colleect" forIndexPath :indexPath];
    cell.backgroundColor = kWhiteColor;
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 2;
    cell.layer.borderColor = [kyellowcolor CGColor];
    cell.layer.borderWidth = 1;
    
    [cell.deleteCollectBtn addTarget:self action:@selector(btnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    
    kezhuoModel *model = self.rightcollectArr[indexPath.row];
    cell.deskNumber.text = [NSString stringWithFormat:@"%@ %@",[model.zonename substringToIndex:1],model.numid];
    cell.deskPeople.text = model.seatnum;
    cell.deskNumber.textColor = kyellowcolor;
    cell.deskPeople.textColor = kyellowcolor;
    return cell;
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
//完成按钮点击事件
////右按钮点击事件
//-(void)rightClick {
//    
//    _okBtnselected = YES;
//    
//    if (self.LeftSelectArr.count!=0) {
//        
//        NSString *plateStr = [self.LeftSelectArr componentsJoinedByString:@","];
//        DLog(@"拼接之后的字符串是 %@",plateStr);
//        //分区删除
//        NetworkManger *manger = [NetworkManger new];
//        [manger deletepf:plateStr];
//        manger.Addkezuofenqusuccessblock = ^{
//            
//            //防止点餐和收银界面选择会蹦
//            [PronetwayYunFoodHandle shareHandle].tableindex = nil;
//            [PronetwayYunFoodHandle shareHandle].Incometableindex = nil;
//        };
//    }
//    
//    if (self.RightSelectArr.count!=0) {
//        
//        NSString *plateStr = [self.RightSelectArr componentsJoinedByString:@","];
//        DLog(@"拼接之后的字符串是 %@",plateStr);
//        //客桌删除
//        NetworkManger *manger = [NetworkManger new];
//        [manger deletekezuoaAll:plateStr];
//        manger.Addkezuofenqusuccessblock = ^{
//            
//        //  [self.navigationController popViewControllerAnimated:YES];
//            
//        };
//    }
//    DLog(@"完成");
//}
//右边删除事件
- (void)btnClick:(UIButton *)sender event:(id)event
{
    //获取点击button的位置
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:_Yun_order_collect];
    NSIndexPath *indexPath = [_Yun_order_collect indexPathForItemAtPoint:currentPoint];
    Alert *al = [Alert new];
    kezhuoModel *model = self.rightcollectArr[indexPath.row];

    [al alert:[NSString stringWithFormat:@"是否删除客桌 %@",model.numid]];
    
    
    al.alert.OKBlock = ^{
    
        
    NetworkManger *manger = [NetworkManger new];
    [manger deletekezuoaAll:model.sid];
        
    manger.Addkezuofenqusuccessblock = ^{
    
    if (indexPath.section == 0 && indexPath != nil) { //点击移除
        [self.Yun_order_collect performBatchUpdates:^{
            //完成删除
            //          //添加右边选中删除的个数
            //             if (self.rightcollectArr.count!=0) {
            //                    kezhuoModel *model = self.rightcollectArr[indexPath.row];
            //                    [self.RightSelectArr addObject:model.sid];
            //
            //                }
            
            [self.Yun_order_collect deleteItemsAtIndexPaths:@[indexPath]];
            [self.rightcollectArr removeObjectAtIndex:indexPath.row]; //删除
            
        } completion:^(BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.Yun_order_collect reloadData];
            });
        }];
    }
};
       
 
    };
}
//左边Tab删除事件--- 分区删除事件 ---
- (void)TabbtnClick:(UIButton *)sender event:(id)event
{
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_Yun_order_Tab];
    NSIndexPath *indexPath= [_Yun_order_Tab indexPathForRowAtPoint:currentTouchPosition];
    
    Alert *al = [Alert new];
    kezhuofenquModel *model = self.leftTabArr[indexPath.row];
    [al alert:[NSString stringWithFormat:@"是否删除分区%@\n (删除分区后,对应的客桌也会被删除!)",model.name]];
    al.alert.OKBlock = ^{
    
        if (indexPath!= nil)
        {
            
            if (self.leftTabArr.count!=0) {
                
                //完成删除
                //左数组
               // kezhuofenquModel *model = self.leftTabArr[indexPath.row];
               // [self.LeftSelectArr addObject:model.sid];
                
                //单点删除
                kezhuofenquModel *model = self.leftTabArr[indexPath.row];
                NetworkManger *manger = [NetworkManger new];
                [manger deletepf:model.sid];
                
                manger.Addkezuofenqusuccessblock = ^{
                    
                    [self.rightcollectArr removeAllObjects];
                    //[self.Yun_order_collect reloadData];
                    
                    //防止点餐和收银界面选择会蹦
                    [PronetwayYunFoodHandle shareHandle].tableindex = nil;
                    [PronetwayYunFoodHandle shareHandle].Incometableindex = nil;
                    //删除
                    [self.leftTabArr removeObjectAtIndex:indexPath.row];
                    
                    //动画效果
                    [_Yun_order_Tab deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]withRowAnimation:UITableViewRowAnimationFade];
                    
                    if (self.leftTabArr.count>0) {
                        
                        [self reloadJosnForfenqu];

                    }else {
                    
                        [_Yun_order_collect reloadData];
                    }

                    
                };
            }
        }
    };
}

//查询分区
-(void)reloadJosnForfenqu {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kquerykezhuofenqu1,[UserDefaults objectForKeyStr:ksid],kquerykezhuofenqu2,@""];
    DLog(@"查询客桌分区的url %@",url);
    
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            NSArray *arr = dic[@"eimdata"];
            
            [self.leftTabArr removeAllObjects];
            
            for (NSDictionary *dict in arr) {
                
                kezhuofenquModel *model = [kezhuofenquModel setUpModelWithDictionary:dict];
                [self.leftTabArr addObject:model];
                
            }
            
            
            [_Yun_order_Tab reloadData];

            if (arr.count!=0) {
                
                if (self.leftTabArr.count>_LeftSelectedindex.row) {
                    
                    [_Yun_order_Tab selectRowAtIndexPath:[NSIndexPath indexPathForRow:_LeftSelectedindex.row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
                }else {
                
                    [_Yun_order_Tab selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
                }
                
            }
            
            [self reloadjosnByzoneid:@""];

            
        }else {
            
            DLog(@"查询客桌分区失败 %@",dic);
        }
        
    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
    }];
}
//根据分区查找数目
-(void)reloadjosnByzoneid:(NSString *)zoneid {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@",kIpandPort,@"/pronline/Msg?FunName@orderEditOdtable",kCXByzoneid2,[UserDefaults objectForKeyStr:ksid]];
    DLog(@"查询所有客桌的url %@",url);
    
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            NSArray *arr = dic[@"eimdata"];
            
                [self.rightcollectArr removeAllObjects];
                [self.AllArr removeAllObjects];
                for (NSDictionary *dict in arr) {
                    
                kezhuoModel *model = [kezhuoModel setUpModelWithDictionary:dict];
                [self.AllArr addObject:model];
                    
                }
            
            [self pai:self.AllArr];
            
           // if (self.LeftSelectedindex == nil) {
            
            if (self.leftTabArr.count>_LeftSelectedindex.row) {
                kezhuofenquModel *model = self.leftTabArr[_LeftSelectedindex.row];
                _rightcollectArr = _mutilDic[model.sid];
                
            }else {
            
                if (self.leftTabArr.count!=0) {
                    
                    kezhuofenquModel *model = self.leftTabArr[0];
                    _rightcollectArr = _mutilDic[model.sid];
                }
                

            }
            
           // }
                [_Yun_order_collect reloadData];
            
        }else {
            DLog(@"查询客桌分区失败 %@",dic);
        }
    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
    }];
}

-(void)pai:(NSMutableArray *)foodArr {
    
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    NSArray *array1 =  foodArr;
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
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dateMutablearray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL * _Nonnull stop) {
        kezhuoModel *model = arr[0];
        NSString *key = model.zoneid;
        [dict setObject:arr forKey:key];
    }];
    _mutilDic = dict;
    
    NSLog(@"Finadict %@",_mutilDic);
    
    NSMutableArray *temp = [NSMutableArray array];
    NSMutableArray *finArr = [NSMutableArray array];
    for (int i = 0; i<self.leftTabArr.count; i++) {
        kezhuofenquModel *model = self.leftTabArr[i];
        NSString *str = model.sid;
        
        @try {
            temp = dict[str];
            [finArr addObject:temp];
            
        } @catch (NSException *exception) {
            DLog(@"--");
        } @finally {
            
        }
    }
    
   DLog(@"finar %@",finArr);
    
    // self.collectArr = finArr;
    // [self.rightTableView reloadData];
    
}


-(BOOL)check {

    if (self.LeftSelectArr.count!=0||self.RightSelectArr.count!=0) {
        if (_okBtnselected == NO) {
            
            return NO;
        }
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
