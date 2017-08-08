//
//  dianpuTableViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/24.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "dianpuTableViewCell.h"

@implementation dianpuTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;

    _lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10*newKwith, 0, kWidth-30*newKwith, 44*newKhight)];
    _lab1.textColor = RGB(85, 85, 85);
    _lab1.text = @"中山北路";
    _lab1.font = kFont(14);
    [self.contentView addSubview:_lab1];
    
    
    _lab2 = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-255*newKwith, 0, 200*newKwith, 44*newKhight)];
    _lab2.textColor = RGB(153, 153, 153);
    _lab2.text = @"店铺名称";
    _lab2.font = kFont(12);
    _lab2.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_lab2];
    

    
    
    
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
