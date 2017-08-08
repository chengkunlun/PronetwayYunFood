//
//  changekezhuoViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "changekezhuoViewController.h"
#import "SelectViewController.h"
#import "CodeModel.h"
@interface changekezhuoViewController ()<selectDelegate,UITextFieldDelegate>
{

    JWBluetoothManage * manage;

}
@property (strong, nonatomic)NSMutableDictionary *attributes ;
@property (strong, nonatomic) NSString *payurl;

//蓝牙数组
@property (nonatomic, strong) NSMutableArray * dataSource; //设备列表
@property (nonatomic, strong) NSMutableArray * rssisArray; //信号强度 可选择性使用
@property (strong, nonatomic)UIButton *rightBtn;
@property (assign)  BOOL ConnectedSuccess; //是否连接成功
@property (strong, nonatomic) NSMutableArray *codeArr;
@property (strong, nonatomic) NSMutableArray *adddeskArr;
@property (strong, nonatomic)  NSString *desktableid;
@property (strong, nonatomic) explainView *explainView;
@property (strong, nonatomic) UIView *bgview;
@end

@implementation changekezhuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bootmVC];
    [self addView];

    
    //蓝牙自动重连
    [self ScanBluetooth];

    _attributes = [NSMutableDictionary dictionary];
    _attributes[NSForegroundColorAttributeName] = RGB(0x85, 0x85, 0x85);
    
    if ([self.selectStr isEqualToString:@"change"]) {
        

        [self setCustomerTitle:@"修改桌位"];

    }else {
        [_dybtn setTitle:@"保存并打印此桌二维码" forState:(UIControlStateNormal)];

        [self setCustomerTitle:@"新增桌位"];
    
    }

    self.lab.text = self.model.name;
    self.view.backgroundColor = kWhiteColor;

    [self setupnavbar];
    
    [self.view addSubview:self.explainView];
    
}

-(explainView *)explainView {
    
    if (!_explainView) {
        _explainView = [[explainView alloc]initWithFrame:CGRectMake(_bgview.X, _bgview.endY+30*newKhight, kWidth-30*newKwith, 0) text:@"说明 :\n1.可坐人数应大于0,默认选择上个页面选中分区.\n2.编号名称由分区的第一个字母加上输入编号组成."];
    }
    return _explainView;
}

-(NSMutableArray *)codeArr {

    if (!_codeArr) {
        _codeArr = [[NSMutableArray alloc]init];
    }
    return _codeArr;
}
-(NSMutableArray *)adddeskArr {

    if (!_adddeskArr) {
        _adddeskArr = [[NSMutableArray alloc]init];
    }
    return _adddeskArr;
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

-(void)onpressaddKezhuo:(kezhuofenquModel *)kezhuofenquModel {

    _model = kezhuofenquModel;
    _lab.text = _model.name;

}

-(UIView *)bootmVC {
    
    if (!_bootmVC) {
        CGFloat w = kWidth/2;
        _bootmVC = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight-kNavBarHAndStaBarH-44*newKhight, kWidth, 44*newKhight)];
        
        _bootmVC.backgroundColor = kWhiteColor;
        _kezhuobtn = [[RedBtn alloc]initWithFrame:CGRectMake(w, 0,w ,44*newKhight)text:@"保 存"];
        [_kezhuobtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_bootmVC addSubview:_kezhuobtn];
        
        _dybtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
        _dybtn.frame = CGRectMake(0, 0, w, 44*newKhight);
        _dybtn.layer.masksToBounds = YES;
        _dybtn.layer.borderColor = [kRedColor CGColor];
        _dybtn.layer.borderWidth = 0.5;
        [_bootmVC addSubview:_dybtn];
        [_dybtn addTarget:self action:@selector(dyBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_dybtn setTitleColor:kRedColor forState:(UIControlStateNormal)];
        [_dybtn setTitle:@"打印此桌二维码" forState:(UIControlStateNormal)];
        _dybtn.titleLabel.font = kFont(15);
    }
    
    return _bootmVC;
}


