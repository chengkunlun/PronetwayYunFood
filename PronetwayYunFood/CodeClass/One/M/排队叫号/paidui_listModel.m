//
//  paidui_listModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "paidui_listModel.h"

@implementation paidui_listModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (paidui_listModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    paidui_listModel *model = [[paidui_listModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}


@end
