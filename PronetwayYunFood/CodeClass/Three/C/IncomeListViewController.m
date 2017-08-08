//
//  IncomeListViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/14.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "IncomeListViewController.h"
#import "Yun_order_XDTableViewCell.h"
#import "cMoneyViewController.h"
#import "headerView.h"
#import "incomeModel.h"
#import "mutilModel.h"
#import "BluetoothListViewController.h"


@interface IncomeListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
   JWBluetoothManage *manage;

}
@property (strong, nonatomic) UITableView *IncomeTableView;
@property (strong, nonatomic) UIView *BottomView;
@property (strong, nonatomic) UILabel *lb4;
@property (strong, nonatomic) UILabel *lb5;
@property (strong, nonatomic) UILabel *lb6;
@property (strong, nonatomic) UIView *bootView;
@property (strong, nonatomic) RedBtn *dyBtn;
@property (strong, nonatomic) UIButton *saoMBtn;
@property (strong, nonatomic) NSMutableArray *allcaiArr;
@property (strong, nonatomic) NSMutableArray *incomeArr;
@property (strong, nonatomic) NSString *paytype;//// 1 创建二维码供别人扫码  2扫别人支付宝码
//重新打单
@property (nonatomic, strong) NSMutableArray * dataSource; //设备列表
@property (nonatomic, strong) NSMutableArray * rssisArray; //信号强度 可选择性使用
@property (strong, nonatomic)   NSArray            *goodsArray;  /**< 商品数组 */
@property (assign)  BOOL ConnectedSuccess; //是否连接成功
@property (strong, nonatomic) NSString *payUrl;

//设备确定页面
@property (strong, nonatomic) OkimageView *okimg;
@property (strong, nonatomic) GuideView *markView;
@property (assign) int maerkshow;
@property (strong, nonatomic) UIButton *Rightbtn;

@property (strong, nonatomic) NSString *ordern;


@end

@implementation IncomeListViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.selectStr isEqualToString:@"mycount"]) {
        
        
    }else {
    
        self.navigationController.navigationBar.hidden = NO;
        //自动连接
        [self Autoconnetct];

    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    
    
    if ([self.selectStr isEqualToString:@"mycount"]) {
        
        [self.view addSubview: self.IncomeTableView];

        [self reloadjosnFormycount];
        
    }else {
        
        //扫描蓝牙
        [self ScanBluetooth];
        
        
        [self setupnacBar];
        [self reloadjosnForlist:@""];
        [self.view addSubview: self.IncomeTableView];
        
        [self.view addSubview:self.bootView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if ([UserDefaults objectForKeyStr:kshowSY] == nil) {
                //展示蒙板页面
                [self showMarkView];
                
            }
        });
        
    }

    
    [self setCustomerTitle:@"消费明细"];
    
}

