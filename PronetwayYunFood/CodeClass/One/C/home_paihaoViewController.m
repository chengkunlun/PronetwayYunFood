//
//  home_paihaoViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/18.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "home_paihaoViewController.h"
#import "paiHaoModel.h"
@interface home_paihaoViewController ()
{

    JWBluetoothManage *manage;
}
@property (strong, nonatomic) UIButton * DYBtn;
@property (strong, nonatomic) UITextField *phoneT;
@property (strong, nonatomic) UITextField *peopleT;
@property (strong, nonatomic) NSMutableDictionary *attributes;
@property (strong, nonatomic) NSMutableArray *paiHaoArr;

@property (nonatomic, strong) NSMutableArray * dataSource; //设备列表
@property (nonatomic, strong) NSMutableArray * rssisArray; //信号强度 可选择性使用
@property (strong, nonatomic)   NSArray            *goodsArray;  /**< 商品数组 */
@property (assign)  BOOL ConnectedSuccess; //是否连接成功
@property (strong, nonatomic)UIButton *rightBtn;

@end

@implementation home_paihaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle:@"排号"];
    self.view.backgroundColor = kWhiteColor;
    
    //连接蓝牙
    [self ScanBluetooth];
    
    [kNotificationCenter addObserver:self selector:@selector(paihaosuccess) name:@"paiHaodysuccess" object:nil];
    _attributes = [NSMutableDictionary dictionary];
    // 设置富文本对象的颜色
    _attributes[NSForegroundColorAttributeName] = RGB(0x85, 0x85, 0x85);
    
    [self addView];
    // Do any additional setup after loading the view.
}


//通知方法
-(void)paihaosuccess {
    
    [WSProgressHUD showImage:nil status:@"打印成功!"];
    _DYBtn.enabled = YES;

}

-(NSMutableArray *)paiHaoArr {

    if (!_paiHaoArr) {
        _paiHaoArr = [[NSMutableArray alloc]init];
    }
    return _paiHaoArr;
}

-(void)addView{

    for (int i = 0; i<2; i++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(15*newKwith, 40+newKhight+i*(64*newKhight), kWidth-30*newKwith, 44*newKhight)];
        view.backgroundColor = kCbgColor;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 5;
        [self.view addSubview:view];
        
        
    }
    _phoneT = [[UITextField alloc]initWithFrame:CGRectMake(20*newKwith, 40*newKhight, kWidth-40*newKwith, 44*newKhight)];
    _phoneT.font = kFont(15);
    _phoneT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号码" attributes:_attributes];
    _phoneT.clearButtonMode = 1;
    _phoneT.keyboardType = UIKeyboardTypeNumberPad;

    [self.view addSubview:_phoneT];
    
    _peopleT = [[UITextField alloc]initWithFrame:CGRectMake(20*newKwith, 40*newKhight+64*newKhight, kWidth-40*newKwith, 44*newKhight)];
    _peopleT.font = kFont(15);
    _peopleT.keyboardType = UIKeyboardTypeNumberPad;
    _peopleT.clearButtonMode = 1;
    _peopleT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"就餐人数" attributes:_attributes];
    [self.view addSubview:_peopleT];
    
    [self.view addSubview:self.DYBtn];
    
}


