//
//  searchModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/7.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface searchModel : NSObject
@property (nonatomic ,strong)  NSString *sid;//wifi名称
@property (nonatomic ,strong) NSString *numid;//wifi标识符
@property (nonatomic ,strong) NSString *groupid;//维度
@property (nonatomic ,strong) NSString *seatnum;//进度
@property (strong, nonatomic) NSString *zoneid;
@property (strong, nonatomic) NSString *name; //分区名称
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *paystatus;
@property (strong, nonatomic) NSString *lasttime;

+ (searchModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;


@end