-(void)setupnacBar {
    
    _Rightbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _Rightbtn.frame = CGRectMake(0, 0, 90*newKwith, 44*newKhight);
    [_Rightbtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    _Rightbtn.titleLabel.font = kFont(15);
    [_Rightbtn setTitle:@"重打订单" forState:(UIControlStateNormal)];
    [_Rightbtn addTarget:self action:@selector(rightClickagain:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *rit = [[UIBarButtonItem alloc]initWithCustomView:_Rightbtn];
    self.navigationItem.rightBarButtonItem = rit;
}

//重打订单
-(void)rightClickagain:(UIButton *)btn {

    //创建支付的payurl 并打印
    [self creatOrder];
    
    
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

-(UIView *)bootView {

    if (!_bootView) {
        CGFloat w = kWidth/2;
        _bootView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight-44*newKhight-kNavBarHAndStaBarH, kWidth, 44*newKhight)];
        _bootView.backgroundColor  =kWhiteColor;
        _dyBtn = [[RedBtn alloc]initWithFrame:CGRectMake(w, 0, w, 44*newKhight)text:@"现金收银"];
        [_dyBtn addTarget:self action:@selector(dyBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_bootView addSubview:_dyBtn];
        
        _saoMBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _saoMBtn.frame = CGRectMake(0, 0, w, 44*newKhight);
        _saoMBtn.layer.masksToBounds = YES;
       // _saoMBtn.layer.cornerRadius = 5;
        [_saoMBtn setTitle:@"扫码收银" forState:(UIControlStateNormal)];
        _saoMBtn.titleLabel.font = kFont(16);
        _saoMBtn.layer.borderColor = [kRedColor CGColor];
        [_saoMBtn setTitleColor:kRedColor forState:(UIControlStateNormal)];
        _saoMBtn.layer.borderWidth = 1;
        [_saoMBtn addTarget:self action:@selector(SaoBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_bootView addSubview:_saoMBtn];
    }
    return _bootView;
}

-(UITableView *)IncomeTableView {

    if (!_IncomeTableView) {
        if ([self.selectStr isEqualToString:@"mycount"]) {
            
             _IncomeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kNavBarHAndStaBarH) style:(UITableViewStylePlain)];
        }else {
             _IncomeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kNavBarHAndStaBarH-44*newKhight) style:(UITableViewStylePlain)];
        }
        _IncomeTableView.dataSource = self;
        _IncomeTableView.delegate = self;
        _IncomeTableView.rowHeight = 80*newKhight;
        [_IncomeTableView registerClass:[Yun_order_XDTableViewCell class] forCellReuseIdentifier:@"incomexiaofeicell"];
        _IncomeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _IncomeTableView;
}

-(UIView *)BottomView {
    
    if (!_BottomView) {
        _BottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        _lb4 = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-160*newKwith, 0, 140*newKwith, _BottomView.height)];
        _lb4.textColor = RGB(225, 102, 125);
        _lb4.font = kFont(14);
        if (self.incomeArr.count!=0) {
            
            _lb4.text = [self AllPrice:self.allcaiArr];
            
        }
       // _lb4.text = [NSString stringWithFormat:@"应支付 : ¥ %@",@""];
        [_BottomView addSubview:_lb4];
        
        UIImageView *linVC = [[UIImageView alloc]initWithFrame:CGRectMake(0, _BottomView.height-1, kWidth, 1)];
        linVC.backgroundColor = RGB(247, 247, 247);
        [_BottomView addSubview:linVC];
        
        _BottomView.backgroundColor = kWhiteColor;
    }
    return _BottomView;
}

//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([self.selectStr isEqualToString:@"mycount"]) {
        
        return 1;
    }
    return _incomeArr.count;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.selectStr isEqualToString:@"mycount"]) {
        
        return self.incomeArr.count;
    }
    return  [_incomeArr[section] count];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self.selectStr isEqualToString:@"mycount"]) {
        
        return 44*newKhight;
    }else {
        if (section == self.allcaiArr.count-1) {
            
            return 44*newKhight;
            
        }else {
            
            return 0.0001;
        }
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if ([self.selectStr isEqualToString:@"mycount"]) {
        
        return self.BottomView;
        
    }else {
    
        if (section == self.allcaiArr.count-1) {
            
            return self.BottomView;
            
        }else {
            
            return  nil;
        }
    }
}
//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Yun_order_XDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"incomexiaofeicell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[Yun_order_XDTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"incomexiaofeicell"];
    }
    //if ( self.incomeArr[indexPath.section][indexPath.row]>indexPath.row) {
    
    if ([self.selectStr isEqualToString:@"mycount"]) {
        if (self.incomeArr.count>indexPath.row) {
            
            cell.mycountmodel = self.incomeArr[indexPath.row];
        }
    }else {
    
        cell.incModel = self.incomeArr[indexPath.section][indexPath.row];
  
    }
   // }
    return cell;
}
//表头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.selectStr isEqualToString:@"mycount"]) {
        
        return nil;
    }
    headerView *headerVC = [[headerView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 25*newKhight)];
    if (self.allcaiArr.count>section) {
        
        mutilModel *model = self.allcaiArr[section];
        headerVC.headerLb.text = model.createtime;
    }
    return headerVC;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if ([self.selectStr isEqualToString:@"mycount"]) {
        
        return 0.0001;
    }
    return 25*newKhight;
}

