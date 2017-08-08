//
//  MycommenView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/7.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "MycommenView.h"

@implementation MycommenView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
 
    
    CGFloat h = (self.height-45*newKhight)/2;
    
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, h, self.width, 30*newKhight)];
    _titleLb.font = kBodlFont(16);
    _titleLb.textColor = kWhiteColor;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLb];
    
    _subtitlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleLb.endY, self.width, 15*newKhight)];
    _subtitlelab.font = kBodlFont(12);
    _subtitlelab.textColor = kWhiteColor;
    _subtitlelab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_subtitlelab];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    
    
    
}
-(void)tapClick:(UITapGestureRecognizer *)tap {

    if (self.clickBlock) {
        self.clickBlock();
    }
    
}


@end
