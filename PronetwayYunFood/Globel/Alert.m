//
//  Alert.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/14.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Alert.h"

@implementation Alert

-(void)alert:(NSString*)content {

    TDAlertItem *item1 = [[TDAlertItem alloc] initWithTitle:@"取消"];
    TDAlertItem *item2 = [[TDAlertItem alloc] initWithTitle:@"确认"];
    item2.titleColor = [UIColor redColor];
    _alert = [[TDAlertView alloc] initWithTitle:@"温馨提示" message:content items:@[item1,item2] delegate:self];
    _alert.hideWhenTouchBackground = NO;
    [_alert show];
}

@end
