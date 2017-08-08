//
//  ListTableViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/31.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kWidth, 44*newKhight)];
   // _name.text = @"nihao";
    _name.font = kFont(15);
    [self.contentView addSubview:_name];
    
    _numberLab = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-70*newKwith, 0, 30*newKwith, 44*newKhight)];
    _numberLab.font = kFont(15);
    [self.contentView addSubview:_numberLab];
    
    _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-180*newKwith, 0, 150*newKwith, 44*newKhight)];
    _priceLab.font = kFont(15);
    _priceLab.textColor = kRedColor;
    _priceLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_priceLab];
    
    _addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _addBtn.frame = CGRectMake(kWidth-40*newKwith, 13*newKhight, 18*newKwith, 18*newKhight);
    _addBtn.layer.masksToBounds = YES;
    _addBtn.layer.cornerRadius = 5;
    _addBtn.backgroundColor = RGB(227, 172, 80);
    [_addBtn setTitle:@"+" forState:(UIControlStateNormal)];
    [_addBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [self.contentView addSubview:_addBtn];
    
    
    _reduceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _reduceBtn.frame = CGRectMake(kWidth-110*newKwith, 13*newKhight, 18*newKwith, 18*newKhight);
    _reduceBtn.layer.masksToBounds = YES;
    _reduceBtn.layer.cornerRadius = 5;
    _reduceBtn.layer.borderColor = [RGB(227, 172, 80) CGColor];
    _reduceBtn.layer.borderWidth = 1;
    [_reduceBtn setTitle:@"－" forState:(UIControlStateNormal)];

    [_reduceBtn setTitleColor:RGB(227, 172, 80) forState:(UIControlStateNormal)];
    [self.contentView addSubview:_reduceBtn];

}

//赋值
-(void)setModel:(Home_CaiPinModel *)model {

    _name.text = model.name;
    _numberLab.text = [NSString stringWithFormat:@"%ld",model.selectnumber];
    _priceLab.text = [NSString stringWithFormat:@" % 0.2f",[model.price floatValue]/100*model.selectnumber];
    
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
