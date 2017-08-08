//
//  ChongzhiView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/19.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "ChongzhiView.h"

@implementation ChongzhiView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
  
    
    [self addSubview:self.Home_huiyuan_colectVC];
}

#pragma mark --- collectionview创建集合视图 ---
-(UICollectionView *)Home_huiyuan_colectVC {
    
    if (!_Home_huiyuan_colectVC) {
        
        //先实例化一个层
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //创建collectionview
        _Home_huiyuan_colectVC = [[UICollectionView alloc]initWithFrame:CGRectMake(15*newKwith, 20*newKhight, kWidth-30*newKwith, kHeight-kNavBarHAndStaBarH) collectionViewLayout:layout];
        //注册cell
        [_Home_huiyuan_colectVC registerClass:[Chongcollectcell class] forCellWithReuseIdentifier:@"Home_huiyuan_colectcell"];
        _Home_huiyuan_colectVC.backgroundColor = [UIColor clearColor];

    }
    return _Home_huiyuan_colectVC;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
