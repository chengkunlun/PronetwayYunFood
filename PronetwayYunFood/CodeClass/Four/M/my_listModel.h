//
//  my_listModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/28.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface my_listModel : NSObject

@property (nonatomic ,strong)  NSString *dispname;//程昆仑美食店啊啊
@property (nonatomic ,strong) NSString *name;//D
@property (nonatomic ,strong) NSString *numid;//010
@property (nonatomic ,strong) NSString *money;//12800
@property (nonatomic ,strong) NSString *ordertime;//2017-06-21 17:39:56
@property (nonatomic ,strong) NSString *paytime;//支付时间 2017-06-22 17:15:10
@property (nonatomic ,strong) NSString *orderno;//订单号 17322019900101498038205
@property (strong, nonatomic) NSString *payway;//充值方式支付方式 1 微信 2 支付宝 3 余额 4 现金

+ (my_listModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;


@end
