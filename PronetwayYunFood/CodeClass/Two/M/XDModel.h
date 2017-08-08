//
//  XDModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/12.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDModel : NSObject

@property (nonatomic ,strong) NSString *price;//单价
@property (nonatomic ,strong) NSString *quantity;//数量
@property (nonatomic ,strong) NSString *disheid;//菜品id
@property (nonatomic ,strong) NSString *dishname;//菜品名称
@property (strong, nonatomic) NSString *imgpath;//菜品图片路径

+ (XDModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;


@end
