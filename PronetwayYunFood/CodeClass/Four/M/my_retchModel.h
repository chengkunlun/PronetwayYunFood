//
//  my_retchModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/19.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface my_retchModel : NSObject

@property (nonatomic ,strong)  NSString *mono;//手机号
@property (nonatomic ,strong) NSString *cmoney;//总金额
@property (nonatomic ,strong) NSString *name;//姓名
@property (nonatomic ,strong) NSString *orderno;//订单号
@property (nonatomic ,strong)  NSString *money;//充值金额
@property (nonatomic ,strong) NSString *mtype;//充值方式 1 微信 2 支付宝
@property (nonatomic ,strong) NSString *lasttime;//充值时间


+ (my_retchModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;



@end
