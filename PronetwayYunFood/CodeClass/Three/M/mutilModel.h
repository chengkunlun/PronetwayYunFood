//
//  mutilModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mutilModel : NSObject

@property (assign)  float cmoney;//金额
@property (nonatomic ,strong) NSString *createtime;//创建时间
@property (nonatomic ,strong) NSArray *dishesinfo;//菜品
@property (nonatomic ,strong) NSString *orderno;//编号

+ (mutilModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;


@end
