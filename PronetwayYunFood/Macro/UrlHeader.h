//
//  UrlHeader.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/5.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#ifndef UrlHeader_h
#define UrlHeader_h

//http://192.168.20.154:8006/buffet/index.html#/?waitline=138409049010:40:58

//http://192.168.20.154:8006/buffet/index.html#/?ordercode=C4E85FA8FFE4BA0510CDD420B1B830CC

#define kIpandPort  @"http://180.169.1.201:8017" //@"http://192.168.20.154:8090" 
#define kIP @"http://180.169.1.201:8017"

#pragma mark ---------------- 登录注册 ------------------
//获取验证码
#define kgetCode1 @"/pronline/Msg?FunName@odBusinessAuth&telno="
#define kgetCode2 @"&action=send"
#define kgetCode3 @"&type=rsend"

//效验验证码/手机号登录
#define kcheckCode1 @"/pronline/Msg?FunName@odBusinessAuth&telno="
#define kcheckCode2 @"&action=get&checkno="
#define kcheckCode3 @"&type=rsend"
#define kcheckCode4 @"&type=lsend"

//注册
#define kregister1 @"/pronline/Msg?FunName@odBusinessAuth"
#define kregister2 @"&username="
#define kregister3 @"&password="
#define kregister4 @"&utype="//0 是老板
#define kregister5 @"&action=signup"
#define kregister6 @"&id="

//登录
#define klogin1 @"/pronline/Msg?FunName@odBusinessAuth&username="
#define klogin2 @"&password="
#define klogin3 @"&action=login"

#define kphoneLogin1 @""
#define kphoneLogin2 @""
#define kphoneLogin3 @""


#pragma mark --------------- 数据分析 ------------------
//营业统计
#define kyinye1 @"/pronline/Msg?FunName@orderOrderCount&pid="
#define kyinye2 @"&startTime="
#define kyinye3 @"&endTime="
#define kyinye4 @"&type="
#define kyinye5 @"&start="
#define kyinye6 @"&limit="
//菜品统计
#define kcaiPStatistics1 @"/pronline/Msg?FunName@orderDishesCount&pid="
#define kcaiPStatistics2 @""
#define kcaiPStatistics3 @""
#define kcaiPStatistics4 @""
#define kcaiPStatistics5 @""



#pragma mark ---------------- 店铺设置 ------------------
//添加店铺
#define kadddianpu1 @"/pronline/Msg?FunName@orderEditOdstore&operate=add&name="
#define kadddianpu2 @"&tel="
#define kadddianpu3 @"&starttime="
#define kadddianpu4 @"&endtime="
#define kadddianpu5 @"&address="
#define kadddianpu6 @"&username="
#define kadddianpu7 @"&password="
#define kadddianpu8 @"&pid="

//http://192.168.20.154:8006/pronline/Msg?FunName@orderEditOdstore&operate=&pid=90fea347-9d65-44b6-ad9e-dfe54ac0d028
//获取店铺信息列表信息
#define kgetAlldianpu1 @"/pronline/Msg?FunName@orderEditOdstore&operate="
#define kgetAlldianpu4 @"&pid="
#define kgetAlldianpu5 @"&groupid="
#define kgetAlldianpu2 @"&start="
#define kgetAlldianpu3 @"&limt="

//修改店铺信息
#define kchangeadddianpu1 @"/pronline/Msg?FunName@orderEditOdstore&operate=update&name="
#define kchangeadddianpu2 @"&tel="
#define kchangeadddianpu3 @"&starttime="
#define kchangeadddianpu4 @"&endtime="
#define kchangeadddianpu5 @"&address="
#define kchangeadddianpu6 @"&username="
#define kchangeadddianpu7 @"&password="

//客桌管理

