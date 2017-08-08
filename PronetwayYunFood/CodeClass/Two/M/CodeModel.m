//
//  CodeModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/17.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "CodeModel.h"

@implementation CodeModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (CodeModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    CodeModel *model = [[CodeModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}
@end
