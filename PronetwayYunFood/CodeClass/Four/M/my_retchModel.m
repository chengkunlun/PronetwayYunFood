//
//  my_retchModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/19.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "my_retchModel.h"

@implementation my_retchModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (my_retchModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    my_retchModel *model = [[my_retchModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}
@end
