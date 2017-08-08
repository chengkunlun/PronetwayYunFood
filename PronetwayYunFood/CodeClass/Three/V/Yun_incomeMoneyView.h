//
//  Yun_incomeMoneyView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/15.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Yun_order_deskCollectionViewCell.h"
#import "Yun_leftTableViewCell.h"

@interface Yun_incomeMoneyView : UIView


@property (strong, nonatomic) UITableView *Yun_order_Tab;
@property (strong, nonatomic) UICollectionView *Yun_order_collect;
@property (strong, nonatomic) NSMutableArray *Yun_order_TabArr;

@property (strong, nonatomic)UIView *whbgview;
@property (strong, nonatomic)searchBarView *searchview;

@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行
@property (nonatomic)  int cellshow;

@property (strong, nonatomic) UISearchController *searchController;



@end
