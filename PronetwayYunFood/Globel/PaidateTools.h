//
//  PaidateTools.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "orderListModel.h"
@interface PaidateTools : NSObject


+(NSMutableDictionary *)paidate:(NSMutableArray *)mubArr;

+(NSMutableDictionary *)incomeMoney:(NSMutableArray *)mubArr;

-(NSMutableArray *)pai:(NSMutableArray *)OneArr  TwoArr:(NSMutableArray *)TwoArr;

//根据tableid排列
+(NSMutableArray *)systemorderListArrBytabid:(NSMutableArray *)mubArr;

//根据orderid排列
+(NSMutableArray *)systemorderListArrByOrderNumber:(NSMutableArray *)mubArr;

//冒泡排序
+(NSMutableArray *)expandfromSmalltoBig:(NSMutableArray *)finarr;



@end
