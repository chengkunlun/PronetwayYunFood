//
//  AdddianpuViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "AdddianpuViewController.h"
#import "datepickView.h"
#import "Home_dianpuViewController.h"
#import "Home_dianpuchangeViewController.h"
@interface AdddianpuViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,datepickerDelegate>
@property (strong, nonatomic) UITableView *adddianpuTab;
@property (strong, nonatomic)  NSArray *arr;
@property (strong, nonatomic)NSMutableDictionary *attributes;
@property (strong, nonatomic) selectBtnView *selevc1;
@property (strong, nonatomic) selectBtnView *selevc2;
@property (strong, nonatomic) RedBtn *okBtn;

@property (strong, nonatomic) datepickView *begaindate;
@property (strong, nonatomic) datepickView *enddate;
@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *endTime;
@property (strong, nonatomic) NSArray *ritArr;

@property (nonatomic) BOOL selected;

@end

@implementation AdddianpuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  =kCbgColor;
    
    if ([self.selectstr isEqualToString:@"home"]) {//从home进来的
        
        [self setCustomerTitle:@"新增店铺"];
        _arr = @[@"店铺名称",@"店铺电话",@"店铺地址",@"营业账号",@"设置密码"];


    }else if ([self.selectstr isEqualToString:@"change"]){//修改
        [self setCustomerTitle:@"修改店铺信息"];
        
        _ritArr = @[@"店铺名称",@"店铺电话",@"开始营业时间",@"结束营业时间",@"店铺地址",@"营业账号"];
        DLog(@"%@",self.ChangeArr);

    }else {//新增
        [self setCustomerTitle:@"新增店铺"];
        _arr = @[@"店铺名称",@"店铺电话",@"店铺地址",@"营业账号",@"设置密码"];
    }
    
    [self.view addSubview:self.adddianpuTab];
    
    _attributes = [NSMutableDictionary dictionary];
   _attributes[NSForegroundColorAttributeName] = RGB(0x89, 0x89, 0x89);

    [self.view addSubview:self.okBtn];
    
    _selected = YES;
    
}

