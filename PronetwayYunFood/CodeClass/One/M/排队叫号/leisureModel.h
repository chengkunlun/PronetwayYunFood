//
//  leisureModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/23.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface leisureModel : NSObject

@property (nonatomic ,strong) NSString *typename;//类型名称
@property (nonatomic ,strong) NSString *typecode;//类型A
@property (nonatomic ,strong) NSString *tpyeid;//类型id
@property (nonatomic ,strong) NSString *totcount;//
@property (strong, nonatomic) NSString *totidle;
@property (strong, nonatomic) NSString *totque;
@property (strong, nonatomic) NSString *curno;

+ (leisureModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;

@end
