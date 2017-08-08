//
//  orderListModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/31.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderListModel : NSObject

@property (nonatomic ,strong) NSString *tableid;//客桌id
@property (nonatomic ,strong) NSString *numid;//分区编号
@property (nonatomic ,strong) NSString *zname;//分区名称
@property (nonatomic ,strong) NSString *payurl;//付款url
@property (nonatomic ,strong)  NSString *orderno;//订单号
@property (nonatomic ,strong) NSString *createtime;//
@property (nonatomic ,strong) NSString *money;//
@property (nonatomic ,strong) NSString *dname;//菜品名称
@property (nonatomic ,strong)  NSString *imgpath;//图片地址
@property (nonatomic ,strong) NSString *quantity;//数量
@property (nonatomic ,strong) NSString *price;//价格

+ (orderListModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;



@end
