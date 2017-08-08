//
//  ShaixuanView.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/21.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShaixuanView : UIView<UITableViewDataSource,UITableViewDelegate>
typedef void(^ChooseBlock) (NSString *chooseContent,NSMutableArray *chooseArr);
@property(nonatomic,strong)UITableView * MyTable;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * choosedArr;
@property(nonatomic,copy)ChooseBlock block;
@property (nonatomic,assign)BOOL ifAllSelected;
@property (nonatomic,assign)BOOL ifAllSelecteSwitch;

+(ShaixuanView *)ShareTableWithFrame:(CGRect)frame HeaderTitle:(NSString *)title;//有Header
+(instancetype)ShareTableWithFrame:(CGRect)frame;//无Header
-(void)ReloadData;

@end
