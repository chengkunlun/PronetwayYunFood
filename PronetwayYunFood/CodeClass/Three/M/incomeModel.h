//
//  incomeModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/21.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface incomeModel : NSObject

@property (strong, nonatomic) NSString *createtime;
@property (strong, nonatomic) NSString *orderno;
@property (nonatomic ,strong) NSString *name;//菜品名称
@property (nonatomic ,strong) NSString *imgpath;//图片路径
@property (assign ) NSInteger quantity;//数量
@property (assign ) float price;//单价

+ (incomeModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;

@end
