//
//  BluetoothListViewController.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/4.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YunCalssViewController.h"
#import "kezhuoModel.h"
#import "JWBluetoothManage.h"
#import "paiHaoModel.h"
@interface BluetoothListViewController : YunCalssViewController
@property (strong, nonatomic) kezhuoModel *model;
@property (strong, nonatomic) NSMutableArray *SelectgoodsArr;
@property (strong, nonatomic) NSString *Ordernumber;
@property (strong, nonatomic) NSString *allMoney;
@property (strong, nonatomic) NSString *payurl;
@property (strong, nonatomic)JWBluetoothManage *manager;
@property (strong, nonatomic)   NSMutableArray   *deviceArray;  /**< 蓝牙设备个数 */
@property (strong, nonatomic) NSMutableArray *rissArr;

@property (strong, nonatomic) NSString *selectStr;
//客桌管理
@property (strong, nonatomic) NSMutableArray *collectArr;
@property (strong, nonatomic) NSString *placStr;
@property (strong, nonatomic) paiHaoModel *paiHaoModel;

@end
