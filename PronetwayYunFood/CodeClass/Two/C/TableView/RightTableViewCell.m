//
//  RightTableViewCell.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import "RightTableViewCell.h"
#import "CategoryModel.h"

@interface RightTableViewCell ()


@end

@implementation RightTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
        [self.contentView addSubview:self.imageV];

        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 30)];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.nameLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, 200, 30)];
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        self.priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.priceLabel];
        
        _addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _addBtn.frame = CGRectMake(self.width-65*newKwith, 42.5*newKhight, 25*newKwith, 25*newKhight);
        _addBtn.layer.masksToBounds = YES;
        _addBtn.layer.cornerRadius = 5;
        _addBtn.backgroundColor = RGB(227, 172, 80);
        [_addBtn setTitle:@"+" forState:(UIControlStateNormal)];
        [_addBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        [self.contentView addSubview:_addBtn];
        
        
        _numberLab = [[UILabel alloc]initWithFrame:CGRectMake(self.width-85*newKwith, 42.5*newKhight, 20*newKwith, 25*newKhight)];
        _numberLab.font = kFont(14);
        _numberLab.hidden = YES;
        [self.contentView addSubview:_numberLab];
        
        _reduceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _reduceBtn.frame = CGRectMake(self.width-65*newKwith, 42.5*newKhight, 25*newKwith, 25*newKhight);
        _reduceBtn.hidden = YES;
        _reduceBtn.layer.masksToBounds = YES;
        _reduceBtn.layer.cornerRadius = 5;
        _reduceBtn.layer.borderColor = [RGB(227, 172, 80) CGColor];
        _reduceBtn.layer.borderWidth = 1;
        [_reduceBtn setTitle:@"－" forState:(UIControlStateNormal)];
        [_reduceBtn setTitleColor:RGB(227, 172, 80) forState:(UIControlStateNormal)];
        [self.contentView addSubview:_reduceBtn];
        
//        UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(10*newKwith, self.height-1, kWidth-20*newKwith, 1)];
//        linVC.backgroundColor = kCbgColor;
//        [self.contentView addSubview:linVC];
        
    }
    return self;
}

//点餐
- (void)setDCcaiPmodel:(Home_CaiPinModel *)DCcaiPmodel
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIP,DCcaiPmodel.imgpath]]];
    self.nameLabel.text = DCcaiPmodel.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %0.2f",[DCcaiPmodel.price floatValue]/100];
    
    if (DCcaiPmodel.selectnumber == 0) {
        _reduceBtn.frame = CGRectMake(kWidth-125*newKwith, 42.5*newKhight, 25*newKwith, 25*newKhight);
        _reduceBtn.hidden = YES;
        _numberLab.hidden = YES;
    }else {
        _reduceBtn.hidden = NO;
        _numberLab.hidden = NO;
        _reduceBtn.frame = CGRectMake(kWidth-180*newKwith, 42.5*newKhight, 25*newKwith, 25*newKhight);
    self.numberLab.text = [NSString stringWithFormat:@"%ld",DCcaiPmodel.selectnumber];
    }
    if ([PronetwayYunFoodHandle shareHandle].showReduceBtn == NO) {
        _numberLab.hidden = YES;
        _reduceBtn.hidden = YES;
//    }else {
//    
//        _numberLab.hidden = NO;
    }
}


//菜品
-(void)setCaiPmodel:(Home_CaiPinModel *)caiPmodel {

    if ([caiPmodel.status isEqualToString:@"1"]) {
        self.nameLabel.textColor = rgba(151, 151, 151, 0.9);
        self.priceLabel.textColor = rgba(151, 151, 151, 0.9);

    }else {
        self.nameLabel.textColor = kblackColor;
        self.priceLabel.textColor = kRedColor;

        
    }
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIP,caiPmodel.imgpath]]];
    self.nameLabel.text = caiPmodel.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %0.2f",[caiPmodel.price floatValue]/100];
    _addBtn.hidden = YES;
    
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
