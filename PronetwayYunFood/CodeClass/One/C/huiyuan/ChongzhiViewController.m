//
//  ChongzhiViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/19.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "ChongzhiViewController.h"
#import "detailChongzhiViewController.h"
#import "ChuiyuanModel.h"
@interface ChongzhiViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) ChongzhiView *chongVC;
@property (strong, nonatomic) NSMutableArray *ChongMArr;

@property (strong, nonatomic) OkimageView *okimg;
@property (strong, nonatomic) GuideView *markView;
@property (assign) int maerkshow;



@end

@implementation ChongzhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"充值营销"];
    
    _chongVC = [[ChongzhiView alloc]initWithFrame:kBounds];
    _chongVC.Home_huiyuan_colectVC.delegate = self;
    _chongVC.Home_huiyuan_colectVC.dataSource = self;
    [self.view addSubview:_chongVC];
    
    [self addrightbtn];
    [self reloadjosnForgetlist];
    
    [kNotificationCenter addObserver:self selector:@selector(getList) name:@"reloadForchongzhigetList" object:nil];
    if ([UserDefaults objectForKeyStr:kshowhyPay] == nil) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self showMarkView];
        });

    }
    
    
}

-(void)getList{

    [self reloadjosnForgetlist];
}

-(NSMutableArray *)ChongMArr {

    if (!_ChongMArr) {
        _ChongMArr = [NSMutableArray array];
    }
    return _ChongMArr;
}

-(void)addrightbtn {


    UIButton *rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightBtn.frame = CGRectMake(0, 0, 40*newKwith, 44*newKhight);
    rightBtn.titleLabel.font = kBodlFont(23);
    [rightBtn setTitle:@"＋" forState:(UIControlStateNormal)];
    [rightBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
    

}


-(void)rightClick:(UIButton *)btn {

    [self.navigationController pushViewController:[AddChongViewController new] animated:YES];
    
}
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
    return _ChongMArr.count;
    
}
/**
 *  展示cell
 */
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Chongcollectcell * cell = [collectionView dequeueReusableCellWithReuseIdentifier :@"Home_huiyuan_colectcell" forIndexPath :indexPath];
    cell.backgroundColor = kWhiteColor;
    
    cell.layer.masksToBounds = YES;
    cell.layer.borderColor = [kyellowcolor CGColor];
    cell.layer.borderWidth = 1;
    cell.layer.cornerRadius = 5;
    if (self.ChongMArr.count>indexPath.row) {
        cell.model = self.ChongMArr[indexPath.row];
    }
    
    return cell;
}
//UICollectionView被选中时调用的方法
-(void)collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath
{
    // Chongcollectcell * cell = ( Chongcollectcell *)[collectionView cellForItemAtIndexPath :indexPath];
    detailChongzhiViewController *detailCon = [detailChongzhiViewController new];
    detailCon.model = self.ChongMArr[indexPath.row];
    [self.navigationController pushViewController:detailCon animated:YES];
    
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath
{
    return CGSizeMake (145*newKwith, 40*newKhight);
}

//定义每个UICollectionView 的边距
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section
{
    return UIEdgeInsetsMake ( 0 , 10 , 10 , 10 );
    
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10*newKwith;
}
//每个item之间的间距 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20*newKhight;
}


-(void)reloadjosnForgetlist {

    NSString *str = [NSString stringWithFormat:@"%@%@%@%@",kIpandPort,kHuiyuan_getList1,kHuiyuan_getList2,[UserDefaults objectForKeyStr:ksid]];
    DLog(@"会员充值列表的url %@",str);
    
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            NSArray *arr = dic[@"eimdata"];
            
            [arr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                ChuiyuanModel *model = [ChuiyuanModel setUpModelWithDictionary:dict];
                [self.ChongMArr addObject:model];
                
            }];
            
            [_chongVC.Home_huiyuan_colectVC reloadData];
        }
        
        
        
        
    } failure:^(NSError *error) {
        
        [WSProgressHUD showImage:nil status:@"服务器错误"];
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
    
    _markView = [[GuideView alloc]initWithFrame:kBounds];
    _markView.fullShow = YES;
    _markView.model = GuideViewCleanModeRoundRect;
    //markView.guideColor = kCbgColor;
    _markView.showRect = CGRectMake(kWidth-40*newKwith, kStatusBarH, 34*newKwith, 38*newKhight);
    _markView.markText = @"新增您的营销方案";
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    
    [_markView addSubview:self.okimg];
    
    WeakType(self);
    self.okimg.Click = ^{
        
        [UIView animateWithDuration:0.3 animations:^{
            [UserDefaults setObjectleForStr:@"YES" key:kshowhyPay];
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

-(void)dealloc {
    [kNotificationCenter removeObserver:self];
}

@end
