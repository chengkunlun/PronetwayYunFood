//
//  Home_huiyuanView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/17.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HuiyuanTableViewCell.h"

@protocol HomehuiyuanDelegate <NSObject>

typedef void(^ChooseBlock) (NSString *chooseContent,NSMutableArray *chooseArr);

-(void)showRightBtn;

-(void)onpress;

-(void)hideRightBtn;

@end

@interface Home_huiyuanView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *home_huiyuanTab;
@property (strong, nonatomic) UIView *topView;

@property (strong, nonatomic) UIButton *Timebtn;
@property (strong, nonatomic) UIButton *expensebtn;

@property (strong, nonatomic) UIButton *selectbtn;

@property (strong, nonatomic) UIView *bootmView;

@property (strong, nonatomic) UIButton *ChongBtn;
@property (strong, nonatomic) RedBtn *messageBtn;

@property (strong, nonatomic) RedBtn *MassSMSbtn;

@property (strong, nonatomic) dispatch_block_t massbtnBlock;

@property (strong, nonatomic) id<HomehuiyuanDelegate>delegate;

//搜索框
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) UIView *whbgView;

@property(nonatomic,strong)UITableView * MyTable;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * choosedArr;
@property(nonatomic,copy)ChooseBlock block;
@property (nonatomic,assign)BOOL ifAllSelected;
@property (nonatomic,assign)BOOL ifAllSelecteSwitch;

-(void)ReloadData;



@end
