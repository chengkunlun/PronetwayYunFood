//
//  AddAllkezhuoViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/2.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "AddAllkezhuoViewController.h"
#define ACCOUNT_MAX_CHARS 3

@interface AddAllkezhuoViewController ()<UITextFieldDelegate,selectDelegate>

@property (strong, nonatomic)NSMutableDictionary *attributes ;
@property (strong, nonatomic) UIView *bootmVC;
@property (strong, nonatomic) UIButton *dybtn;
@property (strong, nonatomic) RedBtn *kezhuobtn;
@property (strong, nonatomic) UILabel *lab;
@property (strong, nonatomic) UITextField *T1;
@property (strong, nonatomic) UITextField *T2;
@property (strong, nonatomic) UITextField *T3;
@property (strong, nonatomic) selectBtnView *selevc;
@property (nonatomic) BOOL fenquselect;
@property (strong, nonatomic) NSString *payurl;
@property (strong, nonatomic) explainView *explainView;

@end

@implementation AddAllkezhuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"批量新增桌位"];
    
    [self.view addSubview:self.bootmVC];
    [self addView];
    [self.view addSubview:self.explainView];
    
    _attributes = [NSMutableDictionary dictionary];
    _attributes[NSForegroundColorAttributeName] = RGB(66, 66, 66);
    
    _selevc.btnlab.text = _model.name;
    _fenquselect = YES;
    self.view.backgroundColor = kWhiteColor;
    
}

-(void)onpressaddKezhuo:(kezhuofenquModel *)kezhuofenquModel {
    
    _model = kezhuofenquModel;
    _selevc.btnlab.text = kezhuofenquModel.name;
    _fenquselect = YES;
}

-(UIView *)bootmVC {
    
    if (!_bootmVC) {
       
        _bootmVC = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight-kNavBarHAndStaBarH-44*newKhight, kWidth, 44*newKhight)];
        
        _bootmVC.backgroundColor = kWhiteColor;
        _kezhuobtn = [[RedBtn alloc]initWithFrame:CGRectMake(0, 0,kWidth ,44*newKhight)text:@"保 存"];
        [_kezhuobtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_bootmVC addSubview:_kezhuobtn];
        
//        _dybtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
//        _dybtn.frame = CGRectMake(0, 0, w, 44*newKhight);
//        _dybtn.layer.masksToBounds = YES;
//        _dybtn.layer.borderColor = [kRedColor CGColor];
//        _dybtn.layer.borderWidth = 0.5;
//        [_bootmVC addSubview:_dybtn];
//        [_dybtn addTarget:self action:@selector(dyBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
//        [_dybtn setTitleColor:kRedColor forState:(UIControlStateNormal)];
//        [_dybtn setTitle:@"批量打印维码" forState:(UIControlStateNormal)];
//        _dybtn.titleLabel.font = kFont(15);
    }
    return _bootmVC;
}

-(void)addView {
    
    
    _selevc  = [[selectBtnView alloc]initWithFrame:CGRectMake(15*newKwith, 20*newKhight, kWidth-30*newKwith, 44*newKhight) text:@"分区" color:kCbgColor];
    [self.view addSubview:_selevc];
    WeakType(self);
    _selevc.ClickBlock = ^{
        
        SelectViewController *seleVC = [SelectViewController new];
        seleVC.selectstr = @"客桌分区";
        seleVC.selectArr = weakself.allArr;
        seleVC.delegate = weakself;
        [weakself.navigationController pushViewController:seleVC animated:YES];
        
    };
    
    _T1 = [[UITextField alloc]initWithFrame:CGRectMake(15*newKwith, _selevc.endY+10*newKhight, kWidth-30*newKwith, 44*newKhight)];
    _T1.layer.masksToBounds = YES;
    _T1.layer.cornerRadius = 5;
    _T1.backgroundColor = kCbgColor;
    _T1.font = kFont(15);
    _T1.delegate = self;
    _T1.keyboardType = UIKeyboardTypeNumberPad;
    _T1.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" 可坐人数" attributes:_attributes];
    _T1.textColor = RGB(85, 85, 85);
    [self.view addSubview:_T1];
    
    _T2 = [[UITextField alloc]initWithFrame:CGRectMake(15*newKwith, _T1.endY+10*newKhight, 144*newKwith, 44*newKhight)];
    [self setTextfield:_T2 text:@"  输入客桌编号"];
    
    _T3 = [[UITextField alloc]initWithFrame:CGRectMake(_T2.endX+59*newKwith, _T1.endY+10*newKhight, 144*newKwith, 44*newKhight)];
    [self setTextfield:_T3 text:@"   输入客桌编号"];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_T2.endX, _T1.endY+10*newKhight, 59*newKwith, 22*newKhight)];
    lab.text = @"至";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = kFont(12);
    lab.textColor = rgba(85, 85, 85, 1);
    [self.view addSubview:lab];
    
    UIView *lin = [[UIView alloc]initWithFrame:CGRectMake(_T2.endX+5*newKwith, _T1.endY+32*newKhight, 50*newKwith, 1)];
    lin.backgroundColor = RGB(85, 85, 85);
    [self.view addSubview:lin];
    
}

