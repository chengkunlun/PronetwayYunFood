//
//  Md5Util.m
//  lfys
//
//  Created by tao on 15/6/25.
//  Copyright (c) 2015年 qinghui. All rights reserved.
//

#import "Md5Util.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation Md5Util


/**
 *  md5 32位加密
 *
 *str
 *
 *  @return 加密后字符串
 */
+(NSString *) md5_32:(NSString *) str{
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];

}

+ (NSData *)encryptUseDES:(NSString *)string key:(NSString *)key iv:(const void *)iv
{
    const char *textBytes = [string UTF8String];
    NSUInteger dataLength = strlen(textBytes);
    NSMutableData *data = [NSMutableData new];
    
    NSUInteger n = dataLength / 1024;
    for (int i = 0; i <= n;i++){
        unsigned char buffer[1024];
        unsigned char temp[1024];
        memset(buffer, 0, sizeof(char));
        memset(temp, 0, sizeof(char));
        strncpy((char*)temp,textBytes, i==n?dataLength-1024*n:1024);
        size_t numBytesEncrypted = 0;
        CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                              kCCOptionPKCS7Padding|kCCOptionECBMode,
                                              [key UTF8String], kCCKeySizeDES,
                                              iv,
                                              temp, i==n?dataLength-1024*n:1024,
                                              buffer, 1024,
                                              &numBytesEncrypted);
        
        if (cryptStatus == kCCSuccess) {
            [data appendData:[NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted]];
        }
        
    }
    return data;
}
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}


@end
