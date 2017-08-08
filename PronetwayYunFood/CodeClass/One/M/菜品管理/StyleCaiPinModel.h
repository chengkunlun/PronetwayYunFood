//
//  StyleCaiPinModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/27.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StyleCaiPinModel : NSObject

@property (nonatomic ,strong) NSString *sid;//类型的唯一id
@property (nonatomic ,strong) NSString *name;//类型名称
@property (nonatomic ,strong) NSString *storeid;//商店id
@property (nonatomic ,strong) NSString *orderid;//类型的顺序
@property (strong, nonatomic) NSString *headerLocation;//在头数组中的位置

+ (StyleCaiPinModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;


@end
