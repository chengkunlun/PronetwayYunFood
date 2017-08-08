//
//  systemmanager.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/31.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "systemmanager.h"

@implementation systemmanager

-(NSMutableArray *)ordernumberArr {

    if (!_ordernumberArr) {
        _ordernumberArr = [NSMutableArray array];
    }
    return _ordernumberArr;
}

//开启定时器
-(void)openTimer:(NSTimeInterval )time {

    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        //定时检测接入wifi----检测接入wifi
        //默认是去请求的
        _isrequest = YES;
        //打开就去请求一次
        systemRequrest *requrest = [systemRequrest new];
        requrest.delegate = self;
        [requrest reloadJosnForgetOrderlist];
        
        //如果存在,先关闭之前的timer
        if ([PronetwayYunFoodHandle shareHandle].timeirisOpen == YES) {
            DLog(@" -- 定时器已经开启! --");
            return ;
        }else {
            [PronetwayYunFoodHandle shareHandle].timeirisOpen = YES;
            _systemTimer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(doCheckWifi) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] run];

        }
    });
    
}
//关闭定时器
-(void)closeTimr {
    _isrequest = NO;//关闭请求通道
    [_systemTimer invalidate];
    _systemTimer = nil;
    [PronetwayYunFoodHandle shareHandle].timeirisOpen = NO;

    
}

//定时请求 -- 获取数据
-(void)doCheckWifi{

    //获取手机电量,小于5% 自动断开后台服务
    
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    double deviceLevel = [UIDevice currentDevice].batteryLevel;
    //电量低于15%
    if (deviceLevel<0.20) {
        Alert *alert = [Alert new];
        [alert alert:@"电量过低,请充电!否则将会关闭后台打单服务!"];
    }
    ///电量小于10%
    if (deviceLevel<0.05) {
        [self closeTimr];
        Alert *alert = [Alert new];
        [alert alert:@"后台服务已关闭"];
        [UserDefaults setObjectleForStr:@"NO" key:ksavebackground];
        return;
    }
    
    
    //打印成功再去请求
    if (_isrequest == YES) {
        
        //请求,打印的时候,把状态修改为NO;
        _isrequest = NO;
        systemRequrest *requrest = [systemRequrest new];
        requrest.delegate = self;
        [requrest reloadJosnForgetOrderlist];
    }
    DLog(@"后台服务");
    
    //定时连接
   // [self disconnectAndconnect];
    
    
}

//修改订单状态
-(void)modifyOrderStatus:(NSString *)status {

    //请求 修改订单状态
    NetworkManger *netm = [NetworkManger new];
    NSString *placStr = [self.ordernumberArr componentsJoinedByString:@","];
    [netm reloadOrderStatus:placStr type:status];
    _isrequest = YES;
}
#pragma mark -- request delegate --
//没有数据 继续请求
-(void)requestisgoon:(BOOL)isYes {

    _isrequest = YES;
}

//获取
-(void)finarr:(NSMutableArray *)finaArr findic:(NSMutableDictionary *)findic tableidArr:(NSMutableArray *)tableidArr {
    //有数据之后,才开始打印

    DLog(@"%ld",finaArr.count);
    
    if (tableidArr.count!=0) {
        
        [self.ordernumberArr removeAllObjects];
        
        [finaArr enumerateObjectsUsingBlock:^(orderListModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self.ordernumberArr addObject:model.orderno];
        }];
       
        //修改订单状态
        [self modifyOrderStatus:@"ing"];
        
        //打印
        [tableidArr enumerateObjectsUsingBlock:^(NSString *tableid, NSUInteger idx, BOOL * _Nonnull stop) {
        
            NSMutableArray *arr = [NSMutableArray array];
            arr = findic[tableid];
            
            if (arr.count!=0) {
                
                orderListModel *model = arr[0][0];
                DLog(@"%@",model.numid);
                kezhuoModel *deskmodel = [[kezhuoModel alloc]init];
                deskmodel.zonename = model.zname;
                deskmodel.numid = model.numid;
                
                //打印两张单子
                [self writeOrdernumber:model.orderno goodsArr:(NSMutableArray *)arr payurl:model.payurl allmoney:[self systemMoney:(NSMutableArray *)arr] kezuomodel:deskmodel];
                
                [self writeOrdernumber:model.orderno goodsArr:(NSMutableArray *)arr payurl:model.payurl allmoney:[self systemMoney:(NSMutableArray *)arr] kezuomodel:deskmodel];
                
            }
    }];
        
        DLog(@"打印");
    }
}

