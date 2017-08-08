//
//  Yun_leftTableViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/6.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Yun_leftTableViewCell.h"

@implementation Yun_leftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(0, 5*newKhight, 80*newKwith, 50*newKhight)];
    self.name.numberOfLines = 0;
    self.name.textAlignment = NSTextAlignmentCenter;
    self.name.font = [UIFont systemFontOfSize:15];
    self.name.textColor = kWhiteColor;
    self.name.highlightedTextColor = kWhiteColor;
    [self.contentView addSubview:self.name];
    
    UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(0, 59*newKhight, kWidth, 1)];
    linVC.backgroundColor = kblackColor;
    [self.contentView addSubview:linVC];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.contentView.backgroundColor = selected ? kRedColor : RGB(51, 51, 51);
    self.highlighted = selected;
    self.name.highlighted = selected;
    //self.yellowView.hidden = !selected;
    
    // Configure the view for the selected state
}

@end
