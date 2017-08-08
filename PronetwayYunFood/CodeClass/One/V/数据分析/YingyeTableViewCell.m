//
//  YingyeTableViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YingyeTableViewCell.h"

@implementation YingyeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    _lb1 = [[UILabel alloc]initWithFrame:CGRectMake(10*newKwith, 0, kWidth, 48*newKhight)];
    _lb1.textColor  =RGB(51, 51, 51);
    _lb1.font = kFont(16);
    _lb1.text = @"2017年1月";
    [self.contentView addSubview:_lb1];
    
    _lb2 = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-245*newKwith, 0,200*newKwith, 48*newKhight)];
    _lb2.textColor  =RGB(85, 85, 85);
    _lb2.font = kFont(16);
    _lb2.text = @"¥ 888888888";
    _lb2.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_lb2];
    
    UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(10,47*newKhight, kWidth-50*newKwith, 1)];
    linVC.backgroundColor = kCbgColor;
    [self.contentView addSubview:linVC];
    
    
}

-(void)setModel:(YinYeModel *)model {

    _lb1.text = model.stime;
    _lb2.text = [NSString stringWithFormat:@"¥ %@",model.cMoney];
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
