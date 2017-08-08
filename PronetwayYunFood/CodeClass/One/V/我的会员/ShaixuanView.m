//
//  ShaixuanView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/21.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "ShaixuanView.h"
#import "ShaixuanTableViewCell.h"
@implementation ShaixuanView


#define HeaderHeight 50
#define CellHeight 50
+(ShaixuanView *)ShareTableWithFrame:(CGRect)frame HeaderTitle:(NSString *)title{
    ShaixuanView * shareInstance = [[ShaixuanView alloc] initWithFrame:frame HaveHeader:YES HeaderTitle:title];
    return  shareInstance;
}

+(instancetype)ShareTableWithFrame:(CGRect)frame{
//    static ShaixuanView *shareInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
      ShaixuanView* shareInstance = [[ShaixuanView alloc] initWithFrame:frame HaveHeader:NO HeaderTitle:nil];
//    });
    return  shareInstance;
}

-(instancetype)initWithFrame:(CGRect)frame HaveHeader:(BOOL)ifhHave HeaderTitle:(NSString *)title{
    self = [super init];
    if(self){
        self.frame = frame;
        [self CreateTable];
        if(ifhHave){
            UIView * view = [self CreateHeaderView_HeaderTitle:title];
            _MyTable.tableHeaderView = view;
        }
    }
    return self;
}

-(void)CreateTable{
    _choosedArr = [[NSMutableArray alloc]initWithCapacity:0];
    _MyTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 10*newKhight, kWidth, self.frame.size.height)];
    _MyTable.dataSource = self;
    _MyTable.delegate = self;
    _MyTable.separatorStyle = UITableViewStylePlain;
    [self addSubview:_MyTable];
}

-(UIView *)CreateHeaderView_HeaderTitle:(NSString *)title{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, HeaderHeight)];
    UILabel * HeaderTitleLab = [[UILabel alloc]init];
    HeaderTitleLab.text = title;
    [headerView addSubview:HeaderTitleLab];
    [HeaderTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(15);
        make.top.equalTo(headerView.mas_top).offset(0);
        make.height.mas_equalTo(headerView.mas_height);
    }];
    UIButton *chooseIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseIcon.tag = 10;
    [chooseIcon setImage:[UIImage imageNamed:@"table_UnSelect"] forState:UIControlStateNormal];
    [chooseIcon setImage:[UIImage imageNamed:@"table_Selected"] forState:UIControlStateSelected];
    chooseIcon.userInteractionEnabled = NO;
    [headerView addSubview:chooseIcon];
    [chooseIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(HeaderTitleLab.mas_right).offset(10);
        make.right.equalTo(headerView.mas_right).offset(-15);
        make.top.equalTo(headerView.mas_top);
        make.height.mas_equalTo(headerView.mas_height);
        make.width.mas_equalTo(50);
    }];
    
    UIButton * chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBtn.frame = CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height);
    [chooseBtn addTarget:self action:@selector(ChooseAllClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:chooseBtn];
    return headerView;
}


-(void)ChooseAllClick:(UIButton *)button{
    _ifAllSelecteSwitch = YES;
    UIButton * chooseIcon = (UIButton *)[_MyTable.tableHeaderView viewWithTag:10];
    chooseIcon.selected = !_ifAllSelected;
    _ifAllSelected = !_ifAllSelected;
    if (_ifAllSelected) {
        [_choosedArr removeAllObjects];
        [_choosedArr addObjectsFromArray:_dataArr];
    }
    else{
        [_choosedArr removeAllObjects];
    }
    [_MyTable reloadData];
    _block(@"All",_choosedArr);
    
}

#pragma UITableViewDelegate - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    ShaixuanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ShaixuanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
    
        cell.shaixuanimg.frame = CGRectMake(10*newKwith, 11*newKhight, 33*newKwith, 22*newKhight);
        cell.shaixuanimg.backgroundColor = RGB(218, 246, 189);

    }else if (indexPath.row == 1){
    
        cell.shaixuanimg.frame = CGRectMake(10*newKwith, 8*newKhight, 28*newKwith, 28*newKhight);
        cell.shaixuanimg.image = kimage(@"Yun_home_huiyuan_changke");
    }else if (indexPath.row == 2){
        
        cell.shaixuanimg.frame = CGRectMake(10*newKwith, 8*newKhight, 24*newKwith, 28*newKhight);
        cell.shaixuanimg.image = kimage(@"Yun_home_huiyuan_huiyuan");
    }else if (indexPath.row == 3){
        
        cell.shaixuanimg.frame = CGRectMake(10*newKwith, 11*newKhight, 25*newKwith, 22*newKhight);
        cell.shaixuanimg.image = kimage(@"Yun_home_huiyuan_vip");
    }
    cell.titleLabel.text = [_dataArr objectAtIndex:indexPath.row];
    
    if (_ifAllSelecteSwitch) {
        [cell UpdateCellWithState:_ifAllSelected];
        if (indexPath.row == _dataArr.count-1) {
            _ifAllSelecteSwitch  = NO;
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShaixuanTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell UpdateCellWithState:!cell.isSelected];
    
    if (cell.isSelected) {
        [_choosedArr addObject:cell.titleLabel.text];
    }
    else{
        [_choosedArr removeObject:cell.titleLabel.text];
    }
    
    if (_choosedArr.count<_dataArr.count) {
        _ifAllSelected = NO;
        UIButton * chooseIcon = (UIButton *)[_MyTable.tableHeaderView viewWithTag:10];
        chooseIcon.selected = _ifAllSelected;
        
        //发通知改变状态
        [kNotificationCenter postNotificationName:@"selectAll" object:nil];
    }
    _block(cell.titleLabel.text,_choosedArr);
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)ReloadData{
    [self.MyTable reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
