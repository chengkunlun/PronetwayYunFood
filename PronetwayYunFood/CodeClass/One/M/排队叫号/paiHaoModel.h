//
//  paiHaoModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/18.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface paiHaoModel : NSObject
@property (nonatomic ,strong)  NSString *num;//wifi名称
@property (nonatomic ,strong) NSString *orderno;//wifi标识符
@property (nonatomic ,strong) NSString *tel;//电话
@property (nonatomic ,strong) NSString *custnum;//就餐人数
@property (strong, nonatomic) NSString *groupid;
@property (strong, nonatomic) NSString *odtabletypeid;
@property (strong, nonatomic) NSString *typecode;
@property (strong, nonatomic) NSString *addtime;

+ (paiHaoModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;


@end
