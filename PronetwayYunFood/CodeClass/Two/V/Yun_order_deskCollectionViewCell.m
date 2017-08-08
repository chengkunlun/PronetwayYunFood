//
//  Yun_order_deskCollectionViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/15.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Yun_order_deskCollectionViewCell.h"

@implementation Yun_order_deskCollectionViewCell


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
    _deskNumber.textColor = kyellowcolor;
    _deskNumber.font = kBodlFont(16);
    _deskNumber.text = @"A001";
    _deskNumber.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_deskNumber];
   
    _deskPeople = [[UILabel alloc]initWithFrame:CGRectMake(0, _deskNumber.endY+4*newKhight, self.width, 17*newKhight)];
    _deskPeople.textColor = kyellowcolor;
    _deskPeople.font = kFont(12);
    _deskPeople.text = @"二人桌";
    _deskPeople.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_deskPeople];
    
    _okimage = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-25*newKwith, 5*newKhight, 20*newKwith, 20*newKhight)];
    //_okimage.backgroundColor = kRedColor;
    _okimage.hidden = YES;
    _okimage.image = kimage(@"Yun_duigou_red");
    [self addSubview:_okimage];
}

//客桌管理
-(void)setMangerModel:(kezhuoModel *)mangerModel {

     _deskNumber.text = [NSString stringWithFormat:@"%@ %@",[mangerModel.zonename substringToIndex:1],mangerModel.numid];
    _deskPeople.text = [NSString stringWithFormat:@"%@ 人桌",mangerModel.seatnum];
    _deskNumber.textColor = kyellowcolor;
    _deskPeople.textColor = kyellowcolor;
    
    if (mangerModel.selected == YES) {
        
        _okimage.hidden = NO;
    }else {
    
        _okimage.hidden = YES;
    }
    
    
}
//赋值
-(void)setModel:(kezhuoModel *)model {
    
    _deskNumber.text = [NSString stringWithFormat:@"%@ %@",[model.zonename substringToIndex:1],model.numid];
    _deskPeople.text = [NSString stringWithFormat:@"%@ 人桌",model.seatnum];
    
    if ([model.status isEqualToString:@"0"]) {//空闲
        self.backgroundColor = kWhiteColor;
        _deskPeople.textColor = kyellowcolor;
        _deskNumber.textColor = kyellowcolor;
        
    }else {//1被占
        if ([model.paystatus isEqualToString:@"1"]) {//支付有人
            self.backgroundColor = kRedColor;
            _deskPeople.textColor = kWhiteColor;
            _deskNumber.textColor = kWhiteColor;
            
        }else {
        
            self.backgroundColor = kyellowcolor;
            _deskPeople.textColor = kWhiteColor;
            _deskNumber.textColor = kWhiteColor;
        }
    }
}


//收银
-(void)setIncomeModel:(kezhuoModel *)incomeModel {

    _deskNumber.text = [NSString stringWithFormat:@"%@ %@",[incomeModel.zonename substringToIndex:1],incomeModel.numid];
    _deskPeople.text = [NSString stringWithFormat:@"%@ 人桌",incomeModel.seatnum];
    
    if ([incomeModel.status isEqualToString:@"0"]) {//空闲
        self.backgroundColor = kGreenColor;
        _deskPeople.textColor = kWhiteColor;
        _deskNumber.textColor = kWhiteColor;
        
    }else {//1 被占
        if ([incomeModel.paystatus isEqualToString:@"1"]) {//支付有人
            self.backgroundColor = kRedColor;
            _deskPeople.textColor = kWhiteColor;
            _deskNumber.textColor = kWhiteColor;
            
        }else {
        
        self.backgroundColor = kyellowcolor;
        _deskPeople.textColor = kWhiteColor;
        _deskNumber.textColor = kWhiteColor;
            
        }
    }

}
//收银 搜索
-(void)setIncomeSearchModel:(kezhuoModel *)incomeSearchModel {

    
    _deskNumber.text = [NSString stringWithFormat:@"%@ %@",[incomeSearchModel.zonename substringToIndex:1],incomeSearchModel.numid];
    _deskPeople.text = [NSString stringWithFormat:@"%@ 人桌",incomeSearchModel.seatnum];
    
    if ([incomeSearchModel.paystatus isEqualToString:@"0"]) {//未支付
        self.backgroundColor = kWhiteColor;
        _deskPeople.textColor = kyellowcolor;
        _deskNumber.textColor = kyellowcolor;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [kyellowcolor CGColor];
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 5;
        
    }else {// 已支付
        
        if ([incomeSearchModel.paystatus isEqualToString:@"1"]) { //支付有人
            self.backgroundColor = kRedColor;
            _deskPeople.textColor = kWhiteColor;
            _deskNumber.textColor = kWhiteColor;
        }else {
        self.backgroundColor = kyellowcolor;
        _deskPeople.textColor = kWhiteColor;
        _deskNumber.textColor = kWhiteColor;
        }
    }

}

//点餐 搜索
-(void)setDcsearchModel:(kezhuoModel *)dcsearchModel {

    _deskNumber.text = [NSString stringWithFormat:@"%@ %@",[dcsearchModel.zonename substringToIndex:1],dcsearchModel.numid];
    _deskPeople.text = [NSString stringWithFormat:@"%@ 人桌",dcsearchModel.seatnum];
    
    if ([dcsearchModel.status isEqualToString:@"0"]) {//空闲
        self.backgroundColor = kWhiteColor;
        _deskPeople.textColor = kyellowcolor;
        _deskNumber.textColor = kyellowcolor;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [kyellowcolor CGColor];
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 5;

    }else {//1被占
        self.backgroundColor = kyellowcolor;
        _deskPeople.textColor = kWhiteColor;
        _deskNumber.textColor = kWhiteColor;
    }

}


@end
