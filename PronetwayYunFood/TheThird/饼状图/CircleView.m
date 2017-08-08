//
//  CircleView.m
//  YCT
//
//  Created by 余晋龙 on 16/9/21.
//  Copyright © 2016年 bzjc. All rights reserved.
//


#define TITLE_HEIGHT 60
#define PIE_HEIGHT 200
#define Radius 65.5 //圆形比例图的半径

#import "CircleView.h"
#import "CircleMapView.h"


@interface CircleView()
{
 CircleMapView *circleView;
    id delegate;
}
@end
@implementation CircleView
-(instancetype)initWithFrame:(CGRect)frame andUrlStr:(NSString *)str dateArr:(NSMutableArray *)dateArr;
{
    if (self = [super initWithFrame:frame]) {
        _str = str;
        //
       
        [self addCirclView:dateArr];  //添加饼状图
    }
    return self;
}
//添加圆形比例图
-(void)addCirclView:(NSMutableArray *)arr{
    if (!circleView) {
        circleView = [[CircleMapView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, PIE_HEIGHT) andWithDataArray:arr andWithCircleRadius:Radius];
        circleView.backgroundColor = [UIColor whiteColor];
        circleView.dataArray = arr;
    }
    [self addSubview:circleView];
}
@end
