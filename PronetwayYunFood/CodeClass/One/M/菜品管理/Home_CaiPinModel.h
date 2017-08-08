//
//  Home_CaiPinModel.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/19.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Home_CaiPinModel : NSObject

@property (nonatomic ,strong)  NSString *sid;//菜品id
@property (nonatomic ,strong) NSString *name;//名称
@property (nonatomic ,strong) NSString *storeid;//商铺id
@property (nonatomic ,strong) NSString *price;//价格
@property (nonatomic ,strong)  NSString *vipprice;//vip价格
@property (nonatomic ,strong) NSString *classifyid;//分类的id
@property (nonatomic ,strong) NSString *status;//状态，0表示上架，1表示下架
@property (nonatomic ,strong) NSString *sellcount;//价格
@property (strong, nonatomic) NSString *imgpath;//图片的地址
@property (strong, nonatomic) NSString *headerName;//对应头的名称.
@property (strong, nonatomic) NSIndexPath *indexpah;
@property (nonatomic) NSInteger session;
@property (nonatomic) NSInteger row;



//点餐
@property (nonatomic) NSInteger selectnumber;
@property (strong, nonatomic) NSIndexPath *selectIndexPath;




+ (Home_CaiPinModel *)setUpModelWithDictionary:(NSDictionary *)dictionary;


@end
