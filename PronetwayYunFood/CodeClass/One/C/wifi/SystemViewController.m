//
//  SystemViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/25.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "SystemViewController.h"
#import "LoginAndRegisterViewController.h"
#import "Home_dianpuchangeViewController.h"
#import "LLSwitch.h"
#import "BluetoothListViewController.h"
#import "systemmanager.h"
@interface SystemViewController ()<UITableViewDelegate,UITableViewDataSource,LLSwitchDelegate,sysmanagerDelegate>
{
    systemmanager *sysmanager;
}

@property (strong, nonatomic) UITableView *systemTable;
@property (strong, nonatomic) LLSwitch *Systemswitch;
@property (nonatomic ) BOOL SwitchSelected;
@property (strong, nonatomic) UIButton *handlebtn;

@property (strong, nonatomic) CBPeripheral*Peripheral;

@end

@implementation SystemViewController


-(void)viewWillAppear:(BOOL)animated {

    //自动重连 --
    [sysmanager Autoconnect];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //接收blue界面来的通知
    [kNotication addObserver:self selector:@selector(informFail) name:kinformSystem object:nil];
    [kNotication addObserver:self selector:@selector(sysconnectsuccess) name:ksystemconnectedsuccess object:nil];
    
    //alloc init
    sysmanager = [systemmanager new];
    sysmanager.delegate = self;
    //扫描蓝牙 --
    [sysmanager ScanBluetooth];
    
    [self setCustomerTitle:@"系统设置"];
    [self.view addSubview:self.systemTable];
}

//失败了 --- 通知方法
-(void)informFail {
    DLog(@" ----- ");
    //删除老的
    [_Systemswitch removeFromSuperview];
    _Systemswitch = nil;
    [UserDefaults setObjectleForStr:@"NO" key:ksavebackground];
    
    //添加新的
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:1 inSection:0];
    UITableViewCell *cell = [self.systemTable cellForRowAtIndexPath:indexpath];
    [cell addSubview:self.Systemswitch];
    
    //给个提示
    [WSProgressHUD showImage:nil status:@"连接蓝牙失败"];
    
}
//连接成功 -- 通知方法
-(void)sysconnectsuccess {

    _Systemswitch.on = YES;
    
}


//自动连接搜索到蓝牙
-(void)autoShowperical:(CBPeripheral *)perpheral {

    _Peripheral = perpheral;
    [self setCustomerTitle:[NSString stringWithFormat:@"系统设置(已连接 %@)",perpheral.name]];
    if (_Systemswitch.on == YES) {
        
        DLog(@"开启后台服务");
        [sysmanager openTimer:30];
    }
    
}
//设备已断开连接
-(void)disConnectBlock:(CBPeripheral *)perpheral {

    [self setCustomerTitle:[NSString stringWithFormat:@"系统设置"]];
    sysmanager.ConnectedSuccess = NO;

}



-(LLSwitch *)Systemswitch {
    
    _Systemswitch = [[LLSwitch alloc]initWithFrame:CGRectMake(kWidth-70*newKwith, 10*newKhight, 55*newKwith, 30*newKhight)];
    _Systemswitch.onColor = kBlueColor;
    _Systemswitch.offColor = [UIColor grayColor];
    _Systemswitch.faceColor = [UIColor whiteColor];
    _Systemswitch.delegate = self;
    
    if ([[UserDefaults objectForKeyStr:ksavebackground] isEqualToString:@"YES"]) {
        _Systemswitch.on = YES;

    }else {
        _Systemswitch.on = NO;
    }
    return _Systemswitch;
}
-(void)didTapLLSwitch:(LLSwitch *)llSwitch {
    NSLog(@"start");
    
    if (_Systemswitch.on == YES) {
        //会锁屏
        [UIApplication sharedApplication].idleTimerDisabled=NO;
        DLog(@"关闭");
        [UserDefaults setObjectleForStr:@"NO" key:ksavebackground];

        //关闭定时器
        [sysmanager closeTimr];
        
        //断开连接,会清除之前保存的蓝牙
        [sysmanager disconnect:_Peripheral];
        
    }else {
        DLog(@"打开");
        //不自动锁屏
        [UIApplication sharedApplication].idleTimerDisabled=YES;
        [UserDefaults setObjectleForStr:@"YES" key:ksavebackground];

        if (sysmanager.ConnectedSuccess == YES ) {
            
            //打开定时器
            [sysmanager openTimer:30];
            //自动连接
           // [sysmanager Autoconnect];
            
         //   if (_Peripheral!=nil) {
           //     [sysmanager connectPerprial:_Peripheral];
            //}
        }else {
        
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                BluetoothListViewController *bluVC = [BluetoothListViewController new];
                bluVC.deviceArray = sysmanager.dataSource;
                bluVC.rissArr = sysmanager.rssisArray;
                bluVC.selectStr = @"system";
                bluVC.manager = sysmanager.manage;
                [self.navigationController pushViewController:bluVC animated:YES];
                
            });
        }
    }
}

