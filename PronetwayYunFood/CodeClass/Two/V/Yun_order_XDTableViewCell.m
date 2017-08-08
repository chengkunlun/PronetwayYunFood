//
//  Yun_order_XDTableViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/15.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Yun_order_XDTableViewCell.h"

@implementation Yun_order_XDTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    _yunxdimg = [[UIImageView alloc]initWithFrame:CGRectMake(10*newKwith, 5*newKhight, 55*newKwith, 55*newKhight)];
    _yunxdimg.image = kimage(@"xia");
    [self.contentView addSubview:_yunxdimg];
    
    _lb1 = [[UILabel alloc]initWithFrame:CGRectMake(_yunxdimg.endX +10*newKwith, 0, kWidth, 20)];
    _lb1.text = @"嫩滑甜虾";
    _lb1.font = kFont(14);
    _lb1.textColor = kblackColor;
    [self.contentView addSubview:_lb1];
    
    _lb2 = [[UILabel alloc]initWithFrame:CGRectMake(_yunxdimg.endX +10*newKwith, _lb1.endY +10, 140*newKwith, 20)];
    _lb2.text = @"188¥ / 份";
    _lb2.font = kFont(13);
    _lb2.textColor = RGB(225, 102, 125);
    [self.contentView addSubview:_lb2];
    
    UIImageView *linVC = [[UIImageView alloc]initWithFrame:CGRectMake(10*newKwith, _yunxdimg.endY+5*newKhight, kWidth-20*newKwith, 1)];
    linVC.backgroundColor = RGB(247, 247, 247);
    [self.contentView addSubview:linVC];
    
//    _jianBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    _jianBtn.frame = CGRectMake(193*newKwith, 26*newKhight, 18*newKwith, 18*newKhight);
//    _jianBtn.layer.masksToBounds = YES;
//    _jianBtn.layer.cornerRadius = 5;
//    _jianBtn.layer.borderColor = [RGB(227, 172, 80) CGColor];
//    _jianBtn.layer.borderWidth = 1;
//    [_jianBtn setTitle:@"－" forState:(UIControlStateNormal)];
//    [_jianBtn setTitleColor:RGB(227, 172, 80) forState:(UIControlStateNormal)];
//    [self.contentView addSubview:_jianBtn];
//    
    _lb3 = [[UILabel alloc]initWithFrame:CGRectMake(193*newKwith+39*newKwith, 26*newKhight, 10*newKwith, 18*newKhight)];
    _lb3.text = @"2";
    _lb3.font = kFont(14);
    _lb3.textColor = kblackColor;
    [self.contentView addSubview:_lb3];
    

//    _jiabtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    _jiabtn.frame = CGRectMake(_lb3.endX+21*newKwith, 26*newKhight, 18*newKwith, 18*newKhight);
//    _jiabtn.layer.masksToBounds = YES;
//    _jiabtn.layer.cornerRadius = 5;
//    _jiabtn.backgroundColor = RGB(227, 172, 80);
//    [_jiabtn setTitle:@"+" forState:(UIControlStateNormal)];
//    [_jiabtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
//    [self.contentView addSubview:_jiabtn];
//    
    
    _lb4 = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-71*newKwith, 26*newKhight, 50*newKwith, 20*newKhight)];
    _lb4.text = @"¥ 188";
    _lb4.font = kFont(13);
    _lb4.textAlignment = NSTextAlignmentRight;
    _lb4.textColor = RGB(225, 102, 125);
    [self.contentView addSubview:_lb4];
    
    UIImageView *linvc = [[UIImageView alloc]initWithFrame:CGRectMake(10*newKwith, _yunxdimg.endY+5*newKhight, kWidth-20*newKwith, 1)];
    linvc.backgroundColor = RGB(247, 247, 247);
    [self.contentView addSubview:linvc];
}

-(void)setModel:(XDModel *)model {

    [_yunxdimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIP,model.imgpath]] placeholderImage:[UIImage imageNamed:@""]];
    _lb1.text = model.dishname;
    _lb2.text = [NSString stringWithFormat:@"%0.2f / 份",[model.price floatValue]/100];
    _lb4.text = [NSString stringWithFormat:@"¥ %0.2f",[model.price floatValue]/100*[model.quantity integerValue]];
    _lb3.text = model.quantity;
}

-(void)setIncModel:(incomeModel *)incModel {
    DLog(@" --%@ --" ,incModel.name);
    
    [_yunxdimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIP,incModel.imgpath]] placeholderImage:[UIImage imageNamed:@""]];
    _lb1.text = incModel.name;
    _lb2.text = [NSString stringWithFormat:@"%0.2f / 份 ",incModel.price/100];
    _lb4.text = [NSString stringWithFormat:@"¥ %0.2f",incModel.price/100*incModel.quantity];
    _lb3.text = [NSString stringWithFormat:@" %ld",incModel.quantity];
    
}
-(void)setMycountmodel:(mycountModel *)mycountmodel {

    [_yunxdimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIP,mycountmodel.imgpath]] placeholderImage:[UIImage imageNamed:@""]];
    _lb1.text = mycountmodel.name;
    _lb2.text = [NSString stringWithFormat:@"%0.2f / 份",[mycountmodel.price floatValue]/100];
    _lb4.text = [NSString stringWithFormat:@"¥ %0.2f",[mycountmodel.price floatValue]/100*[mycountmodel.quantity floatValue]];
    _lb3.text = [NSString stringWithFormat:@"%@",mycountmodel.quantity];
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
