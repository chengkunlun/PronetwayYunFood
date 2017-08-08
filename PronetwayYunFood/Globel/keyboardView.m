//
//  keyboardView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/27.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "keyboardView.h"

@implementation keyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    
    _okBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _okBtn.frame = CGRectMake(kWidth-70*newKwith, 0, 50*newKwith, self.height);
    [_okBtn setTitle:@"确 定" forState:(UIControlStateNormal)];
    [_okBtn setTitleColor:kGreenColor forState:(UIControlStateNormal)];
    _okBtn.titleLabel.font = kFont(15);
    [_okBtn addTarget:self action:@selector(okbtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_okBtn];
}

-(void)okbtnClick {

    if (self.okclick) {
        self.okclick();
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
