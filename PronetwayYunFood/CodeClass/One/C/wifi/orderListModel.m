//
//  orderListModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/31.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "orderListModel.h"

@implementation orderListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (orderListModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    orderListModel *model = [[orderListModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}

@end