-(explainView *)explainView {

    if (!_explainView) {
        _explainView = [[explainView alloc]initWithFrame:CGRectMake(_T1.X+5*newKwith, _T3.endY+30*newKhight, kWidth-30*newKwith, 0) text:@"说明 :\n1.可坐人数应大于0,默认选择上个页面选中分区.\n3.批量添加会生成多张客桌,请根据实际情况添加.\n4.编号名称由分区的第一个字母加上输入编号组成."];
    }
    return _explainView;
}


-(void)setTextfield:(UITextField *)T1 text:(NSString *)text{

    T1.layer.masksToBounds = YES;
    T1.layer.cornerRadius = 5;
    T1.backgroundColor = kCbgColor;
    T1.font = kFont(15);
    T1.textAlignment = NSTextAlignmentCenter;
    T1.keyboardType = UIKeyboardTypeNumberPad;
    T1.delegate = self;
    T1.textColor = RGB(85, 85, 85);
    [self.view addSubview:T1];
    T1.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text attributes:_attributes];

}

-(void)saveBtnClick:(UIButton *)btn {
    
    btn.enabled = NO;
    if ([self checkT]) {
        NSString *seid,*enid;
        if ([_T2.text integerValue]<[_T3.text integerValue]) {
            seid = _T2.text;
            enid = _T3.text;
        }else {
            seid = _T3.text;
            enid = _T2.text;
        }
        if (seid.length==1||enid.length==1) {
            
            seid = [NSString stringWithFormat:@"00%@",seid];
            enid = [NSString stringWithFormat:@"00%@",enid];

        }else if (seid.length==2||enid.length==2) {
            seid = [NSString stringWithFormat:@"0%@",seid];
            enid = [NSString stringWithFormat:@"0%@",enid];
        }
        NetworkManger *manger = [NetworkManger new];
        [manger pddkezhuoNumberspeople:_T1.text model:_model seid:seid enid:enid];
        manger.Addkezuofenqusuccessblock = ^{
            [self.navigationController popViewControllerAnimated:YES];
            btn.enabled = YES;
        };
        manger.Failblock = ^{
            btn.enabled = YES;
        };
    }
    
    DLog(@"保存");
}

-(BOOL)checkT {
    
    
    if (kStringIsEmpty(_T1.text)) {
        [self yaoBai:_T1];
        _kezhuobtn.enabled = YES;
        return NO;
    }
    if (kStringIsEmpty(_T2.text)) {
        
        [self yaoBai:_T2];
        _kezhuobtn.enabled = YES;

        return NO;
    }
    if (kStringIsEmpty(_T3.text)) {
        _kezhuobtn.enabled = YES;

        [self yaoBai:_T2];
        return NO;
    }
    if (_fenquselect == NO) {
        [WSProgressHUD showImage:nil status:@"请选择分区"];
        _kezhuobtn.enabled = YES;

        return NO;
    }
    if ([_T2.text isEqualToString:_T3.text]) {
        
        [WSProgressHUD showImage:nil status:@"客桌编号输入有误"];
        _kezhuobtn.enabled = YES;
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


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //判断是否超过 ACCOUNT_MAX_CHARS 个字符,注意要判断当string.leng>0
    //的情况才行，如果是删除的时候，string.length==0
    NSInteger length = textField.text.length;
    if (length >= ACCOUNT_MAX_CHARS && string.length >0)
    {
        return NO;
    }
//    if ([self validateNumber:string] == YES) {
//        return YES;
//    }else {
//        return NO;
//    }
   return YES;
    
   // return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
    NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
    NSRange range = [string rangeOfCharacterFromSet:tmpSet];
    if (range.length == 0) {
    res = NO;
    break;
      }
    i++;
 }
    return res;
}

//打印
-(void)dyBtnClick:(UIButton *)btn {
    DLog(@"打印");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
//点击换行保存
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}




- (JWPrinter *)getPrinter
{
    
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *title = [UserDefaults objectForKeyStr:kdianpuName];
    NSString *str1 = [NSString stringWithFormat:@"桌号 :%@-%@",@"I",@"001"];
    [printer appendText:title alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    
    // 二维码
    if (_payurl!=nil) {
        
        [printer appendQRCodeWithInfo:_payurl];
        
    }
        [printer appendSeperatorLine];
    
    return printer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
