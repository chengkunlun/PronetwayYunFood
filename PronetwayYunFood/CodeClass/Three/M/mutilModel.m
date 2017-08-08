//
//  mutilModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "mutilModel.h"

@implementation mutilModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (mutilModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    mutilModel *model = [[mutilModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}
@end
