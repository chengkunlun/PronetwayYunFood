//
//  leisureModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/23.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "leisureModel.h"

@implementation leisureModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (leisureModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    leisureModel *model = [[leisureModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}

@end
