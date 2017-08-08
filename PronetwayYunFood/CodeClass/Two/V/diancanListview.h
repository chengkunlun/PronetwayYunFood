//
//  diancanListview.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/31.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListTableViewCell.h"

@protocol listtabviewDelegate <NSObject>

-(void)onpressaddBtn:(Home_CaiPinModel *)model selectArr:(NSMutableArray *)selectArr;

-(void)onpressreduceBtn:(Home_CaiPinModel *)model selectArr:(NSMutableArray *)selectArr;


@end

@interface diancanListview : UIView <UITableViewDelegate,UITableViewDataSource>
- (instancetype)initWithFrame:(CGRect)frame height:(CGFloat)height;

@property (strong, nonatomic) dispatch_block_t clearBlock;
@property (strong, nonatomic) dispatch_block_t clickbacgroundBlock;

@property (strong, nonatomic) dispatch_block_t addBlock;
@property (strong, nonatomic) dispatch_block_t reduceBlock;

@property (strong, nonatomic) UIView *bg;
@property (strong, nonatomic) UITableView *listTab;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIButton *clearBtn;
@property (strong, nonatomic)UITableView *tab;
@property (strong, nonatomic) NSMutableArray *alertListArr;

@property (nonatomic) CGFloat startH;

@property (strong, nonatomic) id<listtabviewDelegate>delegate;




@end