//创建二维码供别人扫码 //现金收银
-(void)dyBtnClick:(UIButton *)sender {

    _paytype = @"1";
    [self inquireOrder];
}
//扫码
-(void)SaoBtnClick {
    _paytype = @"2";
    [self inquireOrder];
}

//查询订单是否支付
-(void)inquireOrder {

    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kincome_OrderStatus1,self.model.sid,kincome_OrderStatus2,[UserDefaults objectForKeyStr:ksid]];
    DLog(@"查询订单是否支付 %@",url);
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"]isEqualToString:@"0"]) {//订单已支付
            [WSProgressHUD showImage:nil status:@"订单已支付"];
            
        }else if ([dic[@"result"]isEqualToString:@"1"]) {//订单未支付
        
            if ([_paytype isEqualToString:@"1"]) {//现金收银
                [self creatOrder:@"cash"];
            }else {//扫码支付
                [self creatOrder:@""];
            }
            
        }else {
        
            [WSProgressHUD showImage:nil status:@"查询错误"];
        }
    } failure:^(NSError *error) {
        DLog(@"%@",error);
    }];
}

//获取收银信息,订单合并
-(void)reloadjosnForlist:(NSString *)order  {
    NSString *urlstr ;

    if (kStringIsEmpty(order)) {//收银
     urlstr =  [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",kIpandPort,kincome_getlist1,@"",self.model.sid,kincome_getlist2,[UserDefaults objectForKeyStr:ksid],kincome_getlist3,[UserDefaults objectForKeyStr:kpid]];
        DLog(@"收银获取菜品列表的url %@",urlstr);
    }else {//我的账户
    
         urlstr =  [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",kIpandPort,kincome_getlist1,@"",self.model.sid,kincome_getlist2,[UserDefaults objectForKeyStr:ksid],kincome_getlist3,[UserDefaults objectForKeyStr:kpid]];
        DLog(@"我的账户消费明细的url %@",urlstr);

    }
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
            //刷新数据源
            [self.IncomeTableView reloadData];
            
            if (self.incomeArr.count!=0) {
                
                NSString *str = [self AllPrice:self.allcaiArr];
                _lb4.text = str;
                
            }
        }else {
        
            [WSProgressHUD showImage:nil status:@"无数据"];
        }
        
    
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

//创建支付订单 --收银
-(void)creatOrder:(NSString *)type {

     NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",kIpandPort,kincome_creatOrder1,kincome_creatOrder4,self.model.sid,kincome_creatOrder2,[UserDefaults objectForKeyStr:ksid],kincome_creatOrder3,type];
    DLog(@"创建支付订单的url -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"]isEqualToString:@"0"]) {
        
            if ([_paytype isEqualToString:@"1"]) {//现金收银
               // cMoneyViewController *cmVC = [cMoneyViewController new];
               // cmVC.payUrl = dic[@"payurl"];
               // [self.navigationController pushViewController:cmVC animated:YES];
                
                [WSProgressHUD showImage:nil status:@"现金收银成功"];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else { // 扫别人的支付码
                
                SGQRCodeScanningVC *vc = [[SGQRCodeScanningVC alloc] init];
                vc.payUrl = dic[@"orderno"];
                
                [self presentViewController:vc animated:YES completion:nil];
            }
        }
        
    } failure:^(NSError *error) {
        DLog(@"%@",error);
    }];
}
//计算钱
-(NSString *)AllPrice:(NSMutableArray *)Arr {
    //计算钱
    float all = 0.00;
    for (mutilModel *model in Arr) {
        
        all += model.cmoney ;
    }
    return   [NSString stringWithFormat:@"总计:  %0.2f",all/100];
    
}

//计算钱 我的账户

