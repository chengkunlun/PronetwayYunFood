//
//  kezhuoModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/26.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface kezhuoModel : NSObject

@property (nonatomic ,strong) NSString *sid;//客桌id
@property (nonatomic ,strong) NSString *numid;//编号
@property (nonatomic ,strong) NSString *groupid;//门店id
@property (nonatomic ,strong) NSString *seatnum;//座位数
@property (nonatomic ,strong) NSString *zoneid;//分区id
@property (nonatomic ,strong) NSString *zonename;//分区名称
@property (nonatomic ,strong) NSString *paystatus;// 0 未支付 1支付
@property (nonatomic ,strong) NSString *lasttime;//进度
@property (strong, nonatomic) NSString *status; //0 空闲 1 被占
@property (strong, nonatomic) NSString *typeid;
@property (assign) BOOL selected;

+ (kezhuoModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;


@end
