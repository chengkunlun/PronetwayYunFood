//
//  UserDefaults.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/8.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults
#pragma 字符串
//存
+(void)setObjectleForStr:(NSString *)str key:(NSString *)key{
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:key];
}
//取
+(NSString *)objectForKeyStr:(NSString *)key {

    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

#pragma 数组
//存
+(void)steobjectForArr:(NSMutableArray *)arr key:(NSString *)key {

    [[NSUserDefaults standardUserDefaults]setObject:arr forKey:key];
}
//取
+(NSMutableArray *)objectForKeyArr:(NSString *)key {

    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

#pragma 字典
//存
+(void)setObjectFordic:(NSDictionary *)dic key:(NSString *)key{

    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:key];
}
//取
+(NSDictionary *)objectGorKeydic:(NSString *)key {

    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}











@end
