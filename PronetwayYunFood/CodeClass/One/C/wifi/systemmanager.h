//
//  systemmanager.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/31.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "systemRequrest.h"
#import "kezhuoModel.h"
#import "orderListModel.h"
@protocol sysmanagerDelegate <NSObject>

//连接蓝牙
-(void)autoShowperical:(CBPeripheral *)perpheral;

//设备已断开连接回调
-(void)disConnectBlock:(CBPeripheral *)perpheral;


@end


@interface systemmanager : NSObject<systemRequestDelegate>

@property (strong, nonatomic) JWBluetoothManage *manage;

@property (strong, nonatomic) kezhuoModel *deskmodel;
//打单
@property (nonatomic, strong) NSMutableArray * dataSource; //设备列表
@property (nonatomic, strong) NSMutableArray * rssisArray; //信号强度 可选择性使用
@property (strong, nonatomic)   NSArray            *goodsArray;  /**< 商品数组 */
@property (assign)  BOOL ConnectedSuccess; //是否连接成功
@property (strong, nonatomic) NSString *payUrl;

@property (strong, nonatomic) NSMutableArray *ordernumberArr;

@property (strong, nonatomic) id<sysmanagerDelegate>delegate;

@property NSTimer *systemTimer;
//是否连接到蓝牙
@property (assign) BOOL isBlueConnected;

//是否发起请求
@property (assign) BOOL isrequest;
//开启定时器
-(void)openTimer:(NSTimeInterval )time;
//关闭定时器
-(void)closeTimr;

//自动重连
-(void)Autoconnect;

//扫描蓝牙
-(void)ScanBluetooth;

//断开蓝牙
-(void)disconnect:(CBPeripheral *)perprial;

//连接蓝牙
-(void)connectPerprial:(CBPeripheral *)perprial;





@end