//返回按钮
-(void)backAction {

    if ([self.selectstr isEqualToString:@"home"]) {
        
//        if ([self checkT]) {
//            
//            
//        }else {
//        
//            
//        }
//        
        [self.navigationController popViewControllerAnimated:YES];

//        Home_dianpuViewController *home_dianVC = [Home_dianpuViewController new];
//        home_dianVC.selectStr = @"home";
//        [self.navigationController pushViewController:home_dianVC animated:YES];
//        
    }else {
    
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//自定义时间选择器代理
-(void)onpress:(NSString *)selectTime datepicker:(UIDatePicker *)datepicker {

    UIDatePicker *datepic = (UIDatePicker *)[self.view viewWithTag:200];
    if ([datepicker isEqual:datepic]) {
        
        _selevc1.btnlab.text = selectTime;
        _startTime = _selevc1.btnlab.text;
    }else {
    
        _selevc2.btnlab.text = selectTime;
        _endTime = _selevc2.btnlab.text;

    }
    
    DLog(@"+++++");
  //  _selevc1.btnlab.text = selectTime;

}

-(RedBtn *)okBtn {

    if (!_okBtn) {
       
        NSString *btnlabel;
        if ([self.selectstr isEqualToString:@"home"]) {//从home进入--添加
            btnlabel = @"确认";
        }else if ([self.selectstr isEqualToString:@"change"]) {//修改
            btnlabel = @"保存";
        }else {//新增
            btnlabel = @"确认";
        }
         _okBtn = [[RedBtn alloc]initWithFrame:CGRectMake(0, kHeight-44*newKhight-kNavBarHAndStaBarH, kWidth, 44*newKhight) text:btnlabel];
        [_okBtn addTarget:self action:@selector(okBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _okBtn;
}

-(UITableView *)adddianpuTab {

    if (!_adddianpuTab) {
        
        if ([self.selectstr isEqualToString:@"change"]) {
             _adddianpuTab  = [[UITableView alloc]initWithFrame:CGRectMake(15*newKwith, 10*newKhight, kWidth-30*newKwith, 271*newKhight+54*newKhight)];
        }else {
        
             _adddianpuTab  = [[UITableView alloc]initWithFrame:CGRectMake(15*newKwith, 10*newKhight, kWidth-30*newKwith, 281*newKhight)];
             [self bootmView];

        }
        _adddianpuTab.delegate  = self;
        _adddianpuTab.dataSource = self;
        //_adddianpuTab.rowHeight = 44*newKhight;
        _adddianpuTab.backgroundColor = kCbgColor;
        _adddianpuTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_adddianpuTab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"addtabcell"];
    }
    return _adddianpuTab;
}

//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([self.self.selectstr isEqualToString:@"change"]) {
        
        return _ChangeArr.count;
    }
    
        return _arr.count;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  1;
}
//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addtabcell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"addtabcell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 5;
    UITextField *AddT;
    if ([self.selectstr isEqualToString:@"change"]) {
   AddT  = [[UITextField alloc]initWithFrame:CGRectMake(10*newKhight, 0, kWidth-120*newKwith, 44*newKhight)];
    }else {
    
        AddT = [[UITextField alloc]initWithFrame:CGRectMake(10*newKhight, 0, kWidth-50*newKwith, 44*newKhight)];
    }
    AddT.clearButtonMode  = 1;
    AddT.font = kFont(15);
    
    if (indexPath.section == 1) {
        AddT.keyboardType = UIKeyboardTypeNumberPad;
    }
    AddT.delegate = self;
    AddT.tag = kYun_dianpu_adddianpu+indexPath.section;
    

    if ([self.selectstr isEqualToString:@"change"]) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-105*newKwith, 0, 90*newKwith, 44*newKhight)];
        lab.textColor = RGB(122, 122, 122);
        lab.text = _ritArr[indexPath.section];
        lab.font = kFont(12);
        [cell addSubview:lab];
        if (indexPath.section != 2||indexPath.section!=3) {
            AddT.text = _ChangeArr[indexPath.section];
            [cell addSubview:AddT];

        }
        AddT.textColor = RGB(85, 85, 85);
        
        if (indexPath.section == 2) {
            
            _selevc1 = [[selectBtnView alloc]initWithFrame:CGRectMake(0, 0, cell.width, 44*newKhight) text:self.ChangeArr[indexPath.section] color:kWhiteColor];
            WeakType(self);
            weakself.selevc1.ClickBlock = ^{
                UITextField *T3 = (UITextField *)[weakself.view viewWithTag: kYun_dianpu_adddianpu+1];
                UITextField *T4 = (UITextField *)[weakself.view viewWithTag: kYun_dianpu_adddianpu+2];
                
                [T3 resignFirstResponder];
                [T4 resignFirstResponder];
                
                if (_selected == YES) {
                    
                    datepickView * begaindate = [[datepickView alloc]initWithFrame:CGRectMake(0,kHeight-kNavBarHAndStaBarH, kWidth, 260*newKhight)];
                    begaindate.delegate = weakself;
                    [weakself.view addSubview:begaindate];
                    begaindate.timelab.text = [DateUtil getCurrentMutil];
                    begaindate.datepicker.tag = 200;
                    
                    [Animations moveUp:begaindate andAnimationDuration:0.5 andWait:YES andLength:260*newKhight];
                    _selected = NO;
                }
                
            };
            [cell addSubview:_selevc1];

            
        }else if (indexPath.section == 3) {
        
        _selevc2 = [[selectBtnView alloc]initWithFrame:CGRectMake(0, 0, cell.width, 44*newKhight) text:self.ChangeArr[indexPath.section] color:kWhiteColor];
            WeakType(self);
            _selevc2.ClickBlock = ^{
                UITextField *T3 = (UITextField *)[weakself.view viewWithTag: kYun_dianpu_adddianpu+1];
                UITextField *T4 = (UITextField *)[weakself.view viewWithTag: kYun_dianpu_adddianpu+2];
                [T3 resignFirstResponder];
                [T4 resignFirstResponder];
                
                if (_selected == YES) {
            
                    datepickView * begaindate = [[datepickView alloc]initWithFrame:CGRectMake(0,kHeight-kNavBarHAndStaBarH, kWidth, 260*newKhight)];
                    begaindate.delegate = weakself;
                    [weakself.view addSubview:begaindate];
                    begaindate.datepicker.tag = 201;
                    
                    [Animations moveUp:begaindate andAnimationDuration:0.5 andWait:YES andLength:260*newKhight];
                    [weakself.view addSubview:weakself.enddate];
                    _selected = NO;
                }
            };
            [cell addSubview:_selevc2];

        }else if (indexPath.section == _ritArr.count-1) {
            
            UIImageView *imgVC = [[UIImageView alloc]initWithFrame:CGRectMake(cell.width-25*newKwith, 18*newKhight, 14*newKwith, 8*newKhight)];
            imgVC.image = kimage(@"Yun_home_addCai_jiantou");
            [cell addSubview:imgVC];
            
            imgVC.transform = CGAffineTransformMakeRotation(-90 *M_PI / 180.0);
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
//            tap.numberOfTapsRequired = 1;
//            tap.numberOfTouchesRequired = 1;
//            [imgVC addGestureRecognizer:tap];
            AddT.enabled = NO;
           // [AddT resignFirstResponder];
            
        }
        
    }else {
        [cell addSubview:AddT];
         AddT.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_arr[indexPath.section] attributes:_attributes];
    }
    
    return cell;
    
}