#pragma mark --- 重新打单 --
//扫描蓝牙
-(void)ScanBluetooth {
    
    self.dataSource = @[].mutableCopy;
    self.rssisArray = @[].mutableCopy;
    manage = [JWBluetoothManage sharedInstance];
    WeakType(self);
    [manage beginScanPerpheralSuccess:^(NSArray<CBPeripheral *> *peripherals, NSArray<NSNumber *> *rssis) {
        weakself.dataSource = [NSMutableArray arrayWithArray:peripherals];
        weakself.rssisArray = [NSMutableArray arrayWithArray:rssis];
        DLog(@"搜索到蓝牙列表");
    } failure:^(CBManagerState status) {
        
        DLog(@"连接失败");
        [WSProgressHUD showImage:nil status:[manage getBluetoothErrorInfo:status]];
    }];
    
    manage.disConnectBlock = ^(CBPeripheral *perpheral, NSError *error) {
        NSLog(@"设备已经断开连接！");
        [WSProgressHUD showImage:nil status:@"设备已断开连接"];
        [weakself setCustomerTitle:@"蓝牙已断开"];
        
    };
}
//蓝牙自动连接
-(void)Autoconnetct {
    WeakType(self);
    
    [manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
            [WSProgressHUD showImage:nil status:@"连接成功"];
            _ConnectedSuccess = YES;
            [weakself setCustomerTitle:[NSString stringWithFormat:@"已连接%@",perpheral.name]];
        }else{
            [WSProgressHUD showImage:nil status:@"自动连接失败"];
            [WSProgressHUD showImage:nil status:error.domain];
        }
    }];
}

//构造打印数据
- (JWPrinter *)getPrinter
{
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *title = [UserDefaults objectForKeyStr:kdianpuName];
    NSString *str1 = [NSString stringWithFormat:@"桌号 :%@ %@",[self.model.zonename substringToIndex:1],self.model.numid];
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
    //换行符
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
    // [printer appendTitle:@"总计:" value:[self AllPrice:self.allcaiArr]];
    [printer appendText:[NSString stringWithFormat:@"%@",[self AllPrice:self.allcaiArr]] alignment:2];
    //    [printer appendTitle:@"实收:" value:@"100.00"];
    //    NSString *leftStr = [NSString stringWithFormat:@"%.2f",100.00 - total];
    //    [printer appendTitle:@"找零:" value:leftStr];
    //换行符
    [printer appendNewLine];
    // 二维码
    [printer appendText:@"扫我付款" alignment:HLTextAlignmentCenter];
    //换行符
    [printer appendNewLine];

    
    if (_payUrl!=nil) {
        
        [printer appendQRCodeWithInfo:_payUrl size:8];//指令方式打印二维码,推荐
    }
    [printer appendSeperatorLine];
    
    ///    [printer appendText:@"指令方式打印二维码" alignment:HLTextAlignmentCenter];
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

//创建支付详单payurl --- 下单 支付详单 --- 打印给别人支付的
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
                //打印一次
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
-(void)write {
    
    if (manage.stage != JWScanStageCharacteristics) {
        [WSProgressHUD showImage:nil status:@"打印机正在准备中 .."];
        return;
    }
    NSData *mainData = [[self getPrinter] getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        
        if (!error) {
            [WSProgressHUD showImage:nil status:@"打印失败"];
        }
        if (completion) {
            
                [WSProgressHUD showImage:nil status:@"打印成功!"];
                //修改订单状态
                [self reloadOrderStatus:_ordern type:@"success"];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
      
        }else{
            NSLog(@"写入错误---:%@",error);
        }
    }];
}
//修改订单状态
-(void)reloadOrderStatus:(NSString *)orderno type:(NSString *)type {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kchangeorderDYStatus1,orderno,kchangeorderDYStatus2,type];
    DLog(@"修改客桌状态  type is %@ -- %@",url,type);
    
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

