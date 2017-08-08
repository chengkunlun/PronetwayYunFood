//
//  SJ_caipinTableViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "SJ_caipinTableViewCell.h"

@implementation SJ_caipinTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    _shujuimg = [[UIImageView alloc]initWithFrame:CGRectMake(10*newKwith, 13*newKhight, 18*newKwith, 18*newKhight)];
    _shujuimg.image = kimage(@"Yun_shuju_star_select");

    [self.contentView addSubview:_shujuimg];
    
    CGFloat w = (kWidth-30)/4;
    _lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, 44*newKhight)];
    [self pakeLb:_lab1 text:@"1"];
    
    _lab2 = [[UILabel alloc]initWithFrame:CGRectMake(w, 0, w, 44*newKhight)];
    [self pakeLb:_lab2 text:@"麻辣小龙虾"];
    
//    _lab3 = [[UILabel alloc]initWithFrame:CGRectMake(2*w, 0, w, 44*newKhight)];
//    [self pakeLb:_lab3 text:@"144"];
    
    _lab4 = [[UILabel alloc]initWithFrame:CGRectMake(2*w, 0, w, 44*newKhight)];
    [self pakeLb:_lab4 text:@"666"];
    
    _lab5 = [[UILabel alloc]initWithFrame:CGRectMake(3*w, 0, w, 44*newKhight)];
    [self pakeLb:_lab5 text:@"345543"];

    UIView *liVC = [[UIView alloc]initWithFrame:CGRectMake(0, 43*newKhight, kWidth, 1*newKhight)];
    liVC.backgroundColor = kCbgColor;
    [self.contentView addSubview:liVC];
    

}

-(void)loadModel:(CaiPsticsModel *)model index:(NSInteger)index {

    _lab1.text = [NSString stringWithFormat:@"%ld",index+1];
    _lab2.text = model.name;
    _lab4.text = model.quantitys;
    _lab5.text = model.allmoneys;

}

-(void)pakeLb:(UILabel *)lab text:(NSString *)text {

    lab.text = text;
    lab.textColor = RGB(85, 85, 85);
    lab.font = kFont(14);
    lab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lab];
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
