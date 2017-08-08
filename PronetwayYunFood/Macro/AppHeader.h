//
//  AppHeader.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/5.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#ifndef AppHeader_h
#define AppHeader_h
//自定义打印
#ifdef DEBUG
#define DLog(...) NSLog(@"%s\n %@\n\n", __func__, [NSString stringWithFormat:__VA_ARGS__])
#else
#endif

//仿retain
#define WeakType(type)               __weak typeof(type)weak##type = type

//坐标
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kBounds [UIScreen mainScreen].bounds
#define newKwith (kWidth/375)
#define newKhight (kHeight/667)
#define kTabBarH        49.0f*newKhight
#define kStatusBarH     20.0f*newKhight
#define kNavigationBarH 44.0f*newKhight
#define kNavBarHAndStaBarH 64.0f*newKhight

#define Success

//颜色
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define kClearColor [UIColor clearColor]
#define kWhiteColor [UIColor whiteColor]
#define Theme_Color_Red  RGB(231,56,55)
#define Theme_Color_Pink RGB(255,83,123)
#define kCbgColor RGB(241, 241, 241)
#define kGreenColor RGB(124, 174, 23)
#define kRedColor   RGB(234, 83, 111)
#define kBlueColor RGB(70, 176, 225)
#define kyellowcolor RGB(245,153,0)
#define kpurplecolor RGB(128,65,146)
#define ksearchBarCancelTextColor RGB(124, 174, 23)
#define ksearchBarCancelTextFont 15




#define Theme_Color_Orange RGB(255,178,148)
#define Theme_Color_Peach RGB(253,184,202)
#define kblackColor [UIColor blackColor]

#define Theme_NavColor   RGB(255,255,255)

#define Theme_TextColor RGB(55,65,75)  //
#define ViewController_BackGround [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0]//视图控制器背景颜色

//导航栏颜色
#define kNavigationBarBg  RGB(206,8,2) //#ce0802
#define KUIScreenHeight [UIScreen mainScreen].bounds.size.height

//字体
#define kFont(float) [UIFont systemFontOfSize:float];
#define kBodlFont(CGFloat) [UIFont boldSystemFontOfSize:(CGFloat)]//加粗
#define Nav_Back_Font_M [UIFont systemFontOfSize:14]

//tag值
#define kYun_order_XD_jian 1000
#define kYun_order_XD_jia 2000
#define kYun_home_addCaiT 3000
#define kYun_dianpu_kezuoT 4000

#define kYun_dianpu_adddianpu 5000
#define kYun_dianpu_deleteTab 6000
#define kYun_caipin_changeCaipintag 7000
#define kYun_dc_searchtabbtnTag 8000
#define kYun_huiyuanchongzhiTag 9000
#define kYun_huiyuandetailTag 9100

#define ACCOUNT_MAX_CHARS 3

#define NUMBERS @"0123456789"

//通知
#define kNotication [NSNotificationCenter defaultCenter]
#define kinformSystem @"informsystem"
#define ksystemconnectedsuccess  @"systemconnectSuccess"

//key值

#define kloginStatuekey @"kloginstatue" //登录
#define kdianpuSelectid @"dianpuSelectid"//记录选中店铺的id
#define kpid @"kpid"
#define ksid @"ksid"
#define kutype @"kutype"
#define kuserid @"userid"
#define kadress @"kadress"
#define kdianpuName @"kdianpuName"
#define kperid @"perid"
#define kdianputel @"dianputel"
#define kshowMengbanHome @"showMengbanHome"
#define kshowdesk @"showdesk"
#define kshowDC @"showDC"
#define kshowSY @"showSY"
#define kshowPD @"showPD"
#define kshowDMhome @"showDMhome"
#define kshowkezhuomanagerfenqu @"showkezhuomanager"
#define kshowdeskManager @"showdeskmanager"
#define kshowmy @"showmy"
#define kshowSYHome @"showSYHome"
#define kshowhyPay @"showhuiyanPay"

#define kshowCai @"showCai"
#define kshowCaimutilMode @"showCaimutilModep"

#define kshowCaiPstyle @"showcaiPstyle"
#define kshowCaimutilStyle @"showCaimutilStyle"

#define ksavebackground @"ksavebackground"



//图片
#define kimage(Name) [UIImage imageNamed:Name]
//读取本地图片
#define kLOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]] //据说这种性能高于前者


#pragma mark                       ---- 常用宏定义 -----
//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

//一些常用的缩写
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate
#define kUserDefaults      [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//系统
//1 .是否是pad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//获取系统版本
#define IOS_VERSION ［[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ［UIDevice currentDevice] systemVersion]
// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

//获取app版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//GCD
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)







#endif /* AppHeader_h */
