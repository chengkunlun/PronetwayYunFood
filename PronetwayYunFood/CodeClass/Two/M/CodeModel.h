//
//  CodeModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/17.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeModel : NSObject
@property (nonatomic ,strong)  NSString *ordercode;//wifi名称
@property (nonatomic ,strong) NSString *tableid;//wifi标识符

+ (CodeModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;

@end
