//
//  collectHeaderView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/13.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "collectHeaderView.h"

@implementation collectHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{

    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 5*newKhight, 5*newKwith, self.height-10*newKhight)];
    v.backgroundColor = kRedColor;
    [self addSubview:v];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(v.endX+10*newKwith, 0, self.width, self.height)];
    _title.textColor = kRedColor; //rgba(151, 151, 151, 1);
    _title.font = kFont(14);
    [self addSubview:_title];
    
    UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(0,  self.height-1, self.width,1)];
    linVC.backgroundColor = kCbgColor;
    [self addSubview:linVC];
    
    
}



@end
