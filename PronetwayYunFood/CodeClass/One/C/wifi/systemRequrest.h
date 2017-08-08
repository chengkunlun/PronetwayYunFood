//
//  systemRequrest.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/31.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "orderListModel.h"

@protocol systemRequestDelegate <NSObject>

-(void)finarr:(NSMutableArray *)finaArr findic:(NSMutableDictionary *)findic tableidArr:(NSMutableArray *)tableidArr;

-(void)requestisgoon:(BOOL)isYes;

@end

@interface systemRequrest : NSObject
//订单数组
@property (strong, nonatomic) NSMutableArray *orderArr;
//装tableid的数组
@property (strong, nonatomic) NSMutableArray *tabidArr;

//最终的数组
@property (strong, nonatomic) NSMutableArray *finaArr;

//最终的字典
@property (strong, nonatomic) NSMutableDictionary *finaDic;

@property (strong, nonatomic) id<systemRequestDelegate>delegate;

//解析数组
-(void)reloadJosnForgetOrderlist;





@end
