//
//  KezhuoleftTableViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/26.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "KezhuoleftTableViewCell.h"

@implementation KezhuoleftTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    
    
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80*newKwith, 60*newKhight)];
    self.name.numberOfLines = 0;
    self.name.textAlignment = NSTextAlignmentCenter;
    self.name.font = [UIFont systemFontOfSize:15];
    self.name.textColor = rgba(130, 130, 130, 1);
    self.name.highlightedTextColor = kWhiteColor;
    [self.contentView addSubview:self.name];
    
    UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(0, 59*newKhight, kWidth, 1)];
    linVC.backgroundColor = kWhiteColor;
    [self.contentView addSubview:linVC];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.contentView.backgroundColor = selected ? kRedColor : [UIColor colorWithWhite:0 alpha:0.1];
    self.highlighted = selected;
    self.name.highlighted = selected;
    //self.yellowView.hidden = !selected;

    // Configure the view for the selected state
}

@end
