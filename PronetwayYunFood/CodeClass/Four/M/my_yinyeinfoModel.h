//
//  my_yinyeinfoModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/19.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface my_yinyeinfoModel : NSObject

@property (nonatomic ,strong)  NSString *orderno;//订单号
@property (nonatomic ,strong) NSString *dispname;//店铺名称
@property (nonatomic ,strong) NSString *name;//客桌分区名称
@property (nonatomic ,strong) NSString *numid;//客桌编号
@property (nonatomic ,strong) NSString *money;//消费金额
@property (nonatomic ,strong) NSString *ordertime;//下单时间
@property (nonatomic ,strong) NSString *paytime;//支付时间

+ (my_yinyeinfoModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;


@end
