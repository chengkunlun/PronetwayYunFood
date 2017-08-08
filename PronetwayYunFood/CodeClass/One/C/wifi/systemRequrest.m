//
//  systemRequrest.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/31.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "systemRequrest.h"

@implementation systemRequrest

//订单数组
-(NSMutableArray *)orderArr {

    if (!_orderArr) {
        _orderArr = [NSMutableArray array];
    }
    return _orderArr;
}
//tableid数组
-(NSMutableArray *)tabidArr {
    
    if (!_tabidArr) {
        _tabidArr = [NSMutableArray array];
    }
    return _tabidArr;
}
//最终数组
-(NSMutableArray *)finaArr {
    
    if (!_finaArr) {
        _finaArr = [NSMutableArray array];
    }
    return _finaArr;
}

-(void)reloadJosnForgetOrderlist {

    NSString *url = [NSString stringWithFormat:@"%@%@%@",kIpandPort,ksystemgetorderlist,[UserDefaults objectForKeyStr:ksid]];
    DLog(@"后台获取打印订单 %@",url);
    
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        DLog(@"获取打单 %@",dic);
        
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            NSArray *arr = dic[@"eimdata"];
            
            if (arr.count == 0) {
                
                if (_delegate && [_delegate respondsToSelector:@selector(requestisgoon:)]) {
                    [_delegate requestisgoon:YES];
                }
                
                DLog(@"-- 后台打单无数据 --");
                return ;
            }
            
            [self.orderArr removeAllObjects];
            [self.tabidArr removeAllObjects];
            [arr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                orderListModel *model = [orderListModel setUpModelWithDictionary:dict];
                
                [self.orderArr addObject:model];

                //把相同的tableid放在一起
                [self.tabidArr addObject:model.tableid];
                
            }];
            
            DLog(@"tableid count is --> %ld",self.tabidArr.count);
            //相同的tabid的数组放在一起
            NSMutableArray *mutilArr = [PaidateTools systemorderListArrBytabid:self.orderArr];
            
            //遍历mutilarr数组.然后在把相同的数组放在一起
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [mutilArr enumerateObjectsUsingBlock:^(NSArray *tabildarr, NSUInteger idx, BOOL * _Nonnull stop) {
                
                orderListModel *model = tabildarr[0];
                NSString *key = model.tableid;
                
                NSMutableArray *ordernumarr = [NSMutableArray array];
                //相同的orderid的数组放在一起
                ordernumarr =  [PaidateTools systemorderListArrByOrderNumber:(NSMutableArray *)tabildarr];
                
                //根据字典里面cretime 做个排序-- 从小到大 即 : 小的先下单 ,大的都是加菜!
                [PaidateTools expandfromSmalltoBig:ordernumarr];

                [dict setObject:ordernumarr forKey:key];
                
                [self.finaArr addObject:ordernumarr];
            }];
            
            _finaDic = dict;
            DLog(@"最终的数组 ---> %@",self.finaArr);
            DLog(@"拼接后的字典 %@",_finaDic);
            //装tableid的数组除重
            self.tabidArr = [self RemoveRepetitionArr:self.tabidArr];
            
            if (_delegate && [_delegate respondsToSelector:@selector(finarr:findic:tableidArr:)]) {
                
                [_delegate finarr:self.orderArr findic:self.finaDic tableidArr:self.tabidArr];
                
            }
        }
    } failure:^(NSError *error) {
        
        
    }];
    
}
//除数组的重复元素 -- 之后的顺序会打乱
-(NSMutableArray *)RemoveRepetitionArr:(NSMutableArray *)RepetitionArr {
    NSArray *arr = [NSArray array];
    
   arr = [RepetitionArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
    
    DLog(@"%@",arr);
    
    return (NSMutableArray *)arr;
}


@end
