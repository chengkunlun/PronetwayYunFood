//
//  UserDefaults.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/8.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

//字符串
//存
+(void)setObjectleForStr:(NSString *)str key:(NSString *)key;
//取
+(NSString *)objectForKeyStr:(NSString *)key;

@end
