//
//  OkimageView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/14.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "OkimageView.h"

@implementation OkimageView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
 
    
    self.image = kimage(@"fx_livRm_guide_ok");
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    
    
}

-(void)tapclick:(UITapGestureRecognizer *)tap {


    if (self.Click) {
        self.Click();
    }
}


@end
