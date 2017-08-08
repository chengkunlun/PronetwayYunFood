//
//  my_yinyeinfoModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/19.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "my_yinyeinfoModel.h"

@implementation my_yinyeinfoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (my_yinyeinfoModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    my_yinyeinfoModel *model = [[my_yinyeinfoModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}
@end