-(void)handleClick:(UIButton *)btn {
    btn.enabled = NO;
    
    
    DLog(@"你好");
}

-(UIButton *)handlebtn {

    if (!_handlebtn) {
        _handlebtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _handlebtn.frame = _Systemswitch.frame;
        [_handlebtn addTarget:self action:@selector(handleClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _handlebtn;
}


- (void)animationDidStopForLLSwitch:(LLSwitch *)llSwitch {
    NSLog(@"stop");

}


-(UITableView *)systemTable {

    if (!_systemTable) {
        _systemTable = [[UITableView alloc]initWithFrame:kBounds style:(UITableViewStyleGrouped)];
        _systemTable.delegate = self;
        _systemTable.dataSource = self;
        _systemTable.rowHeight = 50*newKhight;
        [_systemTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"systemcell"];
    }
    return _systemTable;
}
//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (section == 0) {
        
        return 2;
    }else {
    
        return 1;
    }
}
//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"systemcell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"systemcell"];
    }
    cell.textLabel.font = kFont(15);
    
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = rgba(85, 85, 85, 1);
        cell.textLabel.text = @"修改密码";
        
    }else if (indexPath.row == 1) {
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(125*newKwith, 0, kWidth- 10*newKhight, 50*newKhight)];
        lable.textColor = rgba(151, 151, 151, 1);
        lable.font = kFont(12);
        lable.text = @"(开启后订单会在后台打印)";
        [cell addSubview:lable];
        
    cell.textLabel.text = @"指定为本机打印";
    cell.textLabel.textColor = rgba(85, 85, 85, 1);
        [cell addSubview:self.Systemswitch];
       // [cell addSubview:self.handlebtn];
    }
    if(indexPath.section == 1){
        cell.textLabel.font = kFont(16);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = kRedColor;
        cell.textLabel.text = @"退出登录/切换账号";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 15*newKhight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        Alert *alert = [Alert new];
        [alert alert:@"是否确定退出登?退出后需要重新登录!"];
        alert.alert.OKBlock = ^{
            [UserDefaults setObjectleForStr:@"NO" key:kloginStatuekey];
            LoginAndRegisterViewController *logVC = [LoginAndRegisterViewController new];
            [self.navigationController pushViewController:logVC animated:YES];
        };
    }else if (indexPath.section == 0 && indexPath.row == 0){
    
        if (![ValidateUtil checkuserType]) {
        
            [WSProgressHUD showImage:nil status:@"暂无权限!"];
            return;
        }
        
        DLog(@"修改密码");
        
        Alert *alert = [Alert new];
        [alert alert:@"是否确定修改密码?修改后需要重新登录!"];
        alert.alert.OKBlock = ^{
            
            Home_dianpuchangeViewController *dpchangeVC = [Home_dianpuchangeViewController new];
            dpchangeVC.selectStr = @"system";
            [self.navigationController pushViewController:dpchangeVC animated:YES];
        };
    }
}

//移除通知
-(void)dealloc {

    [kNotication removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
