//
//  ShaixuanTableViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/21.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "ShaixuanTableViewCell.h"

@implementation ShaixuanTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    _shaixuanimg = [[UIImageView alloc]initWithFrame:CGRectMake(10*newKwith, 11*newKhight, 33*newKwith, 22*newKhight)];
    _shaixuanimg.layer.masksToBounds = YES;
    _shaixuanimg.layer.cornerRadius = 3;
    [self addSubview:_shaixuanimg];
    
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55*newKwith, 0, kWidth-50*newKwith, 44*newKhight)];
    _titleLabel.textColor = RGB(85, 85, 85);
    _titleLabel.font = kFont(15);
    _titleLabel.text = @"";
    [self.contentView addSubview:_titleLabel];
    
    self.SelectIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.SelectIconBtn.frame = CGRectMake(kWidth-38*newKwith, 12*newKhight, 18*newKwith, 18*newKhight);
    [self.SelectIconBtn setImage:[UIImage imageNamed:@"table_UnSelect"] forState:UIControlStateNormal];
    [self.SelectIconBtn setImage:[UIImage imageNamed:@"table_Selected"] forState:UIControlStateSelected];
    self.SelectIconBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:self.SelectIconBtn];

    UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(0, 43*newKhight, kWidth, 1)];
    linVC.backgroundColor = kCbgColor;
    [self.contentView addSubview:linVC];
}


-(void)UpdateCellWithState:(BOOL)select{
    self.SelectIconBtn.selected = select;
    _isSelected = select;
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
