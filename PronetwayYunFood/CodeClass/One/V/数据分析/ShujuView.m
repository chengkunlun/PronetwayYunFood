//
//  ShujuView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "ShujuView.h"

@implementation ShujuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    
    self.backgroundColor = kCbgColor;
    
  
   // UIScrollView *scr = [[UIScrollView alloc]initWithFrame:kBounds];
    //scr.contentOffset = CGPointMake(0, kHeight+150);
    //scr.backgroundColor = kCbgColor;
    //[self addSubview:scr];
    [self addSubview:self.topView];
    [self addSubview:self.bootmView];

    
    
}

-(UIView *)topView {

    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 5*newKhight, kWidth, 279*newKhight)];
        
        _topView.backgroundColor = kWhiteColor;
        
        _Top = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        _Top.backgroundColor = rgba(218, 246, 189, 1);
        [_topView addSubview:_Top];
        [self pake:_Top];

        _toptitleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        [self pakelab:_toptitleLab text:@"当前在店顾客: 120 人"];
        [_Top addSubview:_toptitleLab];
        
        [_topView addSubview:self.circleView_one];
        
       NSArray *arr = @[@"新客",@"常客",@"会员",@"重要客户"];
        NSArray *arr1 = @[@"Yun_shuju_xinke",@"Yun_home_huiyuan_changke",@"Yun_home_huiyuan_huiyuan",@"Yun_home_huiyuan_vip"];

        CGFloat w = kWidth/4;
        for (int i = 0; i<4; i++) {
            UIImageView *imgVC = [[UIImageView alloc]initWithFrame:CGRectMake((w-15)/2+i*(w), _topView.endY-40*newKhight, 15*newKwith, 15*newKhight)];
            imgVC.image = kimage(arr1[i]);
            [_topView addSubview:imgVC];
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(i*(w), _topView.endY-40*newKhight, w, 50*newKhight)];
            [self pakelab:lab text:arr[i]];
            lab.font = kFont(11);
            lab.textColor = RGB(153, 153, 153);
            [_topView addSubview:lab];
            
            
        }
        
    }
    return _topView;
}

-(UIView *)bootmView {
    
    if (!_bootmView) {
        _bootmView = [[UIView alloc]initWithFrame:CGRectMake(0, _topView.endY+8*newKhight, kWidth, 277*newKhight)];
        _bootmView.backgroundColor = kWhiteColor;
        
       _boot = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        _boot.backgroundColor = rgba(250, 240, 205, 1);
        [_bootmView addSubview:_boot];
        [self pake:_boot];
        
        _boomtitlemLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        [self pakelab:_boomtitlemLab text:@"今日到店顾客: 120 人"];
        [_boot addSubview:_boomtitlemLab];
        
        [_bootmView addSubview:self.circleView_two];

        _calendarBtn = [UIButton buttonWithType:(UIButtonTypeCustom)]
        ;
        _calendarBtn.frame = CGRectMake(15*newKwith, 12*newKhight, 24*newKwith, 20*newKhight);
        [_calendarBtn setImage:kimage(@"Yun_shuju_calendar") forState:(UIControlStateNormal)];
        [_boot addSubview:_calendarBtn];
        
        
        NSArray *arr = @[@"新客",@"常客",@"会员",@"重要客户"];
        NSArray *arr1 = @[@"Yun_shuju_xinke",@"Yun_home_huiyuan_changke",@"Yun_home_huiyuan_huiyuan",@"Yun_home_huiyuan_vip"];
        CGFloat w = kWidth/4;
        for (int i = 0; i<4; i++) {
            UIImageView *imgVC = [[UIImageView alloc]initWithFrame:CGRectMake((w-15)/2+i*(w), 232*newKhight, 15*newKwith, 15*newKhight)];
            imgVC.image = kimage(arr1[i]);
            [_bootmView addSubview:imgVC];
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(i*(w), 232*newKhight, w, 50*newKhight)];
            [self pakelab:lab text:arr[i]];
            lab.font = kFont(11);
            lab.textColor = RGB(153, 153, 153);
            [_bootmView addSubview:lab];
            
            
        }
    }
    return _bootmView;
}

- (CircleView *)circleView_one{
    if (!_circleView_one) {
        NSMutableArray *dateArray = [[NSMutableArray alloc]initWithArray:@[
                                                                           @{@"number":@"100",@"color":@"ED608A",@"name":@"新客"},
                                                                           @{@"number":@"200",@"color":@"1DD5A6",@"name":@"常客"},
                                                                           @{@"number":@"120",@"color":@"F5BE00",@"name":@"重要客户"},
                                                                           @{@"number":@"50",@"color":@"9BD903",@"name":@"会员"}]];
        _circleView_one = [[CircleView alloc]initWithFrame:CGRectMake(0, _Top.endY, self.frame.size.width, 200*newKhight) andUrlStr:@"融资" dateArr:dateArray];
    }
    return _circleView_one;
}

- (CircleView *)circleView_two
{
    if (!_circleView_two) {
        
        NSMutableArray *dateArray = [[NSMutableArray alloc]initWithArray:@[
                                                                           @{@"number":@"100",@"color":@"9BD903",@"name":@"会员"},
                                                                           @{@"number":@"50",@"color":@"F5BE00",@"name":@"重要客户"},
                                                                           @{@"number":@"100",@"color":@"#ED608A",@"name":@"新客"},
                                                                           @{@"number":@"50",@"color":@"1DD5A6",@"name":@"常客"}]];
        _circleView_two = [[CircleView alloc]initWithFrame:CGRectMake(0, _boot.endY, self.frame.size.width, 200*newKhight) andUrlStr:@"" dateArr:dateArray];
        
    }
    
    return _circleView_two;
}

-(void)pake:(UIImageView *)imgview {

    imgview.layer.shadowColor = [[UIColor blackColor] CGColor];//阴影颜色
    imgview.layer.shadowOffset = CGSizeMake(4, 4);//偏移距离
    imgview.layer.shadowOpacity = 0.6;//不透明度
    imgview.layer.shadowRadius =3.0;//半径
}


-(void)pakelab:(UILabel *)lab  text:(NSString *)text{

    lab.font = kFont(15);
    lab.textColor = RGB(51, 51, 51);
    lab.text = text;
    lab.textAlignment = NSTextAlignmentCenter;
    
}

@end
