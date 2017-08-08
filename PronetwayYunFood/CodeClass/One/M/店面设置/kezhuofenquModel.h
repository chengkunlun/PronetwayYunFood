//
//  kezhuofenquModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/26.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface kezhuofenquModel : NSObject


@property (nonatomic ,strong)  NSString *sid;//分区的唯一标识
@property (nonatomic ,strong) NSString *name;//分区名称
@property (nonatomic ,strong) NSString *groupid;//商店id
@property (nonatomic ,strong) NSString *lasttime;//上次更新的时间
@property (strong, nonatomic) NSString *znumberint;
+ (kezhuofenquModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;

@end
