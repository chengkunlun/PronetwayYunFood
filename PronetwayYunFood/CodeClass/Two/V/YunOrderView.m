//
//  YunOrderView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/15.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YunOrderView.h"
#import "Yun_order_deskCollectionViewCell.h"
@implementation YunOrderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    self.backgroundColor = kblackColor;
    _whbgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
    _whbgView.backgroundColor = RGB(232, 232, 232);
    [self addSubview:_whbgView];
    //创建UISearchController
    //搜索时，背景变模糊
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    
    //三个默认都是yes
    //搜索时背景变暗色
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    //搜索时，背景变模糊
    self.searchController.obscuresBackgroundDuringPresentation = NO;

    //点击搜索的时候,是否隐藏导航栏
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    

    
    //包着搜索框外层的颜色
    self.searchController.searchBar.barTintColor = RGB(232, 232, 232);
    //提醒字眼
    self.searchController.searchBar.placeholder= @"请输入桌号或者分区";
    //除掉bar下面的黑线
    UIImageView *barImageView = [[[self.searchController.searchBar.subviews firstObject] subviews] firstObject];
    barImageView.layer.borderColor = RGB(232,232,232).CGColor;
    barImageView.layer.borderWidth = 1;
    
    //提前在搜索框内加入搜索词
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0*newKhight);
    [_whbgView addSubview:self.searchController.searchBar];

    
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消"];
    [self addSubview:self.Yun_order_Tab];
    [self addSubview:self.Yun_order_collect];
    
}
-(UITableView *)Yun_order_Tab {

    if (!_Yun_order_Tab) {
        _Yun_order_Tab = [[UITableView alloc]initWithFrame:CGRectMake(0, _whbgView.endY+2, 80*newKwith, kHeight-kNavBarHAndStaBarH-44*newKhight-kTabBarH) style:(UITableViewStylePlain)];
        _Yun_order_Tab.rowHeight = 60*newKhight;
        [_Yun_order_Tab registerClass:[Yun_leftTableViewCell class] forCellReuseIdentifier:@"yun_order_tabcell"];
        _Yun_order_Tab.backgroundColor = RGB(51, 51, 51);
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
        //注册cell
        [_Yun_order_collect registerClass:[Yun_order_deskCollectionViewCell class] forCellWithReuseIdentifier:@"Yun_order_colleect"];
       // _Yun_order_collect.delegate = self;
        //_Yun_order_collect.dataSource = self;
        _Yun_order_collect.backgroundColor = [UIColor clearColor];
    }
    return _Yun_order_collect;
}



@end
