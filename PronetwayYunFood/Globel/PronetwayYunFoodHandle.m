//
//  PronetwayYunFoodHandle.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/8.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "PronetwayYunFoodHandle.h"

@implementation PronetwayYunFoodHandle

+ (PronetwayYunFoodHandle *)shareHandle{
    static PronetwayYunFoodHandle *handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        handle = [[PronetwayYunFoodHandle alloc]init];
    });
    return handle;
}

+(void)start {

    NSString *str;
    if (kStringIsEmpty(str)) {
        DLog(@"yes");
    }
}

+(BOOL)usertypeStyle {

//    
//    if (<#condition#>) {
//        <#statements#>
//    }
//    
    
    return YES;
}




@end
