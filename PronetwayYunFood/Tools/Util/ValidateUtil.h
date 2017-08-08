//
//  ValidateUtil.h
//  LfysPersonal
//
//  Created by tao on 15/10/28.
//  Copyright © 2015年 qinghui. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 验证的工具类
@interface ValidateUtil : NSObject


/**
 *  验证手机号码
 *
 *
 */
+ (BOOL)checkTel:(NSString *)mobileNumbel;


//验证手机号 + 固话
+(BOOL)checkNumber:(NSString *)number;
/**
 *  验证邮箱
 *
 *
 */
+(BOOL) checkEmail:(NSString *)email;


/**
 *  验证数值类型是否为空
 *
 *
 */
+(BOOL) checkDecimalIsNotEmpty:(NSObject *) obj;

/**
 *  验证输入省份证号是否正确
 *
 *
 */
+ (BOOL)checkIdentityCardNo:(NSString*)cardNo;


/**
 * 验证是否是老板登录 - -
 */

+(BOOL)checkuserType;






@end
