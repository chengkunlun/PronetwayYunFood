//
//  mycountModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/8/2.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mycountModel : NSObject
@property (nonatomic ,strong)  NSString *name;//菜品名称
@property (nonatomic ,strong) NSString *price;//价格
@property (nonatomic ,strong) NSString *quantity;//数量
@property (nonatomic ,strong) NSString *imgpath;//

+ (mycountModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;

@end
