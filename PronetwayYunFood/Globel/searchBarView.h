//
//  searchBarView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/7.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchBarView : UIView
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder;
@property (nonatomic,retain)  UISearchBar * searchbar;


@property (strong, nonatomic)UISearchController *searchController;
@end
