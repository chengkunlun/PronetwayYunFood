//
//  paidui_listModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface paidui_listModel : NSObject

@property (nonatomic ,strong)  NSString *sid;//后台生成的sid
@property (nonatomic ,strong) NSString *name;//客桌类型名称
@property (nonatomic ,strong) NSString *groupid;//
@property (nonatomic ,strong) NSString *code;//代号
@property (nonatomic ,strong) NSString *lasttime;//
@property (nonatomic ,strong) NSString *minnum;//最小值
@property (nonatomic ,strong) NSString *maxnum;//最大值
@property (nonatomic ,strong) NSString *totidle;//空闲
@property (nonatomic ,strong) NSString *totque;//排队人数

@property (assign) BOOL selected;//选中状态

+ (paidui_listModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;

@end
