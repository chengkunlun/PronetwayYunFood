//
//  CKLclendarView.h
//  PronetwayGeneral
//
//  Created by ckl@pmm on 2017/1/5.
//  Copyright © 2017年 CKLPronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_RAT (SCREEN_WIDTH/320.0f)
#define INTTOSTR(intNum)         [@(intNum) stringValue]

typedef void(^ParttimeComplete)(NSArray *result);

@interface CKLclendarView : UIView
@property (nonatomic, strong) NSArray        *defaultDates;
@property (nonatomic, copy) ParttimeComplete complete;
@property (nonatomic) int indexForSelect;
- (id)initWithFrame:(CGRect)frame;
- (void)show;
- (void)hide;


@end
