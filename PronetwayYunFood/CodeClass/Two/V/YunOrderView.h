//
//  YunOrderView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/15.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Yun_order_deskCollectionViewCell.h"
#import "Yun_leftTableViewCell.h"
#import "kezhuoModel.h"
#import "kezhuofenquModel.h"
//添加代理

@interface YunOrderView : UIView

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) UITableView *Yun_order_Tab;
@property (strong, nonatomic) UICollectionView *Yun_order_collect;
@property (strong, nonatomic) UIView *whbgView;
@property (strong, nonatomic)searchBarView *searchview;
@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行
@property (nonatomic)  int cellshow;


@end