//添加客桌分区
#define kaddkezuofenqu1 @"/pronline/Msg?FunName@orderEditOdzone&operate=add&name="
#define kaddkezuofenqu2 @"&groupid="
#define kaddkezuofenqu3 @"&znumber=0"
//修改客桌分区
#define kchangekezuofenqu1 @"/pronline/Msg?FunName@orderEditOdzone&operate=update&name="
#define kchangekezuofenqu2 @"&sid="
#define kchangekezuofenqu3 @"&groupid="
#define kchangekezuofenqu4 @"&oldzoneid="
#define kchangekezuofenqu5 @"&znumber="
//删除客桌分区/批量删除
#define kdeletkezhuofenqu1 @"/pronline/Msg?FunName@orderEditOdzone&operate=delete&sid="
#define kdeletkezhuofenqu2 @"&groupid="

//查询
#define kquerykezhuofenqu1 @"/pronline/Msg?FunName@orderEditOdzone&&groupid="
#define kquerykezhuofenqu2 @"&keywords="

//排序
#define kFenqupaixu1 @"/pronline/Msg?FunName@orderEditOdzone&operate=setnu&numbers="
#define kFenqupaixu2 @"&groupid="

//客桌------
//查询
#define kCXkezhuo1 @"/pronline/Msg?FunName@orderEditOdtable&groupid="
#define kCXkezhuo2 @"&keywords="

//根据分区查找
//http://192.168.20.154:8006/pronline/Msg?FunName@orderEditOdtable&qzoneid=12&storeid=2
#define kCXByzoneid1 @"/pronline/Msg?FunName@orderEditOdtable&qzoneid="
#define kCXByzoneid2 @"&groupid="
#define kCXBkeywords @"&keywords="

//添加 -- 客桌
#define kTJkezhuo1 @"/pronline/Msg?FunName@orderEditOdtable&operate=add&numid="
#define kTJkezhuo2 @"&groupid="
#define kTJkezhuo3 @"&seatnum="
#define kTJkezhuo4 @"&zoneid="

//批量添加客桌
#define kaddAllkehzuo @"/pronline/Msg?FunName@orderEditOdtable&operate=padd"
#define kaddAllkehzuo1 @"&snid="
#define kaddAllkehzuo2 @"&enid="

//修改--客桌
#define kXGkehzuo1 @"/pronline/Msg?FunName@orderEditOdtable&operate=update&numid="
#define kXGkehzuo2 @"&groupid="
#define kXGkehzuo3 @"&seatnum="
#define kXGkehzuo4 @"&zoneid="
#define kXGkehzuo5 @"&sid="
#define kXGkehzuo6 @"oldnumid="

//删除/批量删除
#define kdeletkezhuo1 @"/pronline/Msg?FunName@orderEditOdtable&operate=delete&sid="
#define kdeletkezhuo2 @"&groupid="

//客桌管理打印二维码
#define kkezhuoCode1 @"/pronline/Msg?FunName@orderGetOdQr&groupid="
#define kkezhuoCode2 @"&tableid="
#define kkezhuoCode3 @"/buffet/index.html#/?ordercode="


//修改子账户密码
#define kchangeuserPsssword1 @"/pronline/Msg?FunName@odGpUpdatePassword&userid="
#define kchangeuserPsssword2 @"&username="
#define kchangeuserPsssword3 @"&oldpassword="
#define kchangeuserPsssword4 @"&newpassword="


#pragma mark ---------------- 菜品管理 ------------------
//添加菜品种类
#define kaddCaiPinstyle1 @"/pronline/Msg?FunName@dishType&name="
#define kaddCaiPinstyle2 @"&groupid="
#define kaddCaiPinstyle3 @"&action=add"

//修改菜品种类
#define kChangeCaipinstyle1 @"/pronline/Msg?FunName@dishType&name="
#define kChangeCaipinstyle2 @"&groupid="
#define kChangeCaipinstyle3 @"&orderid="
#define kChangeCaipinstyle4 @"&action=edit&sid="

//删除菜品种类
#define kdeleteCaipinstyle1 @"/pronline/Msg?FunName@dishType&action=del&groupid="
#define kdeleteCaipinstyle2 @"&sid="

