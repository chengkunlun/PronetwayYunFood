//
//  Md5Util.h
//  lfys
//
//  Created by tao on 15/6/25.
//  Copyright (c) 2015年 qinghui. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * md5
 */
@interface Md5Util : NSObject


/**
 *  md5 32位加密
 *
 *
 *  @return 加密后字符串
 */
+(NSString *) md5_32:(NSString *) str;

/**
 *	@brief	对文本进行DES加密
 *
 *	@param 	string    待加密的文本数据
 *	@param 	key 	加密所有的公钥
 *	@param 	iv 	加密向量
 *
 *	@return	加密好的数据
 */
+ (NSData *)encryptUseDES:(NSString *)string key:(NSString *)key iv:(const void *)iv;
/**
 *	@brief	对文本进行DES解密
 *
 *	@param 	data    待解密的数据
 *	@param 	key 	解密所用的公钥
 *
 *	@return	解密好的数据
 */
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;


@end