-(void)addView {

    NSArray *arr = @[@"  课桌编号",@"  可坐人数"];
    for (int i = 0; i<2; i++) {
        
        UITextField *kezhuoT = [[UITextField alloc]initWithFrame:CGRectMake(15*newKwith, 20*newKhight+i*(54), kWidth-30*newKwith, 44*newKhight)];
        
        kezhuoT.tag = kYun_dianpu_kezuoT+i;
        kezhuoT.layer.masksToBounds = YES;
        kezhuoT.layer.cornerRadius = 5;
        kezhuoT.backgroundColor = kCbgColor;
        kezhuoT.font = kFont(15);
        if (i == 0) {
            kezhuoT.text = _kezhuoModel.numid;
        }else {
            kezhuoT.text = _kezhuoModel.seatnum;
        }
        kezhuoT.keyboardType = UIKeyboardTypeNumberPad;

        kezhuoT.textColor = RGB(85, 85, 85);
        [self.view addSubview:kezhuoT];
        kezhuoT.delegate = self;
        kezhuoT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:arr[i] attributes:_attributes];
    }
    
    _bgview = [[UIView alloc]initWithFrame:CGRectMake(15*newKhight, 20*newKhight+2*(54), kWidth-30*newKwith, 44*newKhight)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1; //手指数
    _bgview.layer.masksToBounds = YES;
    _bgview.layer.cornerRadius = 5;
    [_bgview addGestureRecognizer:tap];
    
    _bgview.backgroundColor = kCbgColor;
    [self.view addSubview:_bgview];
    
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(10*newKwith, 0, kWidth-30*newKwith, 44*newKhight)];
    _lab.text = @"分区";
    _lab.textColor = RGB(85, 85, 85);
    _lab.font = kFont(15);
    [_bgview addSubview:_lab];
    
    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth-45*newKwith, _bgview.Y+18*newKhight, 14*newKwith, 8*newKhight)];
    arrow.image = kimage(@"Yun_home_addCai_jiantou");
    [self.view addSubview:arrow];
}

-(void)saveBtnClick:(UIButton *)btn {

    UITextField *T1 = (UITextField *)[self.view viewWithTag:kYun_dianpu_kezuoT];
    UITextField *T2 = (UITextField *)[self.view viewWithTag:kYun_dianpu_kezuoT+1];
    if ([self.selectStr isEqualToString:@"change"]) {
      if ([self checkT]) {
          DLog(@"修改");
          NSString *numid;
          if (T1.text.length == 1) {
              numid = [NSString stringWithFormat:@"00%@",T1.text];
          }else if (T1.text.length == 2) {
              numid = [NSString stringWithFormat:@"0%@",T1.text];
          }
          
          NetworkManger *manger = [NetworkManger new];
          [manger changeKezhuo:_model.sid seatnum:T2.text numid:numid sid:_kezhuoModel.sid oldnumid:_kezhuoModel.numid oldzoneid:_kezhuoModel.zoneid];
          manger.Addkezuofenqusuccessblock = ^{
              
              //发通知成功添加了数据
              [self.navigationController popViewControllerAnimated:YES];
              
          };
       }
    }else { //新增课桌
    
        if ([self checkT]) {
            NSString *numid;
            if (T1.text.length == 1) {
                numid = [NSString stringWithFormat:@"00%@",T1.text];
            }else if (T1.text.length == 2) {
                numid = [NSString stringWithFormat:@"0%@",T1.text];
            }
            NetworkManger *manger = [NetworkManger new];
            [manger addkezhuoNumbers:numid people:T2.text fenqu:@"" model:_model];
            manger.Addkezuofenqusuccessblock = ^{
                
                //发通知成功添加了数据
                [self.navigationController popViewControllerAnimated:YES];
                
            };
        }
    }
    DLog(@"保存");
}

-(BOOL)checkT {

    UITextField *T1 = (UITextField *)[self.view viewWithTag:kYun_dianpu_kezuoT];
    UITextField *T2 = (UITextField *)[self.view viewWithTag:kYun_dianpu_kezuoT+1];
    if (kStringIsEmpty(T1.text)) {
        [self yaoBai:T1];
        _dybtn.enabled = YES;
        return NO;
    }
    if (kStringIsEmpty(T2.text)) {
        _dybtn.enabled = YES;
        [self yaoBai:T2];
        return NO;
    }
    return YES;
}

-(void)yaoBai:(UITextField *)textfield {

    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.duration = 0.2;
    anim.repeatCount = 2;
    anim.values = @[@-20, @20, @-20];
    [textfield.layer addAnimation:anim forKey:nil];
    
}


//选择分区 -- 课桌
-(void)tapClick:(UITapGestureRecognizer *)tap {

    SelectViewController *seleVC = [SelectViewController new];
    seleVC.selectstr = @"客桌分区";
    seleVC.selectArr = self.kezhuoArr;
    seleVC.delegate = self;
    [self.navigationController pushViewController:seleVC animated:YES];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}
//点击换行保存
-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string // return NO to not change text
{
    //判断是否超过 ACCOUNT_MAX_CHARS 个字符,注意要判断当string.leng>0
    //的情况才行，如果是删除的时候，string.length==0
    NSInteger length = textField.text.length;
    if (length >= ACCOUNT_MAX_CHARS && string.length >0)
    {
        return NO;
    }
    return YES;
}


