//
//  NetworkManger.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/26.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "kezhuofenquModel.h"
#import "paidui_listModel.h"
@interface NetworkManger : NSObject


typedef void(^NetManager)(NSMutableArray *);
@property (nonatomic, copy) NetManager blocknetArr;

@property (strong, nonatomic) dispatch_block_t Addkezuofenqusuccessblock;
@property (strong, nonatomic) dispatch_block_t Failblock;


//添加客桌分区
-(void)reloadJosnForaddkezhuofenqu:(NSString *)input;

//修改客桌分区
-(void)reloadJosnForchangekezhuofenqu:(kezhuofenquModel *)model input:(NSString *)input;

//删除客桌分区
-(void)deletkezhuofenqu:(kezhuofenquModel *)model;

//批量删除客桌分区
-(void)deletepf:(NSString *)sid;


//添加桌位
-(void)addkezhuoNumbers:(NSString *)deskNumbers people:(NSString *)people fenqu:(NSString *)fenqu model:(kezhuofenquModel *)model;

//批量添加桌位
-(void)pddkezhuoNumberspeople:(NSString *)people  model:(kezhuofenquModel *)model seid:(NSString *)seid enid:(NSString *)enid;

//给客桌分区排序
-(void)paixuFenqu:(NSString *)plateStr;

//修改客桌
-(void)changeKezhuo:(NSString *)zoneid seatnum:(NSString *)seatnum numid:(NSString *)numbid  sid:(NSString *)sid oldnumid:(NSString *)oldnumid oldzoneid:(NSString *)oldzoneid;

//删除客桌
-(void)deletekezuoaAll:(NSString *)sid;



#pragma mark ---- 添加菜品种类 -----
-(void)addCaipinstyle:(NSString *)CaipinStylestr;//添加菜品种类

-(void)changeCaipinStyle:(StyleCaiPinModel *)caipinStyle name:(NSString *)name;//修改菜品种类

-(void)deleteCaiStyle:(NSString *)setyleSid;//删除菜品种类

-(void)addCaipin:(NSString *)caiPinName price:(NSString *)price vipPrice:(NSString *)vipPrice stySid:(NSString *)stySid status:(NSString  *)status imagepath:(NSString *)imagepath action:(NSString *)action sid:(NSString *)sid; //新增菜品和修改菜品;
//给菜品排序
-(void)paixuForsort:(NSString *)sort;

//删除菜品
-(void)delet:(NSString *)caiSid;


#pragma mark ----- 购物车 -----
-(void)addsFood:(NSString *)groupid tableid:(NSString *)tableid content:(NSString *)content;

#pragma  mark --------排队叫号 ---------
//新增
-(void)paiduijiaohao:(NSString *)code name:(NSString *)name min:(NSString *)min max:(NSString *)max;

//删除
-(void)deletepaiduilist:( paidui_listModel *)model;

//排号新增
-(void)paiHaoadd:(NSString *)tel num:(NSString *)num;

//叫号更新
-(void)paiduiupdate;

#pragma mark -------- 我的会员 --------

//充值营销增加
-(void)memberPayAddrecharge:(NSString *)recharge give:(NSString *)give total:(NSString *)total startdate:(NSString *)startdate enddate:(NSString *)enddate status:(NSString *)status;
#pragma  mark --- 系统设置 ---
//打单
-(void)reloadOrderStatus:(NSString *)orderno type:(NSString *)type;

@end
