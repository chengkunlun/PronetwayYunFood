//
//  kezhuoModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/26.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "kezhuoModel.h"

@implementation kezhuoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (kezhuoModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    kezhuoModel *model = [[kezhuoModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}

@end
