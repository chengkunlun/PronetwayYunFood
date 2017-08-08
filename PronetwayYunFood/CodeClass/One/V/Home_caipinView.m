//
//  Home_caipinView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/17.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_caipinView.h"

@implementation Home_caipinView


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
    [self addSubview:self.TopView];
    
}


-(UIView *)TopView {
    
    if (!_TopView) {
        _TopView = [[UIView alloc]initWithFrame:CGRectMake(0, 10*newKhight+44*newKhight, kWidth, 60*newKhight)];
        _TopView.backgroundColor = kWhiteColor;
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80*newKwith, 60*newKhight)];
        leftView.backgroundColor = RGB(243, 243, 243);
        [_TopView addSubview:leftView];
        _CP_FLBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _CP_FLBtn.frame = CGRectMake(0, 0, 80*newKwith, 60*newKhight);
        
        [self pakeBtn:_CP_FLBtn text:@"添加分类" imagename:@"Yun_home_plus"];
        [leftView addSubview:_CP_FLBtn];

        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(leftView.endX+10*newKwith, 0, 274*newKwith, 60*newKhight)];
        rightView.backgroundColor = RGB(243, 243, 243);
        [_TopView addSubview:rightView];
        
        _CP_cpBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _CP_cpBtn.frame = CGRectMake((rightView.width-80*newKwith)/2, 0, 80*newKwith, 60*newKhight);
        [self pakeBtn:_CP_cpBtn text:@"添加菜品" imagename:@"Yun_home_plus"];
       
        [rightView addSubview:_CP_cpBtn];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        view.backgroundColor = rgba(232, 232, 232, 1);
        [self addSubview:view];
        
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
        [view addSubview:self.searchController.searchBar];
        
        
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消"];

        //添加搜索框
//        _searchVC = [[searchBarView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight) placeholder:@"请输入菜名"];
//        [self addSubview:_searchVC];
        
        
    }
    
    return _TopView;
}

-(void)pakeBtn:(UIButton *)btn text:(NSString *)text imagename:(NSString *)imagename {

    CGFloat totalHeight1 = (btn.imageView.frame.size.height + btn.titleLabel.frame.size.height);
    
    // 设置按钮图片偏移
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight1 - btn.imageView.frame.size.height+15*newKhight), 25.0, 10.0, -btn.titleLabel.frame.size.width+25*newKwith)];
    // 设置按钮标题偏移
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, - btn.imageView.frame.size.width-25*newKwith, -(totalHeight1 - btn.titleLabel.frame.size.height+30*newKhight),0.0)];
    btn.titleLabel.font = kFont(12);
    [btn setTitleColor:kGreenColor forState:(UIControlStateNormal)];
    [btn setImage:kimage(imagename) forState:(UIControlStateNormal)];
    [btn setTitle:text forState:(UIControlStateNormal)];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self endEditing:YES];
}

@end