//tableview的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([self.selectstr isEqualToString:@"change"]) {
        
        if (indexPath.section == _ritArr.count-1) {
            
            DLog(@"修改密码");
            Home_dianpuchangeViewController *dianpuVC = [Home_dianpuchangeViewController new];
            dianpuVC.model = self.model;
            [self.navigationController pushViewController:dianpuVC animated:YES];
            
        }
        
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 10*newKhight;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *VC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 10*newKhight)];
    VC.backgroundColor  =kCbgColor;
    return VC;
}
//新增
-(void)bootmView {

   _selevc1 = [[selectBtnView alloc]initWithFrame:CGRectMake(15*newKwith, _adddianpuTab.endY, kWidth-30*newKwith, 44*newKhight) text:@"开始营业时间" color:kWhiteColor];
    WeakType(self);
    weakself.selevc1.ClickBlock = ^{
        UITextField *T3 = (UITextField *)[weakself.view viewWithTag: kYun_dianpu_adddianpu+2];
        UITextField *T4 = (UITextField *)[weakself.view viewWithTag: kYun_dianpu_adddianpu+3];
        [T3 resignFirstResponder];
        [T4 resignFirstResponder];

        if (_selected == YES) {
            
            datepickView * begaindate = [[datepickView alloc]initWithFrame:CGRectMake(0,kHeight-kNavBarHAndStaBarH, kWidth, 260*newKhight)];
            begaindate.delegate = weakself;
            begaindate.timelab.text = [DateUtil getCurrentMutil];//当前时间
            _startTime = [DateUtil getCurrentMutil];
            [weakself.view addSubview:begaindate];
            begaindate.datepicker.tag = 200;
            [Animations moveUp:begaindate andAnimationDuration:0.5 andWait:YES andLength:260*newKhight];
            _selected = NO;
        }
       
    };
    [self.view addSubview:_selevc1];
    
    _selevc2 = [[selectBtnView alloc]initWithFrame:CGRectMake(15*newKwith, _selevc1.endY+10*newKhight, kWidth-30*newKwith, 44*newKhight) text:@"结束营业时间" color:kWhiteColor];
    _selevc2.ClickBlock = ^{
        UITextField *T3 = (UITextField *)[weakself.view viewWithTag: kYun_dianpu_adddianpu+2];
        UITextField *T4 = (UITextField *)[weakself.view viewWithTag: kYun_dianpu_adddianpu+3];
        [T3 resignFirstResponder];
        [T4 resignFirstResponder];
    
        if (_selected == YES) {
            
            datepickView * begaindate = [[datepickView alloc]initWithFrame:CGRectMake(0,kHeight-kNavBarHAndStaBarH, kWidth, 260*newKhight)];
            begaindate.delegate = weakself;
            begaindate.timelab.text = [DateUtil getCurrentMutil];//当前时间
            _endTime = [DateUtil getCurrentMutil];
            [weakself.view addSubview:begaindate];
            begaindate.datepicker.tag = 201;
            
            [Animations moveUp:begaindate andAnimationDuration:0.5 andWait:YES andLength:260*newKhight];
            
            [weakself.view addSubview:weakself.enddate];
            
            _selected = NO;
        }
    };
    [self.view addSubview:_selevc2];
    //_selevc1.btnlab.text = _startTime;
   // _selevc2.btnlab.text = _endTime;

}

