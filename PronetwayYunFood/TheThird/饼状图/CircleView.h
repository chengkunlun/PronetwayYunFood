//
//  CircleView.h
//  YCT
//
//  Created by 余晋龙 on 16/9/21.
//  Copyright © 2016年 bzjc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView
//饼状图数据array
@property (nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic , copy) NSString *str;
-(instancetype)initWithFrame:(CGRect)frame andUrlStr:(NSString *)str dateArr:(NSMutableArray *)dateArr;
@end
