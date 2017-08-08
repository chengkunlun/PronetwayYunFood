//
//  PronetwayYunFoodHandle.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/8.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PronetwayYunFoodHandle : NSObject

+ (PronetwayYunFoodHandle *)shareHandle;
@property (nonatomic) BOOL shuju_isSelect;

@property (strong, nonatomic) NSString *gotoweher;

//判断是否显示减少按钮
@property (nonatomic) BOOL showReduceBtn;

@property (strong, nonatomic) NSIndexPath *tableindex;
@property (strong, nonatomic) NSIndexPath *Incometableindex;

@property (assign) BOOL isToreadjosn;

@property (strong, nonatomic) NSString *caiPinRight;
@property (strong, nonatomic) NSString *dianpuright;


@property (assign) BOOL sjselected;

//下单 -- 下单成功,打印失败,订单状态置回失败!
@property (strong, nonatomic) NSString *Ordertype;

//后台打单,蓝牙的连接状态
//@property (assign)

@property (assign) BOOL timeirisOpen;



@end
