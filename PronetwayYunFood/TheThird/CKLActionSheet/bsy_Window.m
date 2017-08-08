//
//  bsy_Window.m
//  测试
//
//  Created by chenchen on 15/11/2.
//  Copyright © 2015年 BSY. All rights reserved.
//

#import "bsy_Window.h"
#import "ColorUtil.h"
@implementation bsy_Window


#define bsy_width [UIScreen mainScreen].bounds.size.width
#define bsy_height [UIScreen mainScreen].bounds.size.height
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelAlert;

        _bsyBackView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, bsy_width, bsy_height)];
        _bsyBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self addSubview:_bsyBackView];
        self.bsy_superView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.bsy_superView.backgroundColor = [UIColor whiteColor];
        self.bsy_superView.center = CGPointMake(bsy_width/2.0,bsy_height / 2.5);

        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.bsy_superView.frame = CGRectMake(0, 0, bsy_width-60, 150);
            
            self.bsy_superView.center = CGPointMake(bsy_width/2.0,bsy_height/2.5);
            } completion:^(BOOL finished) {
            }];
        self.bsy_superView.layer.borderWidth = 1;
        self.bsy_superView.layer.borderColor = [UIColor clearColor].CGColor;
        self.bsy_superView.layer.cornerRadius = 10;
        self.bsy_superView.clipsToBounds = YES;
        [self addSubview:self.bsy_superView];
        
        [self makeKeyAndVisible];
    }
    
    return self;
}


-(void)addsureMessage:(NSString *)sureMessage message:(NSString *)message cueMessage:(NSString *)cueMessage
{

  
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    
    [_bsyBackView addGestureRecognizer:tap];
    
    self.bsy_sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bsy_sureBtn setTitle:sureMessage forState:UIControlStateNormal];
    [self.bsy_sureBtn setTitleColor:[ColorUtil getUIColorByHex:@"4dc7a3"] forState:UIControlStateNormal];
    [self.bsy_sureBtn setBackgroundImage :[ColorUtil getUIImageByUIColor:[ColorUtil getUIColorByHex:@"f5f5f5"]] forState:UIControlStateHighlighted];
    [self.bsy_sureBtn setBackgroundImage :[ColorUtil getUIImageByUIColor:[ColorUtil getUIColorByHex:@"f5f5f5"]] forState:UIControlStateSelected];
    
    self.bsy_sureBtn.frame = CGRectMake(0, self.bsy_superView.frame.size.height-45, self.bsy_superView.frame.size.width, 40);
    self.bsy_sureBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.bsy_sureBtn.layer.borderWidth = 1;
    self.bsy_sureBtn.layer.cornerRadius = 5;
    self.bsy_sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.bsy_sureBtn.clipsToBounds = YES;
    [self.bsy_sureBtn addTarget:self action:@selector(bsy_Windowclose) forControlEvents:UIControlEventTouchUpInside];

    [self.bsy_superView addSubview:self.bsy_sureBtn];
   
    
    
    self.bsy_messageLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 45, self.bsy_superView.frame.size.width-40, self.bsy_superView.frame.size.height-100)];
    self.bsy_messageLab.text = message;
    self.bsy_messageLab.textColor = [UIColor lightGrayColor];
    self.bsy_messageLab.numberOfLines = 0;
    self.bsy_messageLab.textAlignment  =NSTextAlignmentCenter;
    self.bsy_messageLab.font = [UIFont systemFontOfSize:15];
    [self.bsy_superView addSubview:self.bsy_messageLab];
    
    self.bsy_cueLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, self.bsy_superView.frame.size.width, 30)];
    self.bsy_cueLab.text = cueMessage;
    self.bsy_cueLab.textAlignment = NSTextAlignmentCenter;
    self.bsy_cueLab.textColor = [UIColor blackColor];
    self.bsy_cueLab.alpha = 0.7;
    self.bsy_cueLab.font = [UIFont systemFontOfSize:19];
    [self.bsy_superView addSubview:self.bsy_cueLab];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bsy_superView.frame.size.height-46, self.bsy_superView.frame.size.width, 1)];
    line.backgroundColor = [UIColor blackColor];
    line.alpha = 0.1;
    [self.bsy_superView addSubview:line];
}


/*
 * 两个按钮
 */
