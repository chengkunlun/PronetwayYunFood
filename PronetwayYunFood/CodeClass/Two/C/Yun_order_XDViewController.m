//
//  Yun_order_XDViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/15.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Yun_order_XDViewController.h"
#import "Yun_order_XDView.h"
#import "Order_XDAlertView.h"
#import "Home_CaiPinModel.h"
#import "BluetoothListViewController.h"

#import "JWPrinter.h"
#import "JWBluetoothManage.h"

#import "incomeModel.h"
#import "mutilModel.h"


@interface Yun_order_XDViewController ()<XDViewdelagate>
{

    JWBluetoothManage * manage;

}
@property (strong, nonatomic) Yun_order_XDView *xiadanVC;
@property (strong, nonatomic) NSMutableArray *placArr;
@property (strong, nonatomic) NSString *payUrl;
@property (strong, nonatomic) NSString *ordern;

@property (nonatomic, strong) NSMutableArray * dataSource; //设备列表
@property (nonatomic, strong) NSMutableArray * rssisArray; //信号强度 可选择性使用
@property (strong, nonatomic)   NSArray            *goodsArray;  /**< 商品数组 */
@property (assign)  BOOL ConnectedSuccess; //是否连接成功
@property (strong, nonatomic)UIButton *rightBtn;
@property (assign) int writenumber;

@property (strong, nonatomic) NSMutableArray *allcaiArr;
@property (strong, nonatomic) NSMutableArray *incomeArr;

@end


@implementation Yun_order_XDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"下单"];
    _xiadanVC = [[Yun_order_XDView alloc]initWithFrame:kBounds sid:self.model.sid];
   // _xiadanVC.FoodArr = self.selectArr;
    //_xiadanVC.allPrice = self.AllPrice;
    _xiadanVC.delegate = self;
    _xiadanVC.model = self.model;
    
   //蓝牙自动重连
   [self ScanBluetooth];
    
    WeakType(self);
    _xiadanVC.xdBlock = ^{
        DLog(@"下单--");
        
     [weakself reloadJosnForXd];
    };
    [self.view addSubview:_xiadanVC];
    
    [self setupnavbar];
    
}

-(void)setupnavbar {

    _rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _rightBtn.frame = CGRectMake(0, 0, 60*newKwith, 44*newKhight);
    [_rightBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [_rightBtn setTitle:@"重连" forState:(UIControlStateNormal)];
    _rightBtn.titleLabel.font = kFont(14);
    _rightBtn.hidden = YES;
    [_rightBtn addTarget:self action:@selector(ritBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItem = bar;

}

//懒加载
-(NSMutableArray *)placArr {

    if (!_placArr) {
        _placArr = [[NSMutableArray alloc]init];
    }
    return _placArr;
}

-(void)TogetXDArr:(NSMutableArray *)Arr {

    self.selectArr = Arr;
}

#pragma mark --- 懒加载 ---
-(NSMutableArray *)incomeArr {
    
    if (!_incomeArr) {
        _incomeArr = [NSMutableArray array];
    }
    return _incomeArr;
    
}

-(NSMutableArray *)allcaiArr {
    
    if (!_allcaiArr) {
        _allcaiArr = [NSMutableArray array];
    }
    return _allcaiArr;
}

-(NSString *)AllPrice:(NSMutableArray *)Arr {
    //计算钱
    float all = 0.00;
    for (mutilModel *model in Arr) {
        
        all += model.cmoney ;
    }
    return   [NSString stringWithFormat:@"总计: %0.2f",all/100];
    
}
//计算钱
-(NSString *)allPrice:(NSMutableArray *)Arr {
    //计算钱
    NSInteger all = 0;
    for (XDModel *model in Arr) {
        
        all += [model.price integerValue]*[model.quantity integerValue];
    }
    // all = all/100;
    NSString *alstr = [NSString stringWithFormat:@"%ld",all];
    return alstr;
}
//扫描蓝牙设备
-(void)ScanBluetooth {

    self.dataSource = @[].mutableCopy;
    self.rssisArray = @[].mutableCopy;
    manage = [JWBluetoothManage sharedInstance];
    WeakType(self);
    [manage beginScanPerpheralSuccess:^(NSArray<CBPeripheral *> *peripherals, NSArray<NSNumber *> *rssis) {
        weakself.dataSource = [NSMutableArray arrayWithArray:peripherals];
        weakself.rssisArray = [NSMutableArray arrayWithArray:rssis];
        DLog(@"扫描成功");
    } failure:^(CBManagerState status) {
        
        DLog(@"连接失败");
        [WSProgressHUD showImage:nil status:[self getBluetoothErrorInfo:status]];
    }];
    
    manage.disConnectBlock = ^(CBPeripheral *perpheral, NSError *error) {
        NSLog(@"设备已经断开连接！");
        [WSProgressHUD showImage:nil status:@"设备已断开连接"];
        [weakself setCustomerTitle:@"蓝牙已断开"];
        weakself.rightBtn.hidden = NO;
    };
}
//页面将要加载的时候 自动重连
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self Autoconnetct];
    
    if ([[PronetwayYunFoodHandle shareHandle].Ordertype isEqualToString:@"error"]) {
        // 订单打印失败,把订单打印状态置为 error
        [self reloadOrderStatus:_ordern type:@"error"];
    }
}

-(void)Autoconnetct {
    WeakType(self);

    [manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
            
            [WSProgressHUD showImage:nil status:@"连接成功"];
            _ConnectedSuccess = YES;
            [weakself setCustomerTitle:[NSString stringWithFormat:@"已连接%@",perpheral.name]];
            weakself.rightBtn.hidden = YES;
        }else{
            [WSProgressHUD showImage:nil status:@"自动连接失败"];
            [WSProgressHUD showImage:nil status:error.domain];
            weakself.rightBtn.hidden = NO;
        }
    }];
}
//自动重连
-(void)ritBtnClick {

    [self Autoconnetct];
}

