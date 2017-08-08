//
//  PrinterManager.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/18.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "paiHaoModel.h"
#import "incomeModel.h"
@interface PrinterManager : NSObject

+ (JWPrinter *)getPrinter:(kezhuoModel *)model Ordernumber:(NSString *)Ordernumber goodsArray:(NSArray *)goodsArray  payurl:(NSString *)payurl allmoney:(NSString *)allmoney type:(NSString *)type;

+ (JWPrinter *)deskManagerPrinter:(kezhuoModel *)model payurl:(NSString *)payurl;

+(JWPrinter *)paiHaoModel:(paiHaoModel *)model;

+ (JWPrinter *)desk_changeManagerPrinter:(kezhuoModel *)model payUrl:(NSString *)payUrl;
@end
