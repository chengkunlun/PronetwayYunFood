//
//  SelectViewController.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/23.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YunCalssViewController.h"
#import "dianpuModel.h"
#import "kezhuofenquModel.h"
#import "StyleCaiPinModel.h"
@protocol selectDelegate <NSObject>

-(void)onpressSelectDianpu;
-(void)onpressaddKezhuo:(kezhuofenquModel*)kezhuofenquModel;

-(void)onpressstylecaipin:(StyleCaiPinModel *)model;//新增菜品种类
-(void)onpressAddCaipinStyle:(NSString *)style;

@end

@interface SelectViewController : YunCalssViewController

@property (strong, nonatomic) NSString *selectstr;
@property (strong, nonatomic) NSMutableArray *selectArr;
@property(nonatomic,strong)NSIndexPath *lastPath;
@property (strong, nonatomic) id<selectDelegate>delegate;


@end