//向打印机里面写入数据 !
-(void)write {

    if (manage.stage != JWScanStageCharacteristics) {
        [WSProgressHUD showImage:nil status:@"打印机正在准备中 .."];
        return;
    }
    NSData *mainData = [[self getPrinter] getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            _writenumber ++;
            DLog(@"打印成功 -- %d",_writenumber);
            if (_writenumber == 1) {
                
                [WSProgressHUD showImage:nil status:@"打印成功!"];
                //修改订单状态--打印状态
                [self reloadOrderStatus:_ordern type:@"success"];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }else{
            NSLog(@"写入错误---:%@",error);
        }
    }];
}

#warning 如果下单成功了,打印机没打印,这种情况桌子状态就已经改变了,怎么置回空,订单状态 可以重打订单?
//下单请求数据---- 下单 !
-(void)reloadJosnForXd {
    
    NSString *time = [DateUtil getCurrentTimestamp];
    NSString *orderno = [NSString stringWithFormat:@"%@%@%@",[UserDefaults objectForKeyStr:ksid],self.model.numid,time];
    _ordern = orderno;
    
    [self.placArr removeAllObjects];
    [self.selectArr enumerateObjectsUsingBlock:^(XDModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *str = [NSString stringWithFormat:@"('%@',%@,%@,%@)",orderno,model.disheid,model.quantity,model.price];
        [self.placArr addObject:str];
    }];
    
    NSString *plateStr = [self.placArr componentsJoinedByString:@","];
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",kIpandPort,kdc_xd1,[UserDefaults objectForKeyStr:ksid],kdc_xd2,self.model.sid,kdc_xd3,[self allPrice:self.selectArr],kdc_xd4,orderno,kdc_xd5,[UserDefaults objectForKeyStr:kpid],kdc_xd6,plateStr,@"&numid=",self.model.numid,@"&seatnum=",self.model.seatnum,@"&zoneid=",self.model.zoneid,@"&paystatus=0",@"&typeid="];
    
    DLog(@"下单 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            // 1 下单成功把订单的状态置为正在打印
            [self reloadOrderStatus:orderno type:@"ing"];
            
            // 2 收银码上的详单
            [self reloadjosnForlist];
            
        }else {
            [WSProgressHUD showImage:nil status:@"下单失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

//修改订单状态
-(void)reloadOrderStatus:(NSString *)orderno type:(NSString *)type {

    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kchangeorderDYStatus1,orderno,kchangeorderDYStatus2,type];
    DLog(@"修改客桌订单状态  type is %@ -- %@",url,type);
    
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"订单状态修改成功"];
        }else {
        
            [WSProgressHUD showImage:nil status:@"订单状态修改失败"];
        }
        
    } failure:^(NSError *error) {
    
    }];
    
}

