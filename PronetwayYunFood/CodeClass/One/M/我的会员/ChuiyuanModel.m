//
//  ChuiyuanModel.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/26.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "ChuiyuanModel.h"

@implementation ChuiyuanModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (ChuiyuanModel *)setUpModelWithDictionary:(NSDictionary *)dictionary {
    
    ChuiyuanModel *model = [[ChuiyuanModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
    
}
@end
