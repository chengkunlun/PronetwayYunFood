//
//  explainView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/25.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface explainView : UIView
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text;
@property (strong, nonatomic) UILabel *explainlab;
@property (assign) CGRect framee;
@end
