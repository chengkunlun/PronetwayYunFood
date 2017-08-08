//
//  My_TableViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "My_TableViewCell.h"

@implementation My_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    

    _my_lb1 = [[UILabel alloc]initWithFrame:CGRectMake(15*newKwith, 10*newKhight, kWidth, 20*newKhight)];
    _my_lb1.text = @"A001号桌";
    _my_lb1.textColor = kblackColor;
    _my_lb1.font = kFont(16);
    [self addSubview:_my_lb1];
    
    _my_lb2 = [[UILabel alloc]initWithFrame:CGRectMake(15*newKwith, _my_lb1.endY, kWidth, 20*newKhight)];
    _my_lb2.text = @"2017-5-14-32042039";
    _my_lb2.textColor = RGB(100, 100, 100);
    _my_lb2.font = kFont(13);
    [self addSubview:_my_lb2];
    
    _my_lb3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth-15*newKwith, 60*newKhight)];
    _my_lb3.text = @"+1000 ¥";
    _my_lb3.textAlignment = NSTextAlignmentRight;
    _my_lb3.textColor = RGB(100, 100, 100);
    _my_lb3.font = kFont(16);
    _my_lb3.textColor = RGB(70, 176, 225);
    [self addSubview:_my_lb3];

    UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(15*newKwith, 59*newKhight, kWidth-30*newKwith, 1)];
    linVC.backgroundColor = RGB(241, 241, 241);
    [self addSubview:linVC];
    
}


-(void)setCashModel:(my_listModel *)cashModel {
    
    _my_lb1.text = [NSString stringWithFormat:@"%@-%@ 桌",[cashModel.name substringToIndex:1],cashModel.numid];
    _my_lb2.text = cashModel.ordertime;
    _my_lb3.text = [NSString stringWithFormat:@"+ ¥ %0.2f",[cashModel.money floatValue]/100];
}

-(void)setOnlinModel:(my_listModel *)onlinModel {
    if ([onlinModel.payway isEqualToString:@"2"]) {
        
        _my_lb1.text = [NSString stringWithFormat:@"%@-%@ 桌 %@",[onlinModel.name substringToIndex:1],onlinModel.numid,@"支付宝支付"];

    }else if ([onlinModel.payway isEqualToString:@"1"]) {
    
        _my_lb1.text = [NSString stringWithFormat:@"%@-%@ 桌 %@",[onlinModel.name substringToIndex:1],onlinModel.numid,@"微信支付"];

    }else if ([onlinModel.payway isEqualToString:@"3"]) {
    
        _my_lb1.text = [NSString stringWithFormat:@"%@-%@ 桌 %@",[onlinModel.name substringToIndex:1],onlinModel.numid,@"余额支付"];

    }else {
    
        _my_lb1.text = [NSString stringWithFormat:@"%@-%@ 桌 %@",[onlinModel.name substringToIndex:1],onlinModel.numid,@"现金支付"];

    }
    _my_lb2.text = onlinModel.paytime;
    _my_lb3.text = [NSString stringWithFormat:@"+ ¥ %0.2f",[onlinModel.money floatValue]/100];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