-(void)addBsy_quitBtnMessage:(NSString *)quitmessage sureMessage:(NSString *)sureMessage message:(NSString *)message cueMessage:(NSString *)cueMessage{
    
    self.bsy_quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bsy_quitBtn setTitle:quitmessage forState:UIControlStateNormal];
    [self.bsy_quitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.bsy_quitBtn.frame = CGRectMake(0, self.bsy_superView.frame.size.height - 45, (self.bsy_superView.frame.size.width/2)-1, 45);
    self.bsy_quitBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.bsy_quitBtn.layer.borderWidth = 1;
    self.bsy_quitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.bsy_quitBtn setBackgroundImage :[ColorUtil getUIImageByUIColor:[ColorUtil getUIColorByHex:@"f5f5f5"]] forState:UIControlStateHighlighted];
    [self.bsy_quitBtn setBackgroundImage :[ColorUtil getUIImageByUIColor:[ColorUtil getUIColorByHex:@"f5f5f5"]] forState:UIControlStateSelected];
    self.bsy_quitBtn.layer.cornerRadius = 5;
    [self.bsy_quitBtn setTitleColor:[ColorUtil getUIColorByHex:@"666666"] forState:UIControlStateNormal];
    self.bsy_quitBtn.clipsToBounds = YES;
    [self.bsy_superView addSubview:self.bsy_quitBtn];
    [self.bsy_quitBtn addTarget:self action:@selector(bsy_Windowclose) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.bsy_sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bsy_sureBtn setTitle:sureMessage forState:UIControlStateNormal];
    [self.bsy_sureBtn setTitleColor:[ColorUtil getUIColorByHex:@"4dc7a3"] forState:UIControlStateNormal];
    [self.bsy_sureBtn setBackgroundImage :[ColorUtil getUIImageByUIColor:[ColorUtil getUIColorByHex:@"f5f5f5"]] forState:UIControlStateHighlighted];
    [self.bsy_sureBtn setBackgroundImage :[ColorUtil getUIImageByUIColor:[ColorUtil getUIColorByHex:@"f5f5f5"]] forState:UIControlStateSelected];
    self.bsy_sureBtn.frame = CGRectMake(self.bsy_superView.frame.size.width/2, self.bsy_superView.frame.size.height-45, (self.bsy_superView.frame.size.width/2)-1, 45);
    self.bsy_sureBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.bsy_sureBtn.layer.borderWidth = 1;
    self.bsy_sureBtn.layer.cornerRadius = 5;
    self.bsy_sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.bsy_sureBtn.clipsToBounds = YES;
    [self.bsy_superView addSubview:self.bsy_sureBtn];
    
    UIView *Hline =[[UIView alloc]initWithFrame:CGRectMake(self.bsy_superView.frame.size.width/2,self.bsy_superView.frame.size.height-45, 1, 45)];
    
    Hline.backgroundColor = [UIColor blackColor];
    Hline.alpha = 0.1;
    [self.bsy_superView addSubview:Hline];
    
    
    self.bsy_messageLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 45, self.bsy_superView.frame.size.width-40, self.bsy_superView.frame.size.height-100)];
    self.bsy_messageLab.text = message;
    self.bsy_messageLab.textColor = [ColorUtil getUIColorByHex:@"666666"];
    self.bsy_messageLab.numberOfLines = 0;
    self.bsy_messageLab.textAlignment  =NSTextAlignmentCenter;
    self.bsy_messageLab.font = [UIFont systemFontOfSize:15];
    [self.bsy_superView addSubview:self.bsy_messageLab];
    
    self.bsy_cueLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, self.bsy_superView.frame.size.width, 30)];
    self.bsy_cueLab.text = cueMessage;
    self.bsy_cueLab.textAlignment = NSTextAlignmentCenter;
    self.bsy_cueLab.textColor = [UIColor blackColor];
    self.bsy_cueLab.alpha = 0.7;
    self.bsy_cueLab.font = [UIFont systemFontOfSize:19];
    [self.bsy_superView addSubview:self.bsy_cueLab];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bsy_superView.frame.size.height-46, self.bsy_superView.frame.size.width, 1)];
    line.backgroundColor = [UIColor blackColor];
    line.alpha = 0.1;
    [self.bsy_superView addSubview:line];
    
}

-(void)tap
{
    [self bsy_Windowclose];

    
}
- (void)bsy_Windowclose {
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.bsy_superView.center = CGPointMake(bsy_width/2.0,bsy_height/2.5);
       
    } completion:^(BOOL finished) {
         self.hidden = YES;
    }];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 点击消失
    [self bsy_Windowclose];
}
@end
