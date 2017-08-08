//
//  dianpuModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/24.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "dianpuModel.h"

@implementation dianpuModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (dianpuModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    dianpuModel *model = [[dianpuModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}

@end
