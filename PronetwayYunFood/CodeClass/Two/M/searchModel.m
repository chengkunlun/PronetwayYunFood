//
//  searchModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/7.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "searchModel.h"

@implementation searchModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (searchModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    searchModel *model = [[searchModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}



@end
