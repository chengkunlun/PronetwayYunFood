//
//  Home_paihao.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/18.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_paihao.h"

@implementation Home_paihao

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(15*newKwith, 40*newKhight, kWidth-30*newKhight, 213*newKhight)];
    topView.layer.masksToBounds = YES;
    topView.layer.cornerRadius = 5;
    
    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView)];
    PrivateLetterTap.numberOfTouchesRequired = 1; //手指数
    PrivateLetterTap.numberOfTapsRequired = 1; //tap次数
    [topView addGestureRecognizer:PrivateLetterTap];


    topView.backgroundColor = kRedColor;
    [self addSubview:topView];
    
    _PaiimgView = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth-100*newKwith)/2, 50*newKhight, 100*newKwith, 97*newKhight)];
    _PaiimgView.image = kimage(@"Yun_home_paihao");
    [topView addSubview:_PaiimgView];
    
    UILabel *plb = [[UILabel alloc]initWithFrame:CGRectMake(0, _PaiimgView.endY+10*newKhight, kWidth, 34*newKhight)];
    [self packLabel:plb text:@"排号"];
    [topView addSubview:plb];
    
    UIView *bootmView = [[UIView alloc]initWithFrame:CGRectMake(15*newKwith, topView.endY+50*newKhight, kWidth-30*newKhight, 213*newKhight)];
    bootmView.layer.masksToBounds = YES;
    bootmView.layer.cornerRadius = 5;
    
    UITapGestureRecognizer * PrivateLetterTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView1)];
    PrivateLetterTap1.numberOfTouchesRequired = 1; //手指数
    PrivateLetterTap1.numberOfTapsRequired = 1; //tap次数
    [bootmView addGestureRecognizer:PrivateLetterTap1];
    

    
    bootmView.backgroundColor = kBlueColor;
    
    _JiaoimgView = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth-100*newKwith)/2, 50*newKhight, 100*newKwith, 85*newKhight)];
    _JiaoimgView.image = kimage(@"Yun_home_jiaohao");
    [bootmView addSubview:_JiaoimgView];
    [self addSubview:bootmView];

    UILabel *jlb = [[UILabel alloc]initWithFrame:CGRectMake(0, _JiaoimgView.endY+10*newKhight, kWidth, 34*newKhight)];
    [self packLabel:jlb text:@"叫号"];
    [bootmView addSubview:jlb];
    
    
}


-(void)packLabel:(UILabel *)lab text:(NSString *)text {

    lab.text = text;
    lab.textColor = kWhiteColor;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = kBodlFont(20);
}

-(void)tapAvatarView{

    if (self.paiBlock) {
        self.paiBlock();
    }
}
-(void)tapAvatarView1 {

    if (self.jiaoBlock) {
        self.jiaoBlock();
    }

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
