//
//  Income_NodesknumberViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Income_NodesknumberViewController.h"

@interface Income_NodesknumberViewController ()

@property (strong, nonatomic) UITextField *input;

@end

@implementation Income_NodesknumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle:@"无桌号收银"];
    [self.view addSubview:self.input];
    // Do any additional setup after loading the view.
}

-(UITextField *)input {

    if (!_input) {
        _input = [[UITextField alloc]initWithFrame:CGRectMake(30*newKwith, 64*newKhight, (kWidth-60), 44*newKhight)];
        _input.keyboardType = UIKeyboardTypeDecimalPad;
        [_input becomeFirstResponder];
        _input.borderStyle = UITextBorderStyleRoundedRect;
        
        _input.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }
    return _input;
}

//回收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
