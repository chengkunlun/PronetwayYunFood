//
//  Hui_xiaoxiViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/19.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Hui_xiaoxiViewController.h"
#import "PlaceholderTextView.h"
@interface Hui_xiaoxiViewController ()<UITextViewDelegate>
@property (nonatomic, strong) PlaceholderTextView * textView;

@property (strong, nonatomic) RedBtn *addBtn;

@property (nonatomic, strong) UIButton * sendButton;

@property (nonatomic, strong) UIView * aView;

@property (nonatomic, strong)UILabel *wordCountLabel;//字数限制

@property (strong, nonatomic) UILabel *LB1;
@property (strong, nonatomic) UILabel *LB2;


@end

@implementation Hui_xiaoxiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"消息"];
    
    [self addView];
    
    [self.view addSubview:self.addBtn];
    
    [self.view addSubview:self.LB1];
    [self.view addSubview:self.LB2];

    
    // Do any additional setup after loading the view.
}

-(void)addView {

    self.aView = [[UIView alloc]init];
    _aView.backgroundColor = [UIColor whiteColor];
    _aView.frame = CGRectMake(20*newKwith, 20*newKhight, kWidth - 40*newKwith, 213*newKhight);
    [self.view addSubview:_aView];
    self.navigationItem.title = @"意见反馈";
    
    
    self.wordCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.textView.frame.origin.x + 20*newKwith,  self.textView.frame.size.height + 18*newKhight, kWidth - 40*newKwith, 20*newKhight)];
    _wordCountLabel.font = [UIFont systemFontOfSize:14.f];
    _wordCountLabel.textColor = [UIColor lightGrayColor];
    self.wordCountLabel.text = @"0/300";
    self.wordCountLabel.backgroundColor = [UIColor whiteColor];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:_wordCountLabel];
    [_aView addSubview:self.textView];

}

-(PlaceholderTextView *)textView{
    
    if (!_textView) {
        _textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(0, 0, kWidth - 40*newKwith, 213*newKhight)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14.f];
        _textView.textColor = [UIColor blackColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        _textView.layer.cornerRadius = 4.0f;
        _textView.layer.borderColor = RGB(227, 224, 216).CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.placeholderColor = RGB(0x89, 0x89, 0x89);
        _textView.placeholder = @"写下你要发送的消息..";
        
        
    }
    
    return _textView;
}

-(UILabel *)LB1{

    if (!_LB1) {
        _LB1 = [[UILabel alloc]initWithFrame:CGRectMake(20, _wordCountLabel.endY, kWidth, 30*newKhight)];
        _LB1.textColor = kRedColor;
        _LB1.font = kFont(14);
        _LB1.text = @"您正在向标签为“重要客人”的120人群发消息";
    }
    
    return _LB1;
}

-(UILabel *)LB2{
    
    if (!_LB2) {
        _LB2 = [[UILabel alloc]initWithFrame:CGRectMake(20, _LB1.endY, kWidth, 20*newKhight)];
        _LB2.textColor = RGB(153, 153, 153);
        _LB2.font = kFont(14);
        _LB2.text = @"将收取短信费12.00";
    }
    
    return _LB2;
}

-(RedBtn *)addBtn {
    
    if (!_addBtn) {
        _addBtn = [[RedBtn alloc]initWithFrame:CGRectMake(0, kHeight-44*newKhight-kNavBarHAndStaBarH, kWidth, 44*newKhight) text:@"发送"];
        [_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addBtn;
}

//发消息击事件
-(void)addBtnClick:(RedBtn *)btn {
    
    
    
}

//把回车键当做退出键盘的响应键  textView退出键盘的操作
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        
        
        return NO;
    }
    
    return YES;
}

//返回 --
-(void)backAction {

    [self.navigationController  popViewControllerAnimated:YES];
    [kNotificationCenter postNotificationName:@"gunmessage" object:nil];
    
    
}
#pragma mark textField的字数限制

//在这个地方计算输入的字数
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger wordCount = textView.text.length;
    self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/300",(long)wordCount];
    [self wordLimit:textView];
}
#pragma mark 超过300字不能输入
-(BOOL)wordLimit:(UITextView *)text{
    if (text.text.length < 300) {
        NSLog(@"%ld",text.text.length);
        self.textView.editable = YES;
        
    }
    else{
        self.textView.editable = NO;
        
    }
    return nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