-(void)onpressOkBtnClick {

    _selected = YES;
    
}
-(void)onpressCanselBtnClick {

    _selected = YES;
}

-(BOOL)checkT {

    UITextField *T1 = (UITextField *)[self.view viewWithTag: kYun_dianpu_adddianpu];
    UITextField *T2 = (UITextField *)[self.view viewWithTag: kYun_dianpu_adddianpu+1];
    UITextField *T3 = (UITextField *)[self.view viewWithTag: kYun_dianpu_adddianpu+2];
    UITextField *T4 = (UITextField *)[self.view viewWithTag: kYun_dianpu_adddianpu+3];
    UITextField *T5 = (UITextField *)[self.view viewWithTag: kYun_dianpu_adddianpu+4];
    
    if (kStringIsEmpty(T1.text)) {
        [self yaopai:T1];
        return NO;
    }
    if (kStringIsEmpty(T2.text)) {
        [self yaopai:T2];
        return NO;
    }if (![ValidateUtil checkNumber:T2.text]) {
        
        [WSProgressHUD showImage:nil status:@"手机号有误"];
        return NO;
    }
    if (kStringIsEmpty(T3.text)) {
        [self yaopai:T3];
        return NO;
    }
    if (kStringIsEmpty(T4.text)) {
            [self yaopai:T4];
            return NO;
    }
    if (kStringIsEmpty(T5.text)) {
            [self yaopai:T5];
            return NO;
    }
    
    return YES;
}

-(datepickView *)begaindate {

        _begaindate = [[datepickView alloc]initWithFrame:CGRectMake(0,kHeight-kNavBarHAndStaBarH, kWidth, 260*newKhight)];
        self.begaindate.delegate = self;
        [Animations moveUp:self.begaindate andAnimationDuration:0.5 andWait:NO andLength:260*newKhight];
    return _begaindate;
}

-(datepickView *)enddate {
    
    if (!_enddate) {
        
        _enddate = [[datepickView alloc]initWithFrame:CGRectMake(0,kHeight-kNavBarHAndStaBarH+260*newKhight, kWidth, 260*newKhight)];
        self.enddate.delegate = self;
        [Animations moveUp:self.enddate andAnimationDuration:0.5 andWait:NO andLength:260*newKhight];
    }
    return _enddate;
}

//确认
-(void)okBtnClick:(UIButton *)btn {
    
    if ([self checkT]) {
        
        if ([self.selectstr isEqualToString:@"home"]) {//从home进来的
            
            //添加店铺
            DLog(@"添加");
            [self reloadJosnForadddianpu];
            
        }else if ([self.selectstr isEqualToString:@"change"]){//修改
            //修改店铺
            DLog(@"修改");
            [self reloadUpdatedianpu];
            
        }else {//新增
        //添加店铺
            DLog(@"添加 ..");
            [self reloadJosnForadddianpu];
        }
    }
}

