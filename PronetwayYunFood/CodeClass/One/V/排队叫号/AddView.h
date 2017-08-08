//
//  AddView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/13.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLMOptionSelectView.h"
#import "UIView+Category.h"
@interface AddView : UIView

@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UITextField *nameT;
@property (strong, nonatomic) UILabel *people;
@property (strong, nonatomic) UITextField *StarT;
@property (strong, nonatomic) UITextField *EndT;
@property (strong, nonatomic) UILabel *daiHLab;
@property (strong, nonatomic) UIButton *Btn;
@property (strong, nonatomic) RedBtn *Savebtn;
@property (strong, nonatomic) UIImageView *arrowimg;

@property (strong, nonatomic) UILabel *subTitle;

@property (strong, nonatomic) selectBtnView *selectVC;

@end
