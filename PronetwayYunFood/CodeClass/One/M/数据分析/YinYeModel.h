//
//  YinYeModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/26.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YinYeModel : NSObject
@property (nonatomic ,strong)  NSString *stime;//wifi名称
@property (nonatomic ,strong) NSString *cMoney;//wifi标识符

+ (YinYeModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;

@end
