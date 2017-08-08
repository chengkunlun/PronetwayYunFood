//
//  StringUtil.h
//  LfysPersonal
//
//  Created by tao on 15/9/21.
//  Copyright (c) 2015年 qinghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

    //去除空串
    +(NSString*)convertNull:(id)object;

    //字符串是否为空
    +(BOOL) isEmpty:(NSString *)str;

    //字符串是否不为空
    +(BOOL) isNotEmpty:(NSString *)str;

    //获取字符串长度（包括中、英文）
    +(NSInteger) convertToInt:(NSString *) strtemp;

    //验证数值类型是否为空
    +(BOOL) validateDecimalIsNotEmpty:(NSObject *) obj;

    //传人字典打印出model类代码
    +(void)createModelWithDictionary:(NSDictionary *)dict modelName:(NSString *)modelName;
+ (BOOL)isPureInt:(NSString*)string;

+(NSString*)dictionaryToJson:(NSDictionary *)dic;
+(float)widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height
;
+(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;

//出去空字符串
+(NSString *)removeEmptyStr:(NSString *)str;

+ (NSString *)URLEncodedString:(NSString*)resource;


@end
