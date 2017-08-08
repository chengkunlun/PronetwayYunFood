//
//  dianpuModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/24.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dianpuModel : NSObject
@property (nonatomic ,strong) NSString *endtime;//结束时间
@property (nonatomic ,strong) NSString *starttime;//开始时间
@property (nonatomic ,strong) NSString *sid;//单个账户id
@property (nonatomic ,strong) NSString *tel;//电话号码
@property (nonatomic ,strong) NSString *pid;//
@property (nonatomic ,strong) NSString *name;//店铺名称
@property (nonatomic ,strong) NSString *lasttime;//
@property (nonatomic ,strong) NSString *userid;//
@property (nonatomic ,strong) NSString *address;//店铺地址
@property (strong, nonatomic) NSString *username; //营业账号


+ (dianpuModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;

@end
