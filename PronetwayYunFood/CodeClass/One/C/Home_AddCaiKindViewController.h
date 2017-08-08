//
//  Home_AddCaiKindViewController.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/17.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YunCalssViewController.h"
#import "Home_CaiPinModel.h"
@interface Home_AddCaiKindViewController : YunCalssViewController

@property (strong, nonatomic) NSString *selectStr;
@property (strong, nonatomic) NSMutableArray *caipinArr;
@property (strong, nonatomic) Home_CaiPinModel *caiModel;
@property (strong, nonatomic) StyleCaiPinModel *styleModel;

@end