-(void)yaopai:(UITextField *)textfield {
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];     anim.duration = 0.2;
    anim.repeatCount = 2;
    anim.values = @[@-20, @20, @-20];
    [textfield.layer addAnimation:anim forKey:nil];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}


//解析数据,添加店铺--
-(void)reloadJosnForadddianpu {
    
    UITextField *T1 = (UITextField *)[self.view viewWithTag: kYun_dianpu_adddianpu];
    UITextField *T2 = (UITextField *)[self.view viewWithTag: kYun_dianpu_adddianpu+1];
    UITextField *T3 = (UITextField *)[self.view viewWithTag: kYun_dianpu_adddianpu+2];
    UITextField *T4 = (UITextField *)[self.view viewWithTag: kYun_dianpu_adddianpu+3];
    UITextField *T5 = (UITextField *)[self.view viewWithTag: kYun_dianpu_adddianpu+4];

    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",kIpandPort,kadddianpu1,T1.text,kadddianpu2,T2.text,kadddianpu3,_startTime,kadddianpu4,_endTime,kadddianpu5,T3.text,kadddianpu6,T4.text,kadddianpu7,T5.text,kadddianpu8,[UserDefaults objectForKeyStr:kpid]];
    DLog(@"添加店铺的url是%@",url);
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            NSArray *arr = dic[@"eimdata"];
            if (arr.count!=0) {
                
                if (_delegate && [_delegate respondsToSelector:@selector(adddianpuArr:)]) {
                    [_delegate adddianpuArr:arr];
                }
                //添加成功 -- 
                [UserDefaults setObjectleForStr:@"YES" key:kshowMengbanHome];
            }
            //添加成功
            if ([self.selectstr isEqualToString:@"home"]) {
                //返回 -
                Home_dianpuViewController *home_dianVC = [Home_dianpuViewController new];
                home_dianVC.selectStr = @"home";
                [self.navigationController pushViewController:home_dianVC animated:YES];
            }else {
                [self.navigationController popViewControllerAnimated:YES];
            }
            //发通知请求数据
           // [kNotificationCenter postNotificationName:@"reloadJosnforAlldianpu" object:nil];
        }else if ([dic[@"result"] isEqualToString:@"9"]) {
            [WSProgressHUD showImage:nil status:@"子账号重复"];//应该可以重复的吧
        }
        else {
            [WSProgressHUD showImage:nil status:@"添加失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

//修改店铺信息
-(void)reloadUpdatedianpu {

    UITextField *T1 = (UITextField *)[self.view viewWithTag: kYun_dianpu_adddianpu];
    UITextField *T2 = (UITextField *)[self.view viewWithTag: kYun_dianpu_adddianpu+1];
    UITextField *T3 = (UITextField *)[self.view viewWithTag: kYun_dianpu_adddianpu+4];
    
    if (kStringIsEmpty(_selevc1.btnlab.text)||kStringIsEmpty(_selevc2.btnlab.text)) {
        
        [WSProgressHUD showImage:nil status:@"开始或者结束营业时间为空"];
        return ;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",kIpandPort,kchangeadddianpu1,T1.text,kchangeadddianpu2,T2.text,kchangeadddianpu5,T3.text,@"&sid=",[UserDefaults objectForKeyStr:ksid],kchangeadddianpu3,_selevc1.btnlab.text,kchangeadddianpu4,_selevc2.btnlab.text,kadddianpu8,[UserDefaults objectForKeyStr:kpid]];
    DLog(@"修改店铺的url是%@",url);
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            //发通知请求数据
           // [kNotificationCenter postNotificationName:@"reloadJosnforAlldianpu" object:nil];
            [self.navigationController popViewControllerAnimated:YES];

        }else {
            [WSProgressHUD showImage:nil status:@"修改失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        
        DLog(@"%@",error);
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