-(UIButton *)DYBtn {
    
    if (!_DYBtn) {
        _DYBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _DYBtn.frame = CGRectMake(15*newKwith, 178*newKhight ,kWidth-30*newKwith, 44*newKhight);
        [_DYBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        _DYBtn.titleLabel.font = kBodlFont(16);
        [_DYBtn setTitle:@"打 印" forState:(UIControlStateNormal)];
        //[_XDBtn setImage:kimage(@"Yun_order_bottom") forState:(UIControlStateNormal)];
        [_DYBtn setBackgroundImage:kimage(@"Yun_order_bottom") forState:(UIControlStateNormal)];
        [_DYBtn addTarget:self action:@selector(dyBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _DYBtn.layer.masksToBounds = YES;
        _DYBtn.layer.cornerRadius = 5;
    }
    return _DYBtn;
}
-(void)dyBtnClick:(UIButton *)btn {

    [_peopleT resignFirstResponder];

    if ([self checkT]) {
        
        [WSProgressHUD showWithStatus:@"正在打印 .."];

        _DYBtn.enabled = NO;
        //NetworkManger *manger = [NetworkManger new];
       // [manger paiHaoadd:_phoneT.text num:_peopleT.text];
    
        //开启蓝牙打印功能!
        [self paiHaoadd:_phoneT.text num:_peopleT.text];
    

        DLog(@"打印");
    }
}
-(BOOL)checkT {

    if (kStringIsEmpty(_phoneT.text)) {
        [self paidong:_phoneT];
        return NO;
    }
    if (kStringIsEmpty(_peopleT.text)) {
        
        [self paidong:_peopleT];
        return NO;
    }
    
    if (![ValidateUtil checkTel:_phoneT.text]) {
        
    [WSProgressHUD showImage:nil status:@"手机号无效"];
        [self paidong:_phoneT];

        return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}


-(void)paidong:(UITextField *)T {
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"
                                 ];
    anim.duration = 0.2;
    anim.repeatCount = 2;
    anim.values = @[@-20, @20, @-20];
    [T.layer addAnimation:anim forKey:nil];
}

//排号新增
-(void)paiHaoadd:(NSString *)tel num:(NSString *)num {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",kIpandPort,kpai_add1,[UserDefaults objectForKeyStr:ksid],kpai_add2,num,kpai_add2,tel];
    DLog(@"排号新增客桌%@",urlStr);
    
    [CKLRequestManger GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
        
            NSArray *arr = dic[@"eimdata"];
            [self.paiHaoArr removeAllObjects];
            
            for (NSDictionary *dict in arr) {
                
                paiHaoModel *model = [paiHaoModel setUpModelWithDictionary:dict];
                [self.paiHaoArr addObject:model];
            }
            
            if (self.paiHaoArr.count!=0) {
                
                paiHaoModel *model = self.paiHaoArr[0];

                if (_ConnectedSuccess == NO) {
                    
                    BluetoothListViewController *blueVC = [BluetoothListViewController new];
                    blueVC.paiHaoModel = model;
                    blueVC.selectStr = @"paihao";
                    _DYBtn.enabled = YES;
                    blueVC.manager = manage;
                    blueVC.deviceArray = self.dataSource;
                    blueVC.rissArr = self.rssisArray;
                    [WSProgressHUD showImage:nil status:@"选择打印机"];
                    [self.navigationController pushViewController:blueVC animated:YES];
                }else {
            
                    [self write:model];
                }
            }
        }else {
            [WSProgressHUD showImage:nil status:@"添加失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

-(void)ScanBluetooth {
    
    self.dataSource = @[].mutableCopy;
    self.rssisArray = @[].mutableCopy;
    manage = [JWBluetoothManage sharedInstance];
    WeakType(self);
    [manage beginScanPerpheralSuccess:^(NSArray<CBPeripheral *> *peripherals, NSArray<NSNumber *> *rssis) {
        weakself.dataSource = [NSMutableArray arrayWithArray:peripherals];
        weakself.rssisArray = [NSMutableArray arrayWithArray:rssis];
    } failure:^(CBManagerState status) {
        [WSProgressHUD showImage:nil status:[self getBluetoothErrorInfo:status]];
    }];
    
    manage.disConnectBlock = ^(CBPeripheral *perpheral, NSError *error) {
        NSLog(@"设备已经断开连接！");
        [WSProgressHUD showImage:nil status:@"设备已断开连接"];
        [weakself setCustomerTitle:@"蓝牙已断开"];
        
        weakself.rightBtn.hidden = NO;
    };
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([[PronetwayYunFoodHandle shareHandle].Ordertype isEqualToString:@"error"] ) {
        
        _phoneT.text = @"";
        _peopleT.text = @"";

        [WSProgressHUD showImage:nil status:@"排号成功,打印失败"];
        
    }
    
    [self Autoconnetct];
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

-(void)ritBtnClick {
    
    [self Autoconnetct];
}

-(void)write:(paiHaoModel *)model {
    
    if (manage.stage != JWScanStageCharacteristics) {
        [WSProgressHUD showImage:nil status:@"打印机正在准备中 .."];
        return;
    }
    NSData *mainData = [[PrinterManager paiHaoModel:model] getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
            
            [WSProgressHUD showImage:nil status:@"打印成功!"];
            _DYBtn.enabled = YES;
            
            _phoneT.text = @"";
            _peopleT.text = @"";
            
            
        }else{
            NSLog(@"写入错误---:%@",error);
        }
    }];
}
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

-(void)viewWillDisappear:(BOOL)animated {

    [PronetwayYunFoodHandle shareHandle].Ordertype = @"";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
