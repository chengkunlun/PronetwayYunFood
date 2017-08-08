//
//  postImage.h
//  PronetwayGeneral
//
//  Created by ckl@pmm on 2017/3/22.
//  Copyright © 2017年 CKLPronetway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface postImage : NSObject

+ (NSURLSessionTask *)uploadWithURL:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                             images:(NSArray<UIImage *> *)images
                               name:(NSString *)name
                           fileName:(NSString *)fileName
                           mimeType:(NSString *)mimeType
                           progress:(HttpProgress)progress
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure;

@end
