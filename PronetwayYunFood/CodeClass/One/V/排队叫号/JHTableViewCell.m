//
//  JHTableViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/13.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "JHTableViewCell.h"

@implementation JHTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    self.backgroundColor = kWhiteColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 7;
    
    CGFloat w = (kWidth-30*newKwith)/3;
    _lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 40*newKhight, kWidth/3, 30*newKhight)];
    [self pakeLab:_lab4 text:@"闲"];
    
    _lab5 = [[UILabel alloc]initWithFrame:CGRectMake(w*2, 40*newKhight, kWidth/3, 30*newKhight)];
    [self pakeLab:_lab5 text:@"排"];
    
    _lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, _lab4.endY, kWidth/3, 30*newKhight)];
    [self pakeLab:_lab1 text:@"5"];
    
    _lab3 = [[UILabel alloc]initWithFrame:CGRectMake(w*2, _lab4.endY, kWidth/3,30*newKhight)];
    [self pakeLab:_lab3 text:@"4"];
    
    
    _cicrView = [[UIView alloc]initWithFrame:CGRectMake((kWidth-120*newKwith)/2, 10*newKhight, 120*newKwith, 120*newKhight)];
    _cicrView.backgroundColor = kBlueColor;
    _cicrView.layer.masksToBounds = YES;
    _cicrView.layer.cornerRadius = _cicrView.size.height/2;
    [self.contentView addSubview:_cicrView];
    
    _letterLab = [[UILabel alloc]initWithFrame:CGRectMake((_cicrView.size.width-43*newKwith)/2, (_cicrView.size.height-36*newKhight)/2, 43*newKwith, 36*newKhight)];
    _letterLab.textColor = RGB(51, 51, 51);
    _letterLab.font = kBodlFont(44);
    _letterLab.textAlignment = NSTextAlignmentCenter;
    [_cicrView addSubview:_letterLab];
    
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 80*newKhight, _cicrView.width, 36*newKhight)];
    _lab.font = kBodlFont(14);
    _lab.text = @"客桌类型";
    _lab.textAlignment = NSTextAlignmentCenter;
    [_cicrView addSubview:_lab];
    
    
}

-(void)pakeLab:(UILabel *)lab text:(NSString *)text {

    lab.textColor = RGB(51, 51, 51);
    lab.font = kBodlFont(20);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = text;
    [self.contentView addSubview:lab];
}


-(void)setModel:(paidui_listModel *)model {

    
   //_lab1.text = [NSString stringWithFormat:@"%@",model.totidle];
   // _lab3.text = [NSString stringWithFormat:@"%@",model.totque];

    NSString *tot = [NSString stringWithFormat:@"%@",model.totidle];
    
    NSString *tou = [NSString stringWithFormat:@"%@",model.totque];

    if ([tot isEqualToString:@"(null)"]) {
        _lab1.text = @"0";
    }else {
        _lab1.text = [NSString stringWithFormat:@"%@",model.totidle];
    }
    if ([tou isEqualToString:@"(null)"]) {
        _lab3.text = @"0";
        
    }else {
         _lab3.text = [NSString stringWithFormat:@"%@",model.totque];
    }
    _letterLab.text = model.code;//A B C
    
    if ([model.code isEqualToString:@"A"]) {
        
        if (model.selected == YES) {
            
            [self selectColor:kWhiteColor NormalColor:kBlueColor Selected:(YES)];
            
        }else {
            [self selectColor:kWhiteColor NormalColor:kBlueColor Selected:(NO)];
        }
        
    }else if ([model.code isEqualToString:@"B"]){
        if (model.selected == YES) {
            
            [self selectColor:kWhiteColor NormalColor:kyellowcolor Selected:(YES)];
            
        }else {
            
            [self selectColor:kWhiteColor NormalColor:kyellowcolor Selected:(NO)];
        }
        
    }else if ([model.code isEqualToString:@"C"]){
        
        if (model.selected == YES) {
            
            [self selectColor:kWhiteColor NormalColor:kGreenColor Selected:(YES)];
            
        }else {
            
            [self selectColor:kWhiteColor NormalColor:kGreenColor Selected:(NO)];
        }
    }else if ([model.code isEqualToString:@"D"]){
        
        if (model.selected == YES) {
            
            [self selectColor:kWhiteColor NormalColor:kpurplecolor Selected:(YES)];
            
        }else {
            
            [self selectColor:kWhiteColor NormalColor:kpurplecolor Selected:(NO)];
            
        }
        
        
    }else if ([model.code isEqualToString:@"E"]){
        
        if (model.selected == YES) {
            
            [self selectColor:kWhiteColor NormalColor:kRedColor Selected:(YES)];
            
        }else {
            
            [self selectColor:kWhiteColor NormalColor:kRedColor Selected:(NO)];
            
        }
        
    }else if ([model.code isEqualToString:@"F"]){
        
        if (model.selected == YES) {
            
            [self selectColor:kWhiteColor NormalColor:kBlueColor Selected:(YES)];
            
        }else {
            
            [self selectColor:kWhiteColor NormalColor:kBlueColor Selected:(NO)];
            
        }
        
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)selectColor:(UIColor *)selectcolor NormalColor:(UIColor *)normalColor Selected:(BOOL)selected{

    self.contentView.backgroundColor = selected ? normalColor : selectcolor;
    _lab4.textColor = selected ? selectcolor : normalColor;
    _lab5.textColor = selected ? selectcolor : normalColor;
    _lab1.textColor = selected ? selectcolor : normalColor;
    _lab3.textColor = selected ? selectcolor : normalColor;
    _lab.textColor = selected ? normalColor : selectcolor;
    _letterLab.textColor = selected ? normalColor : selectcolor;
    _cicrView.backgroundColor = selected ? selectcolor : normalColor;
}

@end
