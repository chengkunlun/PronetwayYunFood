//
//  DeleteViewController.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/27.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YunCalssViewController.h"
#import "kezhuofenquModel.h"
#import "kezhuoModel.h"
@interface DeleteViewController : YunCalssViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *leftTabArr;
@property (strong, nonatomic) NSMutableArray *rightcollectArr;

@property (strong, nonatomic) UIView *searchBgView;
@property (strong, nonatomic) UITableView *Yun_order_Tab;
@property (strong, nonatomic) UICollectionView *Yun_order_collect;


@end
