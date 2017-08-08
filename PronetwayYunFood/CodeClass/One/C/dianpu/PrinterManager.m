//
//  PrinterManager.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/18.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "PrinterManager.h"

@implementation PrinterManager

//下单
+ (JWPrinter *)getPrinter:(kezhuoModel *)model Ordernumber:(NSString *)Ordernumber goodsArray:(NSArray *)goodsArray  payurl:(NSString *)payurl allmoney:(NSString *)allmoney type:(NSString *)type
{
        JWPrinter *printer = [[JWPrinter alloc] init];
        NSString *title = [UserDefaults objectForKeyStr:kdianpuName];
        NSString *str1 = [NSString stringWithFormat:@"桌号 :%@-%@",model.zonename,model.numid];
        [printer appendText:title alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
        [printer appendText:str1 alignment:HLTextAlignmentCenter];
        // 条形码
        //[printer appendBarCodeWithInfo:[UserDefaults objectForKeyStr:ksid]];
        //[printer appendSeperatorLine];
        //空格
        [printer appendNewLine];
        
        [printer appendTitle:@"时间:" value:[DateUtil getCurrentTimeFormiao] valueOffset:150];
        [printer appendTitle:@"订单:" value:Ordernumber  valueOffset:150];
        [printer appendText:[NSString stringWithFormat:@"地址:%@",[UserDefaults objectForKeyStr:kadress]] alignment:HLTextAlignmentLeft];
        
        [printer appendSeperatorLine];
        
        [printer appendLeftText:@"商品" middleText:@"数量" rightText:@"单价" isTitle:YES];
    
    [printer appendNewLine];

        for ( int i = 0;i<goodsArray.count;i++) {
            NSMutableArray *arr = goodsArray[i];
            
            NSMutableArray *mutilArr = [NSMutableArray array];
            
            if (i == 0) {
                if ([type isEqualToString:@"system"]) {// 后台打单
                    
                    mutilArr = [self systemArr:arr];

                }else {
                
                    mutilArr = [self goodsArr:arr];//下单打单

                }
                
                for (NSDictionary *dict in mutilArr) {
                    [printer appendLeftText:dict[@"name"] middleText:dict[@"amount"] rightText:dict[@"price"] isTitle:NO];
                    //total += [dict[@"price"] floatValue] * [dict[@"amount"] intValue];
                }
                [printer appendSeperatorLine];
                
            }else {
                
                [printer appendText:@"加菜" alignment:(HLTextAlignmentCenter)];
                
                if ([type isEqualToString:@"system"]) {//系统打单
                    mutilArr = [self systemArr:arr];
                    
                }else {//下单打单
                    
                    mutilArr = [self goodsArr:arr];
                    
                }
                for (NSDictionary *dict in mutilArr) {
                    
                    [printer appendLeftText:dict[@"name"] middleText:dict[@"amount"] rightText:dict[@"price"] isTitle:NO];
                    //total += [dict[@"price"] floatValue] * [dict[@"amount"] intValue];
                }
                
                [printer appendSeperatorLine];
                
            }
        }
        // NSString *totalStr = [NSString stringWithFormat:@"%.2f",total];
        
        // [printer appendTitle:@"总计:" value:[self AllPrice:self.allcaiArr]];
        [printer appendText:[NSString stringWithFormat:@"%@",allmoney] alignment:2];
        //    [printer appendTitle:@"实收:" value:@"100.00"];
        //    NSString *leftStr = [NSString stringWithFormat:@"%.2f",100.00 - total];
        //    [printer appendTitle:@"找零:" value:leftStr];
        //
        [printer appendNewLine];
        // 二维码
        [printer appendText:@"扫我付款" alignment:HLTextAlignmentCenter];
        [printer appendNewLine];

        if (Ordernumber!=nil) {
            [printer appendQRCodeWithInfo:payurl size:8];
        }
        
        [printer appendText:@"温馨提示: 请随身携带好贵重物品,谨防遗落!" alignment:HLTextAlignmentCenter];
        
        [printer appendNewLine];
        
        [printer appendText:@"谢谢惠顾,欢迎下次光临!" alignment:HLTextAlignmentCenter];
        
        [printer appendSeperatorLine];
        
        return printer;
}

//构造加载的数据
+(NSMutableArray *)goodsArr:(NSMutableArray *)goodsArr{
    
    NSMutableArray *goods = [NSMutableArray array];
    
    [goodsArr enumerateObjectsUsingBlock:^(incomeModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dict = @{@"name":model.name,@"amount":[NSString stringWithFormat:@"x %ld",model.quantity],@"price":[NSString stringWithFormat:@"%0.2f",model.price/100]};
        [goods addObject:dict];
        
    } ];
    
    DLog(@"goods --- %@",goods);
    
    return goods;
}

//构造加载数据
+(NSMutableArray *)systemArr:(NSMutableArray *)systemArr {
    
    NSMutableArray *goods = [NSMutableArray array];
    [systemArr enumerateObjectsUsingBlock:^(orderListModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dict = @{@"name":model.dname,@"amount":[NSString stringWithFormat:@"x %@",model.quantity],@"price":[NSString stringWithFormat:@"%0.2f",[model.price floatValue]/100]};
        [goods addObject:dict];
        
    } ];
    
    DLog(@"goods --- %@",goods);
    
    return goods;
    
}



+ (JWPrinter *)deskManagerPrinter:(kezhuoModel *)model payurl:(NSString *)payurl
{
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *title = [UserDefaults objectForKeyStr:kdianpuName];
NSString *str1 = [NSString stringWithFormat:@"桌号 :%@ %@",[model.zonename substringToIndex:1],model.numid];
    [printer appendText:title alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    
    [printer appendSeperatorLine];
    [printer appendSeperatorLine];
    
    // 二维码
    
    if (payurl!=nil) {
        
        [printer appendQRCodeWithInfo:payurl size:8];
        
    }
    
    [printer appendSeperatorLine];
    [printer appendSeperatorLine];
    
    [printer appendText:@"请随身携带好贵重物品,谨防遗落!" alignment:1];
    
    
    return printer;
}

+(JWPrinter *)paiHaoModel:(paiHaoModel *)model {

    JWPrinter *printer = [[JWPrinter alloc] init];

    
    NSString *str1 = [NSString stringWithFormat:@"欢迎光顾 %@",[UserDefaults objectForKeyStr:kdianpuName]];
    
    NSString *str2 = [NSString stringWithFormat:@"排队号: %@00%@",model.typecode,model.orderno];
    //前面剩余
    NSString *str3 = [NSString stringWithFormat:@"剩余 %ld 桌排队",[model.num integerValue]-1];
    //时间
    NSString *str4 = [NSString stringWithFormat:@"%@",[DateUtil timestampToDateTimeStr:[model.addtime longLongValue]]];

    [printer appendSeperatorLine];

    [printer appendText:str1 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleSmalle];
    [printer appendNewLine];
//排队号
    [printer appendText:str2 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
    [printer appendNewLine];

    [printer appendText:str3 alignment:HLTextAlignmentCenter];
    
    [printer appendNewLine];

    [printer appendText:str4 alignment:HLTextAlignmentCenter];
    
    [printer appendNewLine];

    [printer appendNewLine];

    [printer appendSeperatorLine];
    return printer;
}

+ (JWPrinter *)desk_changeManagerPrinter:(kezhuoModel *)model payUrl:(NSString *)payUrl
{
    
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *title = [UserDefaults objectForKeyStr:kdianpuName];
    NSString *str1 = [NSString stringWithFormat:@"客桌 :%@ %@",[model.zonename substringToIndex :1],model.numid];
    [printer appendText:title alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
    [printer appendText:str1 alignment:HLTextAlignmentCenter fontSize:0x9];
    
    [printer appendNewLine];
    
    // 二维码
    if (payUrl!=nil) {
        
      [printer appendQRCodeWithInfo:payUrl size:8];
                
    }
    [printer appendNewLine];
    [printer appendText:@"请随身携带好贵重物品,谨防遗落!" alignment:1];
    
    [printer appendNewLine];

    
    return printer;
}



@end
