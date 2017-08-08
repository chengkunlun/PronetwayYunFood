//
//  AddChongViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/19.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "AddChongViewController.h"
#import "ZLTimeView.h"
@interface AddChongViewController ()<ZLTimeViewDelegate>
@property (strong, nonatomic) RedBtn *addBtn;

@property (strong, nonatomic) UITextField * ChongT;
@property (strong, nonatomic) UITextField * SongT;
@property (strong, nonatomic) NSMutableDictionary *attributes;
@property (strong, nonatomic) NSString *start;
@property (strong, nonatomic) NSString *end;


@end

@implementation AddChongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kWhiteColor;
    _attributes = [NSMutableDictionary dictionary];
    // 设置富文本对象的颜色
    _attributes[NSForegroundColorAttributeName] = RGB(0x85, 0x85, 0x85);
    
    [self addView];
    [self setCustomerTitle:@"新增"];
    
    [self.view addSubview:self.addBtn];
    // Do any additional setup after loading the view.
}


-(void)addView {

    for (int i = 0; i<3; i++) {
        UITextField *T = [[UITextField alloc]initWithFrame:CGRectMake(15*newKhight, 15*newKhight+i*(59*newKhight), kWidth-30*newKwith, 44*newKhight)];
        T.clearButtonMode = 1;
        T.keyboardType = UIKeyboardTypeDecimalPad;
        T.font  =kFont(15);
        T.borderStyle = UITextBorderStyleRoundedRect;
        T.tag = kYun_huiyuanchongzhiTag+i;
        T.backgroundColor = kCbgColor;
        [self.view addSubview:T];
        if (i == 0) {
        T.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"充值金额" attributes:_attributes];
        }else if (i == 1){
        T.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"赠送金额" attributes:_attributes];
        }else {
        T.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"总送金额" attributes:_attributes];
        }
    }
    ZLTimeView *cklTime = [[ZLTimeView alloc]initWithFrame:CGRectMake(15*newKwith, 177*newKhight+15*newKhight, kWidth-30*newKwith, 44*newKhight)select:@""];
    cklTime.backgroundColor = kCbgColor;
    cklTime.delegate = self;
    [self.view addSubview:cklTime];
    
}

-(RedBtn *)addBtn {

    if (!_addBtn) {
        _addBtn = [[RedBtn alloc]initWithFrame:CGRectMake(0, kHeight-44*newKhight-kNavBarHAndStaBarH, kWidth, 44*newKhight) text:@"新增"];
        [_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addBtn;
}
//新增点击事件--- 保存
-(void)addBtnClick:(RedBtn *)btn {

    
    if ([self checkT]) {
        UITextField *T = (UITextField *)[self.view viewWithTag:kYun_huiyuanchongzhiTag];
        UITextField *T1 = (UITextField *)[self.view viewWithTag:kYun_huiyuanchongzhiTag+1];
        UITextField *T2 = (UITextField *)[self.view viewWithTag:kYun_huiyuanchongzhiTag+2];
        
        NetworkManger *manger = [NetworkManger new];
        [manger memberPayAddrecharge:T.text give:T1.text total:T2.text startdate:_start enddate:_end status:@"0"];
        manger.Addkezuofenqusuccessblock = ^{
            [WSProgressHUD showImage:nil status:@"新增成功"];

            [self.navigationController popViewControllerAnimated:YES];
        };
        
    }
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}

-(void)timeView:(ZLTimeView *)timeView seletedDateBegin:(NSString *)beginTime end:(NSString *)endTime {

    if (![beginTime isEqualToString:@"营销开始时间"]) {
        _start = [DateUtil TimeToTimestampForday:beginTime];
    }
    if (![endTime isEqualToString:@"营销结束时间"]) {
        _end = [DateUtil TimeToTimestampForday:endTime];
    }
    DLog(@" -- start -- %@",beginTime);
    DLog(@" ++ end ++ %@",endTime);

}
-(void)onpressBegBtnClick {

    [self registerkeybordy];
    
}

-(void)onpressEndBtnClick {

    [self registerkeybordy];

}
-(void)registerkeybordy {

    UITextField *T = (UITextField *)[self.view viewWithTag:kYun_huiyuanchongzhiTag];
    UITextField *T1 = (UITextField *)[self.view viewWithTag:kYun_huiyuanchongzhiTag+1];
    UITextField *T2 = (UITextField *)[self.view viewWithTag:kYun_huiyuanchongzhiTag+2];
    [T resignFirstResponder];
    [T1 resignFirstResponder];
    [T2 resignFirstResponder];
}

-(BOOL)checkT {
    UITextField *T = (UITextField *)[self.view viewWithTag:kYun_huiyuanchongzhiTag];
    UITextField *T1 = (UITextField *)[self.view viewWithTag:kYun_huiyuanchongzhiTag+1];
    UITextField *T2 = (UITextField *)[self.view viewWithTag:kYun_huiyuanchongzhiTag+2];
    
    if (kStringIsEmpty(T.text)) {
        
        [self yaopai:T];
        return NO;
    }if (kStringIsEmpty(T1.text)) {
        
        [self yaopai:T1];
        return NO;
    }if (kStringIsEmpty(T2.text)) {
        
        [self yaopai:T2];
        return NO;
    }
    
    if (kStringIsEmpty(_start)) {

        [WSProgressHUD showImage:nil status:@"开始时间为空"];
        return NO;
    }if (kStringIsEmpty(_end)) {
        [WSProgressHUD showImage:nil status:@"结束时间为空"];
        return NO;
    }
    return YES;
}

-(void)yaopai:(UITextField *)tf {
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.duration = 0.2;
    anim.repeatCount = 2;
    anim.values = @[@-20, @20, @-20];
    [tf.layer addAnimation:anim forKey:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
