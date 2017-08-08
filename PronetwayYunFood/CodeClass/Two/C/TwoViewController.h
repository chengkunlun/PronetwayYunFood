//
//  TwoViewController.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/10.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YunCalssViewController.h"
#import "collectHeaderView.h"
@interface TwoViewController : YunCalssViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray *Yun_order_TabArr;
@property (strong, nonatomic) NSMutableArray *collectArr;

@end