//构造加载的数据
-(NSMutableArray *)goodsArr:(NSMutableArray *)goodsArr{
    
    NSMutableArray *goods = [NSMutableArray array];
    
    [goodsArr enumerateObjectsUsingBlock:^(incomeModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dict = @{@"name":model.name,@"amount":[NSString stringWithFormat:@"x %ld",model.quantity],@"price":[NSString stringWithFormat:@"%0.2f",model.price/100]};
        [goods addObject:dict];
        
    } ];
    
    DLog(@"goods --- %@",goods);
    
    return goods;
}

#pragma mark --- 添加蒙板 ---
-(OkimageView *)okimg {
    if (!_okimg) {
        _okimg = [[OkimageView alloc]initWithFrame:CGRectMake((kWidth-140*newKwith)/2-50*newKwith, kNavBarHAndStaBarH+250*newKhight, 140*newKwith, 118*newKhight)];
    }
    
    
    return _okimg;
}

-(void)showMarkView {
    
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    
    _markView = [[GuideView alloc]initWithFrame:kBounds];
    _markView.fullShow = YES;
    _markView.model = GuideViewCleanModeRoundRect;
    //markView.guideColor = kCbgColor;
    _markView.showRect = CGRectMake(0,kHeight-38*newKhight,kWidth/2-5*newKwith,38*newKhight);
    _markView.markText = @"扫对方的二维码完成收银";
    
    [_markView addSubview:self.okimg];
    
    WeakType(self);
    self.okimg.Click = ^{
        
        weakself.maerkshow ++;
        if (weakself.maerkshow == 1) {
            
            [UIView animateWithDuration:0.5 animations:^{
                
                weakself.okimg.frame =CGRectMake(kWidth-160*newKwith, kNavBarHAndStaBarH+280*newKhight, 140*newKwith, 118*newKhight);
            }];
            
            [PronetwayYunFoodHandle shareHandle].dianpuright = @"dianpuright";
            weakself.markView.showRect = CGRectMake(kWidth/2+5*newKwith,kHeight-38*newKhight,kWidth/2,38*newKhight);
            weakself.markView.markText = @"现金支付";
        }else  if (weakself.maerkshow == 2){
            
            weakself.markView.showRect = CGRectMake(kWidth-90*newKwith,kStatusBarH,80*newKwith,37*newKhight);
            weakself.markView.markText = @"打印失败的订单可以在此重打!";

            
            
        }else {
            [UIView animateWithDuration:0.3 animations:^{
                [UserDefaults setObjectleForStr:@"YES" key:kshowSY];
                weakself.markView.alpha = 0;
            } completion:^(BOOL finished) {
                [PronetwayYunFoodHandle shareHandle].dianpuright = @"";
                [weakself.markView removeFromSuperview];
            }];
            
        }
    };
    [window addSubview:weakself.markView];
}

-(void)reloadjosnFormycount {
    if (!kStringIsEmpty(self.order)) {
        
        NSString *urlstr =  [NSString stringWithFormat:@"%@%@%@",kIpandPort,kgetUserOrderList,self.order];
        DLog(@"我的账户消费明细的url %@",urlstr);
        [CKLRequestManger GET:urlstr parameters:nil success:^(id responseObject) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            if ([dic[@"result"]isEqualToString:@"0"]) {
                NSArray *arr = dic[@"eimdata"];
                if (arr.count == 0) {
                    return ;
                }
                [self.incomeArr removeAllObjects];
                
                for (NSDictionary *dict in arr) {
                    
                    mycountModel *model = [mycountModel setUpModelWithDictionary:dict];
                    [self.incomeArr addObject:model];
                    
                }
                DLog(@"incomeArr -- %ld",self.incomeArr.count);
                
                //刷新数据源
                [self.IncomeTableView reloadData];
                
                if (self.incomeArr.count!=0) {
                    
                    _lb4.text = [NSString stringWithFormat:@"总金额: ¥  %0.2f",[self.allMoney floatValue]/100];
                }
            }else {
                
                [WSProgressHUD showImage:nil status:@"无数据"];
            }
        } failure:^(NSError *error) {
            [WSProgressHUD showImage:nil status:@"服务器错误"];
            DLog(@"%@",error);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