//获取收银码上的详单 -- 订单详细
-(void)reloadjosnForlist {
    
    NSString *urlstr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",kIpandPort,kincome_getlist1,@"",self.model.sid,kincome_getlist2,[UserDefaults objectForKeyStr:ksid],kincome_getlist3,[UserDefaults objectForKeyStr:kpid]];
    DLog(@"收银获取菜品列表的url %@",urlstr);
    
    [CKLRequestManger GET:urlstr parameters:nil success:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"]isEqualToString:@"0"]) {
            NSArray *arr = dic[@"orderinfo"];
            if (arr.count == 0) {
                return ;
            }
            for (NSDictionary *dict in arr) {
                
                mutilModel *model = [mutilModel setUpModelWithDictionary:dict];
                [self.allcaiArr addObject:model];
                
            }
            DLog(@"mubArr -- %ld",self.allcaiArr.count);
            
            for (mutilModel *model in self.allcaiArr) {
                
                NSArray *arr1 = model.dishesinfo;
                NSMutableArray *mbArr = [NSMutableArray array];
                
                for (NSDictionary *dictt in arr1) {
                    incomeModel *model = [incomeModel setUpModelWithDictionary:dictt];
                    [mbArr addObject:model];
                    
                }
                [self.incomeArr addObject:mbArr];
            }
            self.incomeArr = (NSMutableArray *)[[self.incomeArr reverseObjectEnumerator] allObjects];//倒序
            
            //加载数据 -- 显示打印加菜信息-- 构造打印数据在写入数据时完成
            //创建payurl --- 订单的payurl
            [self creatOrder];


        }else {
            
            [WSProgressHUD showImage:nil status:@"无数据"];
        }
        
        
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}
//构造加载的数据
-(NSMutableArray *)goodsArr:(NSMutableArray *)goodsArr{
    
    NSMutableArray *goods = [NSMutableArray array];
    
    [goodsArr enumerateObjectsUsingBlock:^(incomeModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dict = @{@"name":model.name,@"amount":[NSString stringWithFormat:@" x %ld",model.quantity],@"price":[NSString stringWithFormat:@"%0.2f",model.price/100]};
        [goods addObject:dict];
    } ];
    DLog(@"goods --- %@",goods);
    return goods;
}

