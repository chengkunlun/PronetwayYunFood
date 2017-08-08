//
//  kezhuoView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Yun_order_deskCollectionViewCell.h"
#import "KezhuoleftTableViewCell.h"
@interface kezhuoView : UIView


@property (strong, nonatomic) UIView *TopView;

@property (strong, nonatomic) UIButton *fenquBtn;
@property (strong, nonatomic) UIButton *kezhuoBtn;

@property (strong, nonatomic) UIView *searchBgView;
@property (strong, nonatomic) UITableView *Yun_order_Tab;
@property (strong, nonatomic) UICollectionView *Yun_order_collect;

@property (strong, nonatomic)UIView *whbgview;

@property (strong, nonatomic) UIButton *allBtn;

@property (strong, nonatomic)searchBarView *searchVC;

@property (strong, nonatomic) RedBtn *dayBtn;

@end
