//
//  Chongcollectcell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/19.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Chongcollectcell.h"

@implementation Chongcollectcell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{

    _collectlab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _collectlab.font = kFont(14);
    _collectlab.text = @"充100送100";
    _collectlab.textAlignment = NSTextAlignmentCenter;
    _collectlab.textColor = kyellowcolor;
    [self addSubview:_collectlab];
    
}

-(void)setModel:(ChuiyuanModel *)model {

    _collectlab.text = [NSString stringWithFormat:@"充%@送%@",model.recharge,model.give];
    
}

@end
