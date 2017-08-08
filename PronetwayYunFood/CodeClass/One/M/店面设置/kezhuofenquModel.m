//
//  kezhuofenquModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/26.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "kezhuofenquModel.h"

@implementation kezhuofenquModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (kezhuofenquModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    kezhuofenquModel *model = [[kezhuofenquModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}

@end
