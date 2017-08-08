//
//  selectBtnView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/24.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "selectBtnView.h"

@implementation selectBtnView

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView:text color:color];
    }
    return self;
}

-(void)addView:(NSString *)text color:(UIColor *)color{
    
    self.backgroundColor = color;
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
    _btnlab = [[UILabel alloc]initWithFrame:CGRectMake(10*newKwith, 0, self.width, self.height)];
    _btnlab.font  =kFont(15);
    _btnlab.textColor = RGB(122, 122, 122);
    _btnlab.text = text;
    [self addSubview:_btnlab];
    
    _arrowimg = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-30*newKwith, 18*newKhight, 14*newKwith, 8*newKhight)];
    _arrowimg.image = kimage(@"Yun_home_addCai_jiantou");
    [self addSubview:_arrowimg];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    
}

-(void)tapclick:(UITapGestureRecognizer *)tap {

    if (self.ClickBlock) {
        self.ClickBlock();
    }
}

@end
