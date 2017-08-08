//
//  ChuiyuanModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/26.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChuiyuanModel : NSObject
@property (nonatomic ,strong)  NSString *name;//wifi名称
@property (nonatomic ,strong) NSString *recharge;//wifi标识符
@property (nonatomic ,strong) NSString *give;//维度
@property (nonatomic ,strong) NSString *total;//进度
@property (nonatomic ,strong) NSString *startdate;//进度
@property (nonatomic ,strong) NSString *enddate;//进度
@property (nonatomic ,strong) NSString *status;//进度
@property (nonatomic ,strong) NSString *smoney;//进度
@property (nonatomic ,strong) NSString *givetotal;//进度
@property (nonatomic ,strong) NSString *numb;//进度
@property (nonatomic ,strong) NSString *lasttime;//进度


+ (ChuiyuanModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;

@end
