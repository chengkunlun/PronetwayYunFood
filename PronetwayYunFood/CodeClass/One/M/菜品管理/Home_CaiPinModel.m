//
//  Home_CaiPinModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/19.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_CaiPinModel.h"

@implementation Home_CaiPinModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (Home_CaiPinModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    Home_CaiPinModel *model = [[Home_CaiPinModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}
@end
