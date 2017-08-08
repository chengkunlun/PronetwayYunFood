//
//  my_listModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/28.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "my_listModel.h"

@implementation my_listModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (my_listModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    my_listModel *model = [[my_listModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}


@end
