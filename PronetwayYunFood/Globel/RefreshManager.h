//
//  RefreshManager.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/8/1.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RefreshDelegate <NSObject>

-(void)headerRefreshClick;
-(void)footRefreshClick;


@end

@interface RefreshManager : NSObject


@property (strong, nonatomic) id<RefreshDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSDate *loadTime;
@property (strong, nonatomic) UITableView *tab;
//添加上拉刷新
-(void)addrefreshtab:(UITableView *)tableview;

//停止头部刷新
-(void)stoprefreshHeader;

//停止底部刷新
-(void)stoprefreshFoot;




@end
