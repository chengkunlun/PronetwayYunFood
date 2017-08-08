//
//  WiFiTableViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/23.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "WiFiTableViewCell.h"

@implementation WiFiTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    _wifiimg = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth-139)/2, 15*newKhight, 139*newKwith, 208*newKhight)];
    _wifiimg.image = kimage(@"Yun_wifi");
    [self.contentView addSubview:_wifiimg];
    
    if ([self.selectStr isEqualToString:@"我的模板"]) {
        
    }else {
        _bootmView = [[UIView alloc]initWithFrame:CGRectMake(0, 179*newKhight, kWidth, 44)];
        _bootmView.backgroundColor = kblackColor;
        _bootmView.alpha = 0.5;
        [self.contentView addSubview:_bootmView];
        
    }
    
    UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(0,232*newKhight, kWidth, 1*newKhight)];
    linVC.backgroundColor = kCbgColor;
    [self.contentView addSubview:linVC];
    
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
