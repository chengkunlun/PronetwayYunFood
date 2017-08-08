//
//  StyleCaiPinModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/27.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "StyleCaiPinModel.h"

@implementation StyleCaiPinModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (StyleCaiPinModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    StyleCaiPinModel *model = [[StyleCaiPinModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}


@end
