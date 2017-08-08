//
//  DCSearchTableViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/7.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "DCSearchTableViewCell.h"

@implementation DCSearchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    

    self.backgroundColor = kWhiteColor;
    
//    _fenquLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kWidth, self.height)];
//    _fenquLb.text = @"A";
//    _fenquLb.textColor = kRedColor;
//    _fenquLb.font = kFont(16);
//    [self.contentView addSubview:_fenquLb];
//
    
    _img = [[UIImageView alloc]initWithFrame:CGRectMake(10*newKwith, 16*newKhight, 28*newKwith, 28*newKhight)];
    [self.contentView addSubview:_img];
    
    _desknumber = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth, 30*newKhight)];
    _desknumber.textColor = kyellowcolor;
    _desknumber.text = @"";
    _desknumber.font = kBodlFont(16);
    _desknumber.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_desknumber];
    
    _setnum = [[UILabel alloc]initWithFrame:CGRectMake(0, _desknumber.endY, kWidth, 30*newKhight)];
    _setnum.textColor = kyellowcolor;
    _setnum.text = @"";
    _setnum.font = kFont(14);
    _setnum.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_setnum];
    
    UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(10*newKwith, 59*newKhight, kWidth-20*newKwith, 1)];
    linVC.backgroundColor = kCbgColor;
    [self.contentView addSubview:linVC];
    
    

    
}

-(void)setModel:(searchModel *)model {

    
    _desknumber.text = [NSString stringWithFormat:@"%@-%@",model.name,model.numid];
    _setnum.text = [NSString stringWithFormat:@"%@ 人桌",model.seatnum];
    if ([model.status isEqualToString:@"0"]) {//空闲
        self.backgroundColor = kWhiteColor;
        _setnum.textColor = rgba(85, 85, 85, 1);
        _desknumber.textColor = rgba(85, 85, 85, 1);
        _img.image = kimage(@"Yun_order_kong");

        
    }else {//1被占
       // self.backgroundColor = kyellowcolor;
        _setnum.textColor = kyellowcolor;
        _desknumber.textColor = kyellowcolor;
        _img.image = kimage(@"Yun_order_kongselect");

    }
    
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
