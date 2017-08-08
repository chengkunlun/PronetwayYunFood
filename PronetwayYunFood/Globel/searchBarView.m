//
//  searchBarView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/7.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "searchBarView.h"

@implementation searchBarView

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView:placeholder];
    }
    return self;
}

-(void)addView:(NSString *)placeholder{

    
    _searchbar = [[UISearchBar alloc]initWithFrame:self.bounds];
    _searchbar.placeholder = placeholder;
    // bar.backgroundColor = kClearColor;
    //  bar.barStyle =  UIBarStyleBlack ;  //黑色风格，黑色的搜索框;
    _searchbar.barTintColor = RGB(232, 232, 232);
    _searchbar.layer.masksToBounds = YES;
    //bar.showsScopeBar = YES;//是否半透明
    _searchbar.searchBarStyle = UISearchBarIconClear;
    _searchbar.layer.cornerRadius = 5;
    [self addSubview:_searchbar];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消"];
    //除掉bar下面的黑线
    UIImageView *barImageView = [[[_searchbar.subviews firstObject] subviews] firstObject];
    barImageView.layer.borderColor = RGB(248,248,248).CGColor;
    barImageView.layer.borderWidth = 1;
    
    
}


@end
