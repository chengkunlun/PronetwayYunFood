//
//  mycountModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/8/2.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "mycountModel.h"

@implementation mycountModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (mycountModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    mycountModel *model = [[mycountModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}
@end
