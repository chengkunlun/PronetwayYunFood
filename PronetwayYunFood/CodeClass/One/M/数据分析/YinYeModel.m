//
//  YinYeModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/26.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YinYeModel.h"

@implementation YinYeModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (YinYeModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    YinYeModel *model = [[YinYeModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}
@end
