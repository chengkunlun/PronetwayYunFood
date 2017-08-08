//
//  paiHaoModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/18.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "paiHaoModel.h"

@implementation paiHaoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (paiHaoModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    paiHaoModel *model = [[paiHaoModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}

@end
