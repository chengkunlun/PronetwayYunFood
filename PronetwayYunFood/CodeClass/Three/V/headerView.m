//
//  headerView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "headerView.h"

@implementation headerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, self.height)];
    view.backgroundColor = kRedColor;
    [self addSubview:view];
    
    self.backgroundColor = kCbgColor;
    _headerLb = [[UILabel alloc]initWithFrame:CGRectMake(15*newKwith, 0, kWidth, self.height)];
    _headerLb.textColor = RGB(85, 85, 85);
    _headerLb.font  =kFont(14);
    [self addSubview:_headerLb];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
