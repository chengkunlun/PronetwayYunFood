//
//  RedBtn.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/18.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "RedBtn.h"

@implementation RedBtn


- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {

        [self setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        self.titleLabel.font = kBodlFont(16);
        [self setTitle:text forState:(UIControlStateNormal)];
        //[_XDBtn setImage:kimage(@"Yun_order_bottom") forState:(UIControlStateNormal)];
        [self setBackgroundImage:kimage(@"Yun_order_bottom") forState:(UIControlStateNormal)];
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