-(void)disconnectAndconnect {

    [_manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
            _ConnectedSuccess = YES;
        }else{
            [WSProgressHUD showImage:nil status:error.domain];
        }
    }];
}

//自动重连
-(void)Autoconnect {
    
    [_manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
            [WSProgressHUD showImage:nil status:@"连接成功"];
            _ConnectedSuccess = YES;
            
            if (_delegate && [_delegate respondsToSelector:@selector(autoShowperical:)]) {
                
                [_delegate autoShowperical:perpheral];
            }
        }else{
            [WSProgressHUD showImage:nil status:@"自动连接失败"];
            [WSProgressHUD showImage:nil status:error.domain];
        }
    }];
}
//扫描蓝牙
-(void)ScanBluetooth {

    self.dataSource = @[].mutableCopy;
    self.rssisArray = @[].mutableCopy;
    _manage = [JWBluetoothManage sharedInstance];
    WeakType(self);
    [_manage beginScanPerpheralSuccess:^(NSArray<CBPeripheral *> *peripherals, NSArray<NSNumber *> *rssis) {
        weakself.dataSource = [NSMutableArray arrayWithArray:peripherals];
        weakself.rssisArray = [NSMutableArray arrayWithArray:rssis];
        DLog(@"搜索到蓝牙列表");
    } failure:^(CBManagerState status) {
        
        DLog(@"连接失败");
        [WSProgressHUD showImage:nil status:[_manage getBluetoothErrorInfo:status]];
    }];
    
    //断开蓝牙回调
    _manage.disConnectBlock = ^(CBPeripheral *perpheral, NSError *error) {
        DLog(@"设备已经断开连接！");
        [WSProgressHUD showImage:nil status:@"设备已断开连接"];
        
        if (weakself.delegate && [_delegate respondsToSelector:@selector(disConnectBlock:)]) {
            [weakself.delegate disConnectBlock:perpheral];
        }
    };
}
//断开连接
-(void)disconnect:(CBPeripheral *)perprial {
    [_manage cancelPeripheralConnection:perprial];
}
//连接蓝牙
-(void)connectPerprial:(CBPeripheral *)perprial {

    [_manage connectPeripheral:perprial completion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
            [WSProgressHUD showImage:nil status:@"连接成功"];
            _ConnectedSuccess = YES;
            
            if (_delegate && [_delegate respondsToSelector:@selector(autoShowperical:)]) {
                
                [_delegate autoShowperical:perpheral];
            }
        }
    }];
}

//构造加载的数据
-(NSMutableArray *)goodsArr:(NSMutableArray *)goodsArr{
    
    NSMutableArray *goods = [NSMutableArray array];
    
    [goodsArr enumerateObjectsUsingBlock:^(orderListModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dict = @{@"name":model.dname,@"amount":[NSString stringWithFormat:@"x %@",model.quantity],@"price":[NSString stringWithFormat:@"%0.2f",[model.price floatValue]/100]};
        [goods addObject:dict];
        
    } ];
    DLog(@"goods --- %@",goods);
    return goods;
}
-(void)writeOrdernumber:(NSString *)ordernumber goodsArr:(NSMutableArray *)goodsArr payurl:(NSString *)payurl allmoney:(NSString *)allmoney kezuomodel:(kezhuoModel *)model {
    
    if (_manage.stage != JWScanStageCharacteristics) {
        [WSProgressHUD showImage:nil status:@"打印机正在准备中 .."];
        [self modifyOrderStatus:@"error"];
        return;
    }
    NSData *mainData = [[PrinterManager getPrinter:model Ordernumber:ordernumber goodsArray:goodsArr payurl:payurl allmoney:allmoney type:@"system"] getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
            //打印成功置为yes
            _isrequest = YES;
            [WSProgressHUD showImage:nil status:@"打印完成"];
            [self modifyOrderStatus:@"success"];
            }else{
            NSLog(@"写入错误---:%@",error);
                [self modifyOrderStatus:@"error"];
        }
    }];
}

-(NSString *)systemMoney:(NSMutableArray *)allmoneyArr {
    //计算钱
    float all = 0.00;
    
        for (NSArray *arr in allmoneyArr) {
        
     for (orderListModel *model in arr) {
         
     all += [model.quantity floatValue]*[model.price floatValue]/100;
         
      }
 }
    return [NSString stringWithFormat:@"总计 : %0.2f",all];
}




@end
