//
//  AdddianpuViewController.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "YunCalssViewController.h"

@protocol addDianpudelegate <NSObject>

-(void)adddianpuArr:(NSArray *)Arr;

@end
@interface AdddianpuViewController : YunCalssViewController

@property (strong, nonatomic) id<addDianpudelegate>delegate;
@property (strong, nonatomic) NSString *selectstr;
@property (strong, nonatomic) NSMutableArray *ChangeArr;
@property (strong, nonatomic) dianpuModel *model;
@end
