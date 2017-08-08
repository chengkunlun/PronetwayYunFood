//
//  CaiPsticsModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/27.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaiPsticsModel : NSObject

@property (nonatomic ,strong)  NSString *name;//菜品名称
@property (nonatomic ,strong) NSString *quantitys;//销售量
@property (nonatomic ,strong) NSString *allmoneys;//销售额

+ (CaiPsticsModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;



@end
