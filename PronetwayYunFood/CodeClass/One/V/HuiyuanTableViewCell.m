//
//  HuiyuanTableViewCell.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/17.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "HuiyuanTableViewCell.h"

@implementation HuiyuanTableViewCell

-(void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, ColorRGB(0xf7f7f7).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 0.5, rect.size.width, 0.5));
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    [self addView];
}




-(void)addView{
   
    NSArray *arr = @[@"累积消费",@"消费次数",@"账户余额"];
    
    CGFloat w = kWidth;
    _sectionimgView = [[UIImageView alloc]initWithFrame:CGRectMake(-10*newKwith, -5*newKhight, w, 48*newKhight)];
    _sectionimgView.image = kimage(@"Yun_huiyuan_sectionimg");
    [self.contentView addSubview:_sectionimgView];
    
    _lb1 = [[UILabel alloc]initWithFrame:CGRectMake(10*newKwith, 0,w, 48*newKhight)];
    _lb1.text = @"18297786455";
    _lb1.textColor = RGB(85, 85, 85);
    _lb1.textAlignment = NSTextAlignmentCenter;
    _lb1.font = kFont(14);
    [_sectionimgView addSubview:_lb1];
    
    _lb9 = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-125*newKwith, 2*newKhight, 100*newKwith, 15*newKhight)];
    [self loadLabel:_lb9 text:@"2"];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-125*newKwith, _lb9.endY, 100*newKwith, 20*newKhight)];
    [self packLabel:lable text:@"未使用优惠券"];
    lable.font = kFont(11);
    lable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lable];
    
    CGFloat w1 = w/3;
    for (int i = 0; i<3; i++) {
        
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(i*w1, _sectionimgView.endY+32*newKhight, w1, 15*newKhight)];
        [self packLabel:lb text:arr[i]];
        [self.contentView addSubview:lb];
    }
    
    _lb2 = [[UILabel alloc]initWithFrame:CGRectMake(0, _sectionimgView.endY, w1, 34*newKhight)];
    [self loadLabel:_lb2 text:@"1457"];
    _lb2.textColor = kGreenColor;
    
    _lb3 = [[UILabel alloc]initWithFrame:CGRectMake(w1, _sectionimgView.endY, w1, 34*newKhight)];
    [self loadLabel:_lb3 text:@"1457"];
    _lb3.textColor = RGB(248, 176, 57);
    
    _lb4 = [[UILabel alloc]initWithFrame:CGRectMake(2*w1, _sectionimgView.endY, w1, 34*newKhight)];
    [self loadLabel:_lb4 text:@"108"];
    _lb4.textColor = RGB(70, 176, 225);
    
    _lb5 = [[UILabel alloc]initWithFrame:CGRectMake(3*w1, _sectionimgView.endY, w1, 34*newKhight)];
    [self loadLabel:_lb5 text:@"2"];
    _lb5.textColor = RGB(148, 89, 164);

    
    
    _changkeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _changkeBtn.frame = CGRectMake(0, _sectionimgView.endY+64*newKhight, 80*newKwith, 50*newKhight);
    [self pake:_changkeBtn imagename:@"Yun_home_huiyuan_changke" title:@"常客"];
    
    _huiyuanBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _huiyuanBtn.frame = CGRectMake(_changkeBtn.endX+10*newKwith, _sectionimgView.endY+64*newKhight, 80*newKwith, 50*newKhight);
    [self pake:_huiyuanBtn imagename:@"Yun_home_huiyuan_huiyuan" title:@"会员"];
    
    
    _vipBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _vipBtn.frame = CGRectMake(_huiyuanBtn.endX+10*newKwith, _sectionimgView.endY+64*newKhight, 80*newKwith, 50*newKhight);
    [self pake:_vipBtn imagename:@"Yun_home_huiyuan_vip" title:@"重要客户"];
    
//    
//    _lb6 = [[UILabel alloc]initWithFrame:CGRectMake(15*newKwith, _sectionimgView.endY+84*newKhight, 40*newKwith, 24*newKhight)];
//    _lb6.textColor = kWhiteColor;
//    _lb6.backgroundColor = kGreenColor;
//    _lb6.font = kBodlFont(14);
//    _lb6.text = @"常客";
//    _lb6.textAlignment = NSTextAlignmentCenter;
//    [self.contentView addSubview:_lb6];
//    

   
    _lb7 = [[UILabel alloc]initWithFrame:CGRectMake(10*newKwith,184*newKhight, 133*newKwith, 28*newKhight)];
    [self packLabel:_lb7 text:@"初次消费:2017-02-03"];
    [self.contentView addSubview:_lb7];
    
    _lb8 = [[UILabel alloc]initWithFrame:CGRectMake(_lb7.endX+57*newKwith,184*newKhight, 133*newKwith, 28*newKhight)];
    [self packLabel:_lb8 text:@"近期消费:2017-02-03"];
    [self.contentView addSubview:_lb8];

    self.SelectIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.SelectIconBtn.frame = CGRectMake(20*newKwith, 15*newKhight, 18*newKwith, 18*newKhight);
    [self.SelectIconBtn setImage:[UIImage imageNamed:@"table_UnSelect"] forState:UIControlStateNormal];
    [self.SelectIconBtn setImage:[UIImage imageNamed:@"table_Selected"] forState:UIControlStateSelected];
    self.SelectIconBtn.userInteractionEnabled = NO;
    [_sectionimgView addSubview:self.SelectIconBtn];
    
    UIView *livc = [[UIView alloc]initWithFrame:CGRectMake(0, 216*newKhight,kWidth-30*newKwith, 10*newKhight)];
    livc.backgroundColor = kCbgColor;
    [self.contentView addSubview:livc];
    
    
}

-(void)pake:(UIButton *)btn imagename:(NSString *)str title:(NSString *)title {

    [btn setImage:kimage(str) forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:RGB(153, 153, 153) forState:(UIControlStateNormal)];
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
    
    CGFloat totalHeight = (btn.imageView.frame.size.height + btn.titleLabel.frame.size.height);
    // 设置按钮图片偏移
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - btn.imageView.frame.size.height), 0.0, 0.0, -btn.titleLabel.frame.size.width)];
    // 设置按钮标题偏移
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -btn.imageView.frame.size.width, -(totalHeight - btn.titleLabel.frame.size.height),0.0)];
    [self.contentView addSubview:btn];
    btn.userInteractionEnabled  =NO;
    
}

-(void)loadLabel:(UILabel *)lab text:(NSString *)text{
    
    lab.font = kFont(14);
    lab.text = text;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = RGB(148, 89, 164);
    [self.contentView addSubview:lab];
}

-(void)packLabel:(UILabel *)lab text:(NSString *)text{

    lab.textColor = RGB(153, 153, 153);
    lab.font = kFont(12);
    lab.text = text;
    lab.textAlignment = NSTextAlignmentCenter;
}


-(void)UpdateCellWithState:(BOOL)select{
    self.SelectIconBtn.selected = select;
    _isSelected = select;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    //    self.SelectIconBtn.selected = !self.SelectIconBtn.selected;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
