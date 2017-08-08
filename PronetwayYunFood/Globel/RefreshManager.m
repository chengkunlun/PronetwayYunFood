//
//  RefreshManager.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/8/1.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "RefreshManager.h"

@implementation RefreshManager

//添加上拉刷新
-(void)addrefreshtab:(UITableView *)tableview {
    //转换tab
    self.tab = tableview;
    
    [self.dataArray addObject:[self timeToString:self.loadTime]];
    [tableview addTopRefreshWithTarget:self action:@selector(topRefreshing)];
    [tableview addBottomRefreshWithTarget:self action:@selector(bottomRefreshing)];

    //添加刷新进度条
    CGRect frame = tableview.bottomRefresh.bounds;
    frame.size.width /= 4;
    tableview.bottomRefresh.progressView = [[UIProgressView alloc] initWithFrame:frame];
    [tableview.bottomRefresh setRefreshText:nil forRefreshState:VORefreshStatePulling];
    
    //使用NSMutableAttributedString可以修改刷新文字内容颜色等
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"下拉刷新内容"];
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:@"下拉刷新内容"];
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:@"释放立即刷新"];
    NSMutableAttributedString *str4 = [[NSMutableAttributedString alloc] initWithString:@"刷新中..."];
    [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, str1.length)];
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0, str2.length)];
    [str3 addAttribute:NSForegroundColorAttributeName value:[UIColor brownColor] range:NSMakeRange(0, str3.length)];
    [str4 addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, str4.length)];
    tableview.topRefresh.refreshTexts = @[str1, str2, str3, str4];
    
    
}

//停止头部刷新
-(void)stoprefreshHeader {

    [self.tab.topRefresh endRefreshing ];
    
}

//停止底部刷新
-(void)stoprefreshFoot {

    [self.tab.bottomRefresh endRefreshing];
}
//头刷新点击事件
-(void)topRefreshing {

    
    NSString *str = @"下拉刷新内容";
    NSString *timeStr =[NSString stringWithFormat:@"\n最后刷新时间: %@", self.dataArray[0]];
    NSMutableAttributedString *attributeTimeStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@%@",str, timeStr]];
    [attributeTimeStr addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0, str.length)];
    [attributeTimeStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(str.length, timeStr.length)];
    [self.tab.topRefresh setRefreshText:attributeTimeStr forRefreshState:VORefreshStatePulling];
    
    if (_delegate && [_delegate respondsToSelector:@selector(headerRefreshClick)]) {
        
        [_delegate headerRefreshClick];
    }
    
}
//底部刷新点击事件
-(void)bottomRefreshing {

    if (_delegate && [_delegate respondsToSelector:@selector(footRefreshClick)]) {
        
        [_delegate footRefreshClick];
    }
    
    
}
- (NSString *)timeToString: (NSDate *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm:ss";
    NSString *timeStr = [formatter stringFromDate:time];
    return timeStr;
}



@end