//打印
-(void)dyBtnClick:(UIButton *)btn {
    
    DLog(@"打印");
    
    if ([self.selectStr isEqualToString:@"change"]) {//修改
    
        [self connectBlueAndWrite];

    }else {//新增 打印
    
       //1 先保存,然后添加
        if ([self checkT]) {
            
            UITextField *T1 = (UITextField *)[self.view viewWithTag:kYun_dianpu_kezuoT];
            UITextField *T2 = (UITextField *)[self.view viewWithTag:kYun_dianpu_kezuoT+1];
            NSString *numid;
            if (T1.text.length == 1) {
                numid = [NSString stringWithFormat:@"00%@",T1.text];
            }else if (T1.text.length == 2) {
                numid = [NSString stringWithFormat:@"0%@",T1.text];
            }
            
            [self addkezhuoNumbers:numid people:T2.text fenqu:@"" model:_model];
        }
    }
}

-(void)gotoBlueVC {

    BluetoothListViewController *blueVC = [BluetoothListViewController new];
    blueVC.selectStr = @"Yun_desk_changeManger";
    blueVC.model = self.kezhuoModel;
    blueVC.rissArr = self.rssisArray;
    blueVC.deviceArray = self.dataSource;
    blueVC.manager = manage;
    [self.navigationController pushViewController:blueVC animated:YES];
    

}
-(void)connectBlueAndWrite {

    if (_ConnectedSuccess == NO) {//首次进入打印

        [self gotoBlueVC];
        
    }else {//
        
        [self reloadJosnForgetcodeUrl:self.kezhuoModel.sid];
        
    }
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
                _payurl = [NSString stringWithFormat:@"%@%@%@",kIpandPort,kkezhuoCode3,model.ordercode];
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
    
    if (manage.stage != JWScanStageCharacteristics) {
        [WSProgressHUD showImage:nil status:@"打印机正在准备中 .."];
        return;
    }
    NSData *mainData = [[PrinterManager desk_changeManagerPrinter:self.kezhuoModel payUrl:payUrl ] getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
            
                [WSProgressHUD showImage:nil status:@"打印成功!"];
                [self.navigationController popToRootViewControllerAnimated:YES];
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


//添加桌位
-(void)addkezhuoNumbers:(NSString *)deskNumbers people:(NSString *)people fenqu:(NSString *)fenqu model:(kezhuofenquModel *)model {
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",kIpandPort,kTJkezhuo1,deskNumbers,kTJkezhuo2,[UserDefaults objectForKeyStr:ksid],kTJkezhuo3,people,kTJkezhuo4,model.sid];
    
    DLog(@"添加客桌 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"添加成功"];
            [kNotication postNotificationName:@"reloadkezuo" object:nil];//发通知
            
            NSArray *arr = dic[@"eimdata"];
            for (NSDictionary *dict in arr) {
                
            kezhuoModel *model = [kezhuoModel setUpModelWithDictionary:dict];
            [self.adddeskArr addObject:model];
                
            }
            
            NSString *tableid = [self lookTableid:self.adddeskArr];
            
            if (!kStringIsEmpty(tableid)) {
                
                if (_ConnectedSuccess == NO) {
                    
                    if (self.kezhuoModel!=nil) {
                        
                        [self gotoBlueVC];

                    }else {
                    
                [WSProgressHUD showImage:nil status:@"查找客桌失败,请返回至客桌管理界面打印"];
                    }
                }else {
                
                    [self reloadJosnForgetcodeUrl:tableid];

                }
            }
            
        }else if ([dic[@"result"] isEqualToString:@"11"]) {
            
            [WSProgressHUD showImage:nil status:@"添加客桌名称重复"];
        }else {
            
            [WSProgressHUD showImage:nil status:@"添加失败"];
        }
        
        
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

//根据分区号 和numbid 去找客桌tableid

-(NSString *)lookTableid:(NSMutableArray *)arr
{
    UITextField *T1 = (UITextField *)[self.view viewWithTag:kYun_dianpu_kezuoT];
    NSString *numid;
    if (T1.text.length == 1) {
        numid = [NSString stringWithFormat:@"00%@",T1.text];
    }else if (T1.text.length == 2) {
        numid = [NSString stringWithFormat:@"0%@",T1.text];
    }
    
    WeakType(self);
    [arr enumerateObjectsUsingBlock:^(kezhuoModel *kezuomodel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([kezuomodel.zoneid isEqualToString:weakself.model.sid] && [kezuomodel.numid isEqualToString:numid] ) {
            
            _desktableid = kezuomodel.sid;
            
            self.kezhuoModel = kezuomodel;
        }
        
    }];

    return _desktableid;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
