//
//  XDModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/12.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "XDModel.h"

@implementation XDModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (XDModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    XDModel *model = [[XDModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}

@end