//菜品种类排序
#define kpaixustylecaipin1 @"/pronline/Msg?FunName@dishType&groupid="
#define kpaixustylecaipin2 @"&orderarr="
#define kpaixustylecaipin3 @"&action=edit"

//查询菜品种类
#define kInquireStyle1 @"/pronline/Msg?FunName@dishType&groupid="

// ---------------------- 菜品 ----------------------
//添加菜品
#define kAddcaipin @"/pronline/Msg?FunName@dishesManage&action="
#define kAddcaipin1 @"&name="
#define kAddcaipin2 @"&groupid="
#define kAddcaipin3 @"&price="
#define kAddcaipin4 @"&vipprice="
#define kAddcaipin5 @"&classifyid="
#define kAddcaipin6 @"&status="
#define kAddcaipin7 @"&keyword="
#define kAddcaipin8 @"&imgpath="

//修改菜品
#define kchangeCaipin1 @"/pronline/Msg?FunName@dishesManage&action=edit&sid="
#define kchangeCaipin2 @"&groupid="
#define kchangeCaipin3 @"&name="
#define kchangeCaipin4 @"&price="
#define kchangeCaipin5 @"&vipprice="
#define kchangeCaipin6 @"&classifyid="
#define kchangeCaipin7 @"&status="
#define kchangeCaipin8 @"&imgpath="

//删除菜品
#define kdeletCaiPin1 @"/pronline/Msg?FunName@dishesManage&action=del&sid="
#define kdeletCaiPin2 @"&groupid="

//查询菜品
#define kCXcaipin @"/pronline/Msg?FunName@dishesManage&groupid="
#define kCXcaipin1 @"&keyword="

//给菜品种类排序
#define kPXCaiPin @"/pronline/Msg?FunName@dishType&action=edit&groupid="
#define kPXCaiPin1 @"&orderarr="

#pragma mark ------------------------ 点餐 ----------------------
#define kdc_xd1 @"/pronline/Msg?FunName@orderManage&action=add&status=0&endstatus=0&groupid="
#define kdc_xd2 @"&tableid="
#define kdc_xd3 @"&money="
#define kdc_xd4 @"&orderno="
#define kdc_xd5 @"&pid="
#define kdc_xd6 @"&content="

//从c端获取数据,获取所有的数据
#define kgetAllLisstcai @"/pronline/Msg?FunName@ordercart&groupid="
#define kgetAllLisstcai1 @"&tableid="


//批量添加
#define kadds1 @"/pronline/Msg?FunName@ordercart&action=adds&groupid="
#define kadds2 @"&tableid="
#define kadds3 @"&content="

//打印订单 -- 修改订单状态
#define kchangeorderDYStatus1 @"/pronline/Msg?FunName@odUpPrintStatus&orderno="
#define kchangeorderDYStatus2 @"&type="




#pragma mark ------ 排队叫号 ------
//查询
#define kpaidui_getlist @"/pronline/Msg?FunName=odtabletype&groupid="

//增加
#define kpaidui_add1 @"/pronline/Msg?FunName=odtabletype&action=add&code="
#define kpaidui_add2 @"&name="
#define kpaidui_add3 @"&min="
#define kpaidui_add4 @"&max="
#define kpaidui_add5 @"&groupid="

//更新
#define kpaidui_update1 @"/pronline/Msg?FunName=odtabletype&action=update&groupid="


//删除
#define kpaidui_delet1 @"/pronline/Msg?FunName=odtabletype&action=del&sid="
#define kpaidui_delet2 @"&code="
#define kpaidui_delet3 @"&groupid="

//排号新增
#define kpai_add1 @"/pronline/Msg?FunName=odarrange&action=add&groupid="
#define kpai_add2 @"&count="
#define kpai_add3 @"&telno="

//叫号获取客桌空闲状态
#define kpaidui_leisure @"/pronline/Msg?FunName=odarrange&action=show&groupid="

