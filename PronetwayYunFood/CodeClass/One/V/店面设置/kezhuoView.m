//
//  kezhuoView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "kezhuoView.h"

@implementation kezhuoView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    self.backgroundColor = kWhiteColor;
    
    [self addSubview:self.whbgview];
    
    [self addSubview:self.TopView];
    
    self.backgroundColor = kWhiteColor;
    
    
    [self addSubview:self.Yun_order_Tab];
    
    [self addSubview:self.Yun_order_collect];
    
    
}

-(UIView *)whbgview {

    if (!_whbgview) {
        _whbgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        _whbgview.backgroundColor = kWhiteColor;
      _searchVC   = [[searchBarView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight) placeholder:@"请输入桌号或分区"];
    [_whbgview addSubview:_searchVC];
    }
    return _whbgview;
}

-(UIView *)TopView {
    
    if (!_TopView) {
        _TopView = [[UIView alloc]initWithFrame:CGRectMake(0, _whbgview.endY+5*newKhight, kWidth, 60*newKhight)];
        _TopView.backgroundColor = kWhiteColor;
        
        _fenquBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _fenquBtn.frame = CGRectMake(0, 0, 80*newKwith, 60*newKhight);
        _fenquBtn.backgroundColor = RGB(243, 243, 243);
        [self pakeBtn:_fenquBtn text:@"添加分区" imagename:@"Yun_dianpu_redplus"];
        [_TopView addSubview:_fenquBtn];
        
        UIView *zjView = [[UIView alloc]initWithFrame:CGRectMake(_fenquBtn.endX+10*newKwith, 0, 130*newKwith, 60*newKhight)];
        zjView.backgroundColor = RGB(243, 243, 243);
        [_TopView addSubview:zjView];
        
        _allBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _allBtn.frame = CGRectMake((zjView.width-80*newKwith)/2, 0, 80*newKwith, 60*newKhight);
        [self pakeBtn:_allBtn text:@"批量新增桌位" imagename:@"Yun_dianpu_plus"];
        [zjView addSubview:_allBtn];
        
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(zjView.endX+10*newKwith, 0, 130*newKwith, 60*newKhight)];
        rightView.backgroundColor = RGB(243, 243, 243);
        [_TopView addSubview:rightView];
    
        _kezhuoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _kezhuoBtn.frame = CGRectMake((rightView.width-80*newKwith)/2, 0, 80*newKwith, 60*newKhight);
        [self pakeBtn:_kezhuoBtn text:@"新增单一桌位" imagename:@"Yun_dianpu_plus"];
        [rightView addSubview:_kezhuoBtn];
        
        
        
    }
    
    return _TopView;
}


-(UITableView *)Yun_order_Tab {
    
    if (!_Yun_order_Tab) {
        _Yun_order_Tab = [[UITableView alloc]initWithFrame:CGRectMake(0, _TopView.endY+10*newKhight, 80*newKwith, kHeight-44*newKhight-124*newKhight-kNavBarHAndStaBarH) style:(UITableViewStylePlain)];
        _Yun_order_Tab.rowHeight = 60*newKhight;
        [_Yun_order_Tab registerClass:[KezhuoleftTableViewCell class] forCellReuseIdentifier:@"yun_tabcell"];
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
        _Yun_order_collect = [[UICollectionView alloc]initWithFrame:CGRectMake(_Yun_order_Tab.endX , _Yun_order_Tab.Y, kWidth-(_Yun_order_Tab.endX ), kHeight-kNavBarHAndStaBarH-44*newKhight-_TopView.height-64*newKhight) collectionViewLayout:layout];
        //注册cell
        [_Yun_order_collect registerClass:[Yun_order_deskCollectionViewCell class] forCellWithReuseIdentifier:@"Yun_order_colleect"];
        _Yun_order_collect.backgroundColor = [UIColor clearColor];
        
        
    }
    return _Yun_order_collect;
}

-(void)pakeBtn:(UIButton *)btn text:(NSString *)text imagename:(NSString *)imagename {
    
    CGFloat totalHeight1 = (btn.imageView.frame.size.height + btn.titleLabel.frame.size.height);
    
    // 设置按钮图片偏移
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight1 - btn.imageView.frame.size.height+15*newKhight), 20.0, 10, -btn.titleLabel.frame.size.width+15*newKwith)];
    // 设置按钮标题偏移
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, - btn.imageView.frame.size.width-25*newKwith, -(totalHeight1 - btn.titleLabel.frame.size.height+30*newKhight),0.0)];
    btn.titleLabel.font = kFont(12);
    [btn setTitleColor:RGB(85, 85, 85) forState:(UIControlStateNormal)];
    [btn setImage:kimage(imagename) forState:(UIControlStateNormal)];
    [btn setTitle:text forState:(UIControlStateNormal)];
    
}

@end