- (JWPrinter *)getPrinter
{
    
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *title = [UserDefaults objectForKeyStr:kdianpuName];
    NSString *str1 = [NSString stringWithFormat:@"桌号 :%@-%@",self.model.zonename,self.model.numid];
    [printer appendText:title alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    // 条形码
    //[printer appendBarCodeWithInfo:[UserDefaults objectForKeyStr:ksid]];
    //[printer appendSeperatorLine];
    //空格
    [printer appendNewLine];
    
    [printer appendTitle:@"时间:" value:[DateUtil getCurrentTimeFormiao] valueOffset:150];
    [printer appendTitle:@"订单:" value:self.ordern valueOffset:150];
    [printer appendText:[NSString stringWithFormat:@"地址:%@",[UserDefaults objectForKeyStr:kadress]] alignment:HLTextAlignmentLeft];
    
    [printer appendSeperatorLine];
    
    [printer appendLeftText:@"商品" middleText:@"数量" rightText:@"单价" isTitle:YES];
    //换行
    [printer appendNewLine];
    
    for ( int i = 0;i<self.incomeArr.count;i++) {
        NSMutableArray *arr = self.incomeArr[i];
        
        NSMutableArray *mutilArr = [NSMutableArray array];
        
        if (i == 0) {
            
            mutilArr = [self goodsArr:arr];
            for (NSDictionary *dict in mutilArr) {
                [printer appendLeftText:dict[@"name"] middleText:dict[@"amount"] rightText:dict[@"price"] isTitle:NO];
                //total += [dict[@"price"] floatValue] * [dict[@"amount"] intValue];
            }
            [printer appendSeperatorLine];

        }else {
            
            [printer appendText:@"加菜" alignment:(HLTextAlignmentCenter)];
            mutilArr = [self goodsArr:arr];
            for (NSDictionary *dict in mutilArr) {
                
                [printer appendLeftText:dict[@"name"] middleText:dict[@"amount"] rightText:dict[@"price"] isTitle:NO];
                //total += [dict[@"price"] floatValue] * [dict[@"amount"] intValue];
            }
            [printer appendSeperatorLine];
        }
    }
   // NSString *totalStr = [NSString stringWithFormat:@"%.2f",total];
    
   // [printer appendTitle:@"总计:" value:[self AllPrice:self.allcaiArr]];
    [printer appendText:[NSString stringWithFormat:@"%@",[self AllPrice:self.allcaiArr]] alignment:2];
    //    [printer appendTitle:@"实收:" value:@"100.00"];
    //    NSString *leftStr = [NSString stringWithFormat:@"%.2f",100.00 - total];
    //    [printer appendTitle:@"找零:" value:leftStr];
    //换行
    [printer appendNewLine];
    // 二维码
    [printer appendText:@"扫我付款" alignment:HLTextAlignmentCenter];
    //换行
    [printer appendNewLine];

    if (_payUrl!=nil) {
     [printer appendQRCodeWithInfo:_payUrl size:8];
    }
    [printer appendNewLine];
    
    //    [printer appendText:@"指令方式打印二维码" alignment:HLTextAlignmentCenter];
    //    [printer appendQRCodeWithInfo:@"www.baidu.com" size:12];
    //    [printer appendSeperatorLine];
    // 图片
    // [printer appendImage:[UIImage imageNamed:@"ico180"] alignment:HLTextAlignmentCenter maxWidth:300];
    // [printer appendFooter:nil];
    
    [printer appendText:@"温馨提示: 请随身携带好贵重物品,谨防遗落!" alignment:HLTextAlignmentCenter];
    
    [printer appendNewLine];
    
    [printer appendText:@"谢谢惠顾,欢迎下次光临!" alignment:HLTextAlignmentCenter];
    
    [printer appendSeperatorLine];
    
    return printer;
}

//创建支付详单payurl
-(void)creatOrder {
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@",kIpandPort,kXD_creatOrder,kincome_creatOrder4,self.model.sid,kincome_creatOrder2,[UserDefaults objectForKeyStr:ksid]];
    DLog(@"创建支付订单的url -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            _payUrl = dic[@"payurl"];
            DLog(@"支付订单 ---- %@",_payUrl);
            [WSProgressHUD showImage:nil status:@"下单成功"];
            //单子已经下成功了,打印失败怎么办?
            //判断是否连接蓝牙成功,连接成功之后,直接下单打印,不需要跳列表连接.否则跳到选择蓝牙界面
            if (self.ConnectedSuccess == YES) {
                DLog(@"重连成功");
                [WSProgressHUD showShimmeringString:@"正在打印 .."];
                //打印两次
                [self write];
                
                [self write];

            }else {
                
                //判断是否是加菜,加菜的话,先去请求收银之后的订单
                // 加菜和新单是一样的流程
                BluetoothListViewController *blueVC = [BluetoothListViewController new];
                blueVC.SelectgoodsArr = self.incomeArr;
                blueVC.Ordernumber = self.ordern;//订单号
                blueVC.model = self.model;
                blueVC.payurl =self.payUrl;
               // blueVC.allMoney = [self allPrice:self.selectArr];
                blueVC.manager =   manage;
                blueVC.deviceArray = self.dataSource;
                blueVC.rissArr = self.rssisArray;
                blueVC.allMoney = [self AllPrice:self.allcaiArr];
                blueVC.selectStr = @"xd";
                if (blueVC.SelectgoodsArr.count==0) {
                    
                    [WSProgressHUD showImage:nil status:@"订单为空"];
                    
                }else {
                    [self.navigationController pushViewController:blueVC animated:YES];
                }
            }
        }else  {
            
            [WSProgressHUD showImage:nil status:@"生成二维码订单失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
    }];
}

//蓝牙连接状态
-(NSString *)getBluetoothErrorInfo:(CBManagerState)status{
    NSString * tempStr = @"未知错误";
    switch (status) {
        case CBManagerStateUnknown:
            tempStr = @"未知错误";
            break;
        case CBManagerStateResetting:
            tempStr = @"正在重置";
            break;
        case CBManagerStateUnsupported:
            tempStr = @"设备不支持蓝牙";
            break;
        case CBManagerStateUnauthorized:
            tempStr = @"蓝牙未被授权";
            break;
        case CBManagerStatePoweredOff:
            tempStr = @"蓝牙关闭";
            break;
        default:
            break;
    }
    return tempStr;
}


-(void)viewWillDisappear:(BOOL)animated{

    [PronetwayYunFoodHandle shareHandle].Ordertype = @"";

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
