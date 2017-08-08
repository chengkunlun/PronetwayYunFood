//
//  incomeModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/21.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "incomeModel.h"

@implementation incomeModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (incomeModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    incomeModel *model = [[incomeModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}


@end
