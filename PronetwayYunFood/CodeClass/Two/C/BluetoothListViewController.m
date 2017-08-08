//
//  BluetoothListViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/4.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "BluetoothListViewController.h"
#import "BluetoothTableViewCell.h"
#import "JWPrinter.h"
#import "CodeModel.h"

@interface BluetoothListViewController ()<UITableViewDelegate ,UITableViewDataSource>


@property (strong, nonatomic)   CBCharacteristic            *chatacter;  /**< 可写入数据的特性 */
@property (strong, nonatomic)   CBPeripheral            *perpheral;

@property (strong, nonatomic)   NSArray            *goodsArray;  /**< 商品数组 */
@property (strong, nonatomic)   NSMutableArray            *infos;  /**< 详情数组 */

@property (strong, nonatomic) UITableView *BluetoothTabbview;
@property (assign) int writenumber;

@property (strong, nonatomic) CBPeripheral *myConnectedPeripheral; ///< 上一次连接上的 Peripheral，用来做自动连接时，保存强引用

@property (assign)BOOL blueSelected;

@property (strong, nonatomic) NSMutableArray *codeArr;



@end

static  NSString * const bindingFlag = @"bindingBlueToothFlag";


@implementation BluetoothListViewController

//修改订单状态-- 返回
-(void)backAction {

    if ([self.selectStr isEqualToString:@"xd"]) {
        
       // if ([[PronetwayYunFoodHandle shareHandle].Ordertype isEqualToString:@"error"]) {
            
            NetworkManger *netm =  [NetworkManger new];
            [netm reloadOrderStatus:self.Ordernumber type:@"error"];
            netm.Addkezuofenqusuccessblock = ^{
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            };
            netm.Failblock = ^{
                
                [WSProgressHUD showImage:nil status:@"服务器出错,请稍后再试!"];
            };
    }else if ([self.selectStr isEqualToString:@"system"]) {//返回系统设置界面
    
        if (_blueSelected == NO) {
            ////告知系统设置界面连接蓝牙失败...
            [kNotication  postNotificationName:kinformSystem object:nil];
        }
        //返回
        [self .navigationController popViewControllerAnimated:YES];
    }
    else {
    
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    //}else {
    
     //   [];
   // }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.selectStr isEqualToString:@"system"]) {
        
        [self setCustomerTitle:@"选择蓝牙打印机"];

    }else {
    
        [self setCustomerTitle:@"选择蓝牙并打印"];
        [self loadData];

    }
    //创建payurl
    //查找蓝牙设备
    //[self findbluebooth];
    [self.view addSubview:self.BluetoothTabbview];
    
    if (_deviceArray.count == 0) {
        
        [PronetwayYunFoodHandle shareHandle].Ordertype = @"error";
        _blueSelected = NO;
        [WSProgressHUD showImage:nil status:@"未扫描到可用蓝牙"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [WSProgressHUD showImage:nil status:@"请检测蓝牙设备是否开启!"];
        });
    }
}

//客桌管理批量 打印
-(NSMutableArray *)codeArr {

    if (!_codeArr) {
        _codeArr = [NSMutableArray array];
    }
    return _codeArr;
}

-(void)loadData {
    _infos = [[NSMutableArray alloc]init];
    _goodsArray = self.SelectgoodsArr;
    UIButton *rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightBtn.frame = CGRectMake(0, 0, 60*newKwith, 44*newKhight);
    [rightBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [rightBtn setTitle:@"打印" forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *bartm = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = bartm;
}
-(void)rightClick {

    if (_blueSelected == YES) {//客桌管理批量打印
        
        if ([self.selectStr isEqualToString:@"Yun_DeskManager"]) {
            
            [self reloadJosnForcode:self.placStr];
            
        
        }else if ([self.selectStr isEqualToString:@"paihao"]){//排号打印
        
            [self writePaihao:self.paiHaoModel];
            
        }else if ([self.selectStr isEqualToString:@"Yun_desk_changeManger"]){//客桌管理修改打印
            //打印
            [self desk_managerwrite:self.model.sid];
            
        }else {//下单点餐蓝牙打印
        
            [WSProgressHUD showShimmeringString:@"开始打印 .."];
            [self write];
            [self write];
        }
    }else {
        [WSProgressHUD showImage:nil status:@"请先选择蓝牙设备连接"];
    }
}

-(UITableView *)BluetoothTabbview {

    if (!_BluetoothTabbview) {
        
        _BluetoothTabbview = [[UITableView alloc]initWithFrame:kBounds style:(UITableViewStylePlain)];
        _BluetoothTabbview.delegate = self;
        _BluetoothTabbview.dataSource = self;
        _BluetoothTabbview.rowHeight = 60*newKhight;
        [_BluetoothTabbview registerClass:[BluetoothTableViewCell class] forCellReuseIdentifier:@"bluetoothcell"];
        
    }
    return _BluetoothTabbview;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _deviceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"bluetoothcell";
    BluetoothTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BluetoothTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    CBPeripheral *peripherral = [self.deviceArray objectAtIndex:indexPath.row];
    cell.namelab.text = [NSString stringWithFormat:@"名称:%@",peripherral.name];
    NSNumber * rssis = self.rissArr[indexPath.row];
    cell.signallab.text = [NSString stringWithFormat:@"强度:%@",rssis];
    if (peripherral.state == CBPeripheralStateConnected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.connectState.text = @"已连接";
        _blueSelected = YES;
    
    } else {
        cell.connectState.text = @"连接";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

// --- 点击事件 ---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CBPeripheral *peripheral = [self.deviceArray objectAtIndex:indexPath.row];
    
    if (peripheral.state == CBPeripheralStateConnecting || peripheral.state == CBPeripheralStateConnected ) {
        
        //打印机已经被占用
        [PronetwayYunFoodHandle shareHandle].Ordertype = @"error";
        [WSProgressHUD showImage:nil status:@"该打印机已被连接,订单将被转至后台打印!"];
        
        _blueSelected = NO;
        
        
        return;
    }
    //连接
    [_manager connectPeripheral:peripheral completion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
            [WSProgressHUD showImage:nil status:@"连接成功"];
            [self setCustomerTitle:[NSString stringWithFormat:@"已连接 %@",peripheral.name]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_BluetoothTabbview reloadData];
                _blueSelected = YES;
                //系统设置,连接成功自动返回!
                if ([self.selectStr isEqualToString:@"system"]) {
                    [kNotication postNotificationName:ksystemconnectedsuccess object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            });
        }else{
            [WSProgressHUD showImage:nil status:error.domain];
        }
    }];
    
}

-(void)writePaihao:(paiHaoModel *)model {
    
    if (_manager.stage != JWScanStageCharacteristics) {
        [WSProgressHUD showImage:nil status:@"打印机正在准备中 .."];
        return;
    }
    NSData *mainData = [[PrinterManager paiHaoModel:model] getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
            [kNotificationCenter postNotificationName:@"paiHaodysuccess" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            NSLog(@"写入错误---:%@",error);
        }
    }];
}
-(void)write {
    
    if (_manager.stage != JWScanStageCharacteristics) {
        [WSProgressHUD showImage:nil status:@"打印机正在准备中 .."];
        return;
    }
    NSData *mainData = [[PrinterManager getPrinter:self.model Ordernumber:self.Ordernumber goodsArray:self.goodsArray payurl:_payurl allmoney:self.allMoney type:@""] getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
            _writenumber ++;
            if (_writenumber == 1) {
                [WSProgressHUD showImage:nil status:@"打印完成"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }else{
            NSLog(@"写入错误---:%@",error);
            [WSProgressHUD showImage:nil status:@"写入错误"];
        }
    }];
}

