//
//  BluetoothTableViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/5.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "BluetoothTableViewCell.h"

@implementation BluetoothTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{

    _namelab = [[UILabel alloc]initWithFrame:CGRectMake(10*newKwith, 0, kWidth, 40*newKhight)];
    _namelab.textColor = RGB(85, 85, 85);
    _namelab.font = kFont(17);
    [self.contentView addSubview:_namelab];
    
    _signallab = [[UILabel alloc]initWithFrame:CGRectMake(10*newKwith, _namelab.endY-5*newKhight, kWidth, 20*newKhight)];
    _signallab.textColor = RGB(151, 151, 151);
    _signallab.font = kFont(12);
    [self.contentView addSubview:_signallab];

    
    _connectState = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-120*newKwith, 0, kWidth, 60*newKhight)];
    _connectState.textColor = RGB(151, 151, 151);
    _connectState.font = kFont(16);
    [self.contentView addSubview:_connectState];

    
    
    
    
    
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