//叫号获取get
#define kjiaohGet @"/pronline/Msg?FunName=odarrange&action=get&groupid="
#define kjiaohGet1 @"&type="
//叫号下一桌 删除
#define kjiaohDel1 @"/pronline/Msg?FunName=odarrange&action=del&groupid="
#define kjiaohDel2 @"&type="
#define kjiaohDel3 @"&orderno="


#pragma mark ------ 收银 ------
//获取列表
#define kincome_getlist1 @"/pronline/Msg?FunName@orderGetOdDetail&tableid="
#define kincome_getlist2 @"&groupid="
#define kincome_getlist3 @"&pid="


//创建支付订单
#define kincome_creatOrder1 @"/pronline/Msg?FunName@orderCrOdPayls"
#define kincome_creatOrder4 @"&tableid="
#define kincome_creatOrder2 @"&groupid="
#define kincome_creatOrder3 @"&type="
//下单创建预支付订单
#define kXD_creatOrder @"/pronline/Msg?FunName@orderCrOdPaylsQr"


//查询订单是否支付
#define kincome_OrderStatus1 @"/pronline/Msg?FunName@orderGetOdStatus&tableid="
#define kincome_OrderStatus2 @"&groupid="

//订单条码支付
#define ktmpay1 @"/pronline/Msg?FunName@ictAlipayapiBc&orderno="
#define ktmpay2 @"&auth_code="

//结束用餐
#define kfinishMeals1 @"/pronline/Msg?FunName@odFinishMeal&tableid="
#define kfinishMeals12 @"&groupid="

#pragma mark ----- 我的会员 ------

//充值营销添加
#define kHuiyuan_Addchongzhi1 @"/pronline/Msg?FunName@orderQueryAddMoney&operate=add&recharge="
#define kHuiyuan_Addchongzhi2 @"&give="
#define kHuiyuan_Addchongzhi3 @"&total="
#define kHuiyuan_Addchongzhi4 @"&startdate="
#define kHuiyuan_Addchongzhi5 @"&enddate="
#define kHuiyuan_Addchongzhi6 @"&status="
#define kHuiyuan_Addchongzhi7 @"&groupid="

//充值营销获取当前所有
#define kHuiyuan_getList1 @"/pronline/Msg?FunName@orderQueryAddMoney"
#define kHuiyuan_getList2 @"&groupid="

//充值营销修改
#define kHuiyuan_changeC1 @"/pronline/Msg?FunName@ModfyOdcampaign&sid="
#define kHuiyuan_changeC2 @"&total="
#define kHuiyuan_changeC3 @"&startdate="
#define kHuiyuan_changeC4 @"&enddate="

#pragma mark ----- 我的账户 -----
//获取账户信息--营业信息
#define kGetUserList @"/pronline/Msg?FunName@orderGetOdInfo"
#define kGetUserList1 @"&startTime="
#define kGetUserList2 @"&endTime="
#define kGetUserList3 @"&pid="
#define kGetUserList4 @"&type="//type：查询类型，all为全部，cash为现金支付，online为线上支付
#define  kGetUserList5 @"&groupid="
#define  kGetUserList6 @"&pid="
#define kGetUserList7 @"&start="
#define kGetUserList8 @"&limit="

//根据order获取订单详细
#define kgetUserOrderList @"/pronline/Msg?FunName@odGetOdDtByOrderno&orderno="

//获取充值信息
#define kgetUserPayinfo @"/pronline/Msg?FunName@orderGetRcInfo&pid="

//我的账户获取全部信息
#define kgetUserAllinfo @"/pronline/Msg?FunName@odGetAccountInfo&pid="

//系统设置,后台打印订单
#define ksystemgetorderlist @"/pronline/Msg?FunName@odGetPrintList&groupid="


//#define kgetmycount @"/pronline/Msg?FunName@orderGetOdDetail&orderno="




#endif /* UrlHeader_h */