#pragma  mark --- 客桌管理 批量添加 ---
//获取所有加密之后的字符串
-(void)reloadJosnForcode:(NSString *)placStr {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kkezhuoCode1,[UserDefaults objectForKeyStr:ksid],kkezhuoCode2,placStr];
    DLog(@"获取code的url -- %@",url);
    
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            NSArray *arr = dic[@"eimdata"];
            [self.codeArr removeAllObjects];
            for (NSDictionary *dict in arr) {
                CodeModel *model = [CodeModel setUpModelWithDictionary:dict];
                [self.codeArr addObject:model];
            }
            DLog(@"codeArr count --  %ld",self.codeArr.count);
            
            [self.collectArr enumerateObjectsUsingBlock:^(kezhuoModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [self.codeArr  enumerateObjectsUsingBlock:^(CodeModel *codemodel, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if ([codemodel.tableid isEqualToString:model.sid]) {
                        
                        NSString *payurl = [NSString stringWithFormat:@"%@/#/?ordercode=%@",kIpandPort,codemodel.ordercode];
                        DLog(@" --- name %@  \n numid %@",model.zonename ,model.numid);
                        
                        [self write:model payurl:payurl];
                        
                    }
                }];
            }];
        }else {
            [WSProgressHUD showImage:nil status:@"获取加密二维码出错"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

-(void)write:(kezhuoModel *)model payurl:(NSString *)payurl {
    
    if (_manager.stage != JWScanStageCharacteristics) {
        [WSProgressHUD showImage:nil status:@"打印机正在准备中 .."];
        return;
    }
    NSData *mainData = [[PrinterManager deskManagerPrinter:model payurl:payurl ] getFinalData];
    
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
            
            [kNotificationCenter postNotificationName:@"deskmanagerdySuccess" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            NSLog(@"写入错误---:%@",error);
        }
    }];
}

-(void)reloadJosnForgetcodeUrl:(NSString *)tableid {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kkezhuoCode1,[UserDefaults objectForKeyStr:ksid],kkezhuoCode2,tableid];
    DLog(@"加密客桌串 %@",url);
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic =(NSDictionary *)responseObject;
        
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            NSArray *arr = dic[@"eimdata"];
            for (NSDictionary *dict in arr) {
                
                CodeModel *model = [CodeModel setUpModelWithDictionary:dict];
                [self.codeArr addObject:model];
            }
            if (self.codeArr.count != 0) {
                CodeModel *model = self.codeArr[0];
                _payurl = [NSString stringWithFormat:@"%@/#/?ordercode=%@",kIpandPort,model.ordercode];
                //打印
                [self desk_managerwrite:_payurl];
            }
            
        }else {
            
            [WSProgressHUD showImage:nil status:@"生成二维码失败"];
        }
        
        
    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
    }];
    
}

-(void)desk_managerwrite:(NSString *)payUrl {
    
    if (_manager.stage != JWScanStageCharacteristics) {
        [WSProgressHUD showImage:nil status:@"打印机正在准备中 .."];
        return;
    }
    NSData *mainData = [[PrinterManager desk_changeManagerPrinter:self.model payUrl:payUrl ] getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
            
            [WSProgressHUD showImage:nil status:@"打印成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"写入错误---:%@",error);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
