//
//  StringUtil.m
//  LfysPersonal
//
//  Created by tao on 15/9/21.
//  Copyright (c) 2015年 qinghui. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil

    //去除空串
    +(NSString*)convertNull:(id)object{
    
        // 转换空串
        if ([object isEqual:[NSNull null]]) {
            return @"";
        }
        else if ([object isKindOfClass:[NSNull class]])
        {
            return @"";
        }
        else if (object==nil){
            return @"";
        }
        else if (object==Nil){
            return @"";
        }
        else if ([object isEqualToString:@" "]) {
        
        return [object stringByReplacingOccurrencesOfString:@" " withString:@""];
            
        }
        return object;
    }
    //是否为空
    +(BOOL) isEmpty:(NSString *) str{
        return [str class] == [NSNull class] || str == nil || [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0;
    }

    //是否不为空
    +(BOOL) isNotEmpty:(NSString *) str{
        return str != nil && [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0;
    }

    //获取字符串长度（包括中、英文）
    +(NSInteger) convertToInt:(NSString *) strtemp{
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSData* da = [strtemp dataUsingEncoding:enc];
        return [da length];
    }

    //验证数值类型是否不为空
    +(BOOL) validateDecimalIsNotEmpty:(NSObject *) obj{
        return (obj != nil && [obj class] != [NSNull class] && [[NSString stringWithFormat:@"%@",obj] doubleValue] > 0);
    }

    //传人字典打印出model类代码
    +(void)createModelWithDictionary:(NSDictionary *)dict modelName:(NSString *)modelName
    {
        printf("\n@interface %s :NSObject\n",modelName.UTF8String);
        for (NSString *key in dict) {
            NSString *type = ([dict[key] isKindOfClass:[NSNumber class]])?@"NSNumber":@"NSString";
            printf("@property (nonatomic,copy) %s *%s;\n",type.UTF8String,key.UTF8String);
        }
        printf("@end\n");
    
    }

 + (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string]; //定义一个NSScanner，扫描string
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString *jsonString;
        
        if (!jsonData) {
            
        DLog(@"%@",error);
            
        }else{
            
    jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
        NSRange range = {0,jsonString.length};
        //去掉字符串中的空格
        [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
        NSRange range2 = {0,mutStr.length};
        //去掉字符串中的换行符
        [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
        return mutStr;
}

//获取字符串的宽度
+(float)widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height
{
    UIColor  *backgroundColor=[UIColor blackColor];
    UIFont *font=[UIFont boldSystemFontOfSize:fontSize];
    CGRect sizeToFit = [value boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                              NSForegroundColorAttributeName:backgroundColor,
                                                                                                                                              NSFontAttributeName:font
                                                                                                                                              } context:nil];
    
    return sizeToFit.size.width;
}
//获得字符串的高度
+(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    UIColor  *backgroundColor=[UIColor blackColor];
    UIFont *font=[UIFont boldSystemFontOfSize:18.0];
    CGRect sizeToFit = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                             NSForegroundColorAttributeName:backgroundColor,
                                                                                                                                             NSFontAttributeName:font
                                                                                                                                             } context:nil];
    return sizeToFit.size.height;
}

//除去字符串中的空格和换行符
+(NSString *)removeEmptyStr:(NSString *)str {

    //1. 去掉首尾空格和换行符
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //2. 去掉所有空格和换行符
    str = [str stringByReplacingOccurrencesOfString:@"\r"withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n"withString:@""];
    [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}

+ (NSString *)URLEncodedString:(NSString*)resource {
    CFStringRef url = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)resource, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8); // for some reason, releasing this is disasterous
    NSString *result = (__bridge NSString *)url;
    //    [result autorelease];
    return result;
}


@end
