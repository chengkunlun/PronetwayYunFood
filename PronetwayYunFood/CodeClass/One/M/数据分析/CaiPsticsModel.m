//
//  CaiPsticsModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/27.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "CaiPsticsModel.h"

@implementation CaiPsticsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (CaiPsticsModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    CaiPsticsModel *model = [[CaiPsticsModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}

@end
