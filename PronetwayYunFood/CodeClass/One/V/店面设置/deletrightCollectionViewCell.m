//
//  deletrightCollectionViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/27.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "deletrightCollectionViewCell.h"

@implementation deletrightCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    _deskNumber = [[UILabel alloc]initWithFrame:CGRectMake(0, 24*newKhight, self.width, 17*newKhight)];
    _deskNumber.textColor = kWhiteColor;
    _deskNumber.font = kBodlFont(16);
    _deskNumber.text = @"A001";
    _deskNumber.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_deskNumber];
    
    _deskPeople = [[UILabel alloc]initWithFrame:CGRectMake(0, _deskNumber.endY+4*newKhight, self.width, 17*newKhight)];
    _deskPeople.textColor = kWhiteColor;
    _deskPeople.font = kFont(12);
    _deskPeople.text = @"二人桌";
    _deskPeople.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_deskPeople];
    
    

    _deleteCollectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _deleteCollectBtn.frame = CGRectMake(55*newKwith, 5*newKhight, 22*newKwith, 22*newKhight);
    [_deleteCollectBtn setImage:kimage(@"Yun_dianpu_greendelete") forState:(UIControlStateNormal)];
    [self.contentView addSubview:_deleteCollectBtn];
    
    

    
    
}

@end
