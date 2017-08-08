//
//  PaidateTools.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "PaidateTools.h"
#import "kezhuoModel.h"
@implementation PaidateTools

+(NSMutableDictionary *)paidate:(NSMutableArray *)mubArr {

    //收银模块
    
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    NSArray *array1 =  mubArr;
    NSMutableArray *array = [NSMutableArray arrayWithArray:array1];
    
    for (int i = 0; i < array.count; i ++) {
        kezhuoModel *imodel = array[i];
        NSString *string = imodel.zoneid;
        NSMutableArray *tempArray = [@[] mutableCopy];
        [tempArray addObject:imodel];
        for (int j = i+1; j < array.count; j ++) {
            kezhuoModel *jmodel = array[j];
            NSString *jstring = jmodel.zoneid;
           // DLog(@"jstring:%@",jstring);
            if([string isEqualToString:jstring]){
             //   DLog(@"jvalue = kvalue");
                [tempArray addObject:jmodel];
                [array removeObjectAtIndex:j];
                j=j-1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
    // self.foodData = dateMutablearray;
   // DLog(@"dateMutablearray %@",dateMutablearray);
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dateMutablearray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL * _Nonnull stop) {
        kezhuoModel *model = arr[0];
        NSString *key = model.zoneid;
        [dict setObject:arr forKey:key];
    }];
    
    return dict;
}

+(NSMutableDictionary *)incomeMoney:(NSMutableArray *)mubArr {

    //收银模块
    

    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    NSArray *array1 =  mubArr;
    NSMutableArray *array = [NSMutableArray arrayWithArray:array1];
    
    for (int i = 0; i < array.count; i ++) {
        kezhuoModel *imodel = array[i];
        NSString *string = imodel.zoneid;
        NSMutableArray *tempArray = [@[] mutableCopy];
        [tempArray addObject:imodel];
        for (int j = i+1; j < array.count; j ++) {
            kezhuoModel *jmodel = array[j];
            NSString *jstring = jmodel.zoneid;
            // DLog(@"jstring:%@",jstring);
            if([string isEqualToString:jstring]){
                //   DLog(@"jvalue = kvalue");
                [tempArray addObject:jmodel];
                [array removeObjectAtIndex:j];
                j=j-1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
    // self.foodData = dateMutablearray;
    // DLog(@"dateMutablearray %@",dateMutablearray);
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dateMutablearray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL * _Nonnull stop) {
        kezhuoModel *model = arr[0];
        NSString *key = model.zoneid;
        [dict setObject:arr forKey:key];
    }];
    
    return dict;

}


-(NSMutableArray *)pai:(NSMutableArray *)OneArr  TwoArr:(NSMutableArray *)TwoArr{
    
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    NSArray *array1 =  OneArr;
    NSMutableArray *array = [NSMutableArray arrayWithArray:array1];
    
    for (int i = 0; i < array.count; i ++) {
        kezhuoModel *imodel = array[i];
        NSString *string = imodel.zoneid;
        NSMutableArray *tempArray = [@[] mutableCopy];
        [tempArray addObject:imodel];
        for (int j = i+1; j < array.count; j ++) {
            kezhuoModel *jmodel = array[j];
            NSString *jstring = jmodel.zoneid;
            DLog(@"jstring:%@",jstring);
            if([string isEqualToString:jstring]){
                DLog(@"jvalue = kvalue");
                [tempArray addObject:jmodel];
                [array removeObjectAtIndex:j];
                j=j-1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
   // DLog(@"dateMutablearray %@",dateMutablearray);
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dateMutablearray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL * _Nonnull stop) {
        kezhuoModel *model = arr[0];
        NSString *key = model.zoneid;
        [dict setObject:arr forKey:key];
    }];
    NSLog(@"Finadict %@",dict);
    
    NSMutableArray *temp = [NSMutableArray array];
    NSMutableArray *finArr = [NSMutableArray array];
    for (int i = 0; i<OneArr.count; i++) {
        kezhuofenquModel *model = OneArr[i];
        NSString *str = model.sid;
        @try {
            temp = dict[str];
            [finArr addObject:temp];
            
        } @catch (NSException *exception) {
            DLog(@"--");
        } @finally {
            
        }
    }
    NSLog(@"finar %@",finArr);
    return finArr;
}

+(NSMutableArray *)systemorderListArrBytabid:(NSMutableArray *)mubArr {

    
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    NSArray *array1 =  mubArr;
    NSMutableArray *array = [NSMutableArray arrayWithArray:array1];
    
    for (int i = 0; i < array.count; i ++) {
        orderListModel *imodel = array[i];
        NSString *string = imodel.tableid;
        NSMutableArray *tempArray = [@[] mutableCopy];
        [tempArray addObject:imodel];
        for (int j = i+1; j < array.count; j ++) {
            orderListModel *jmodel = array[j];
            NSString *jstring = jmodel.tableid;
            // DLog(@"jstring:%@",jstring);
            if([string isEqualToString:jstring]){
                //   DLog(@"jvalue = kvalue");
                [tempArray addObject:jmodel];
                [array removeObjectAtIndex:j];
                j=j-1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
    // self.foodData = dateMutablearray;
    // DLog(@"dateMutablearray %@",dateMutablearray);
    
    return dateMutablearray;
    
    
}

+(NSMutableArray *)systemorderListArrByOrderNumber:(NSMutableArray *)mubArr {

    
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    NSArray *array1 =  mubArr;
    NSMutableArray *array = [NSMutableArray arrayWithArray:array1];
    
    for (int i = 0; i < array.count; i ++) {
        orderListModel *imodel = array[i];
        NSString *string = imodel.orderno;
        NSMutableArray *tempArray = [@[] mutableCopy];
        [tempArray addObject:imodel];
        for (int j = i+1; j < array.count; j ++) {
            orderListModel *jmodel = array[j];
            NSString *jstring = jmodel.orderno;
            // DLog(@"jstring:%@",jstring);
            if([string isEqualToString:jstring]){
                //   DLog(@"jvalue = kvalue");
                [tempArray addObject:jmodel];
                [array removeObjectAtIndex:j];
                j=j-1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
    // self.foodData = dateMutablearray;
    // DLog(@"dateMutablearray %@",dateMutablearray);
    
    return dateMutablearray;
}

//冒泡排序从小到大;
+(NSMutableArray *)expandfromSmalltoBig:(NSMutableArray *)finarr {

    for (int i = 0 ; i < [finarr count] - 1; i++) {
        for (int j = 0 ; j < [finarr count] - 1 - i; j++) {
            NSArray *jarr = finarr[j];
            NSArray *jMoreArr = finarr[j+1];
            orderListModel *jmodel;
            orderListModel *jMoreModel;
            if (jarr.count!=0) {
                
                jmodel = jarr[0];

            }
            if (jMoreArr.count!=0) {
                
                jMoreModel = jMoreArr[0];
            }
            
            if ([[DateUtil TimeToTimestamp:jmodel.createtime ] intValue]  > [[DateUtil TimeToTimestamp:jMoreModel.createtime] intValue] )//字符串转换int比较大小
            {
                [finarr exchangeObjectAtIndex:j withObjectAtIndex:(j+1)];
            }
        }
    }
    
    
    
    return finarr;
}





@end
