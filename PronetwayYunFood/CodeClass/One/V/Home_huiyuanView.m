//
//  Home_huiyuanView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/17.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_huiyuanView.h"

@implementation Home_huiyuanView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

-(void)addView{
    [self addSubview:self.topView];
    [self addSubview:self.home_huiyuanTab];
    [self addSubview:self.bootmView];
    self.backgroundColor  =kCbgColor;
    
    [self addSubview:self.MassSMSbtn];

    [kNotificationCenter addObserver:self selector:@selector(gunmassage) name:@"gunmessage" object:nil];
    _dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    _dataArr = [NSMutableArray arrayWithObjects:@"0",@"1",@"2", @"3",@"4",nil];
}


-(UIView *)topView {


    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 88*newKhight)];
        _topView.backgroundColor = kWhiteColor;
        
//        UIView *hb = [[UIView alloc]initWithFrame:CGRectMake((kWidth-360)/2, 0, 360*newKwith, 44*newKhight)];
//        hb.layer.masksToBounds = YES;
//        hb.layer.cornerRadius = 5;
//        hb.backgroundColor = RGB(232, 232, 231);
//        [_topView addSubview:hb];

        _whbgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        _whbgView.backgroundColor = RGB(232, 232, 232);
        [_topView addSubview:_whbgView];
        //创建UISearchController
        //搜索时，背景变模糊
        self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        
        //三个默认都是yes
        //搜索时背景变暗色
        self.searchController.dimsBackgroundDuringPresentation = NO;
        
        //搜索时，背景变模糊
        self.searchController.obscuresBackgroundDuringPresentation = NO;
        
        //点击搜索的时候,是否隐藏导航栏
        self.searchController.hidesNavigationBarDuringPresentation = YES;
        
        //包着搜索框外层的颜色
        self.searchController.searchBar.barTintColor = RGB(232, 232, 232);
        //提醒字眼
        self.searchController.searchBar.placeholder= @"请输入桌号或者分区";
        //除掉bar下面的黑线
        UIImageView *barImageView = [[[self.searchController.searchBar.subviews firstObject] subviews] firstObject];
        barImageView.layer.borderColor = RGB(232,232,232).CGColor;
        barImageView.layer.borderWidth = 1;
        
        //提前在搜索框内加入搜索词
        self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0*newKhight);
        [_whbgView addSubview:self.searchController.searchBar];
        
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消"];
        
//        UIImageView *search = [[UIImageView alloc]initWithFrame:CGRectMake(3*newKwith, 7*newKhight, 180*newKwith, 16*newKhight)];
//        search.image = kimage(@"Yun_huiyuan_search");
//        [hb addSubview:search];
//        
//        UIImageView *clear = [[UIImageView alloc]initWithFrame:CGRectMake(328*newKwith, 8*newKhight, 14*newKwith, 14*newKhight)];
//        clear.image = kimage(@"Yun_huiyuan_clear");
//        [hb addSubview:clear];
        
        _Timebtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _Timebtn.frame = CGRectMake(15*newKwith, 50*newKhight, 70*newKwith, 30*newKhight);
        [_Timebtn setTitleColor:kRedColor forState:(UIControlStateNormal)];
        [_Timebtn setTitle:@"按时间排序" forState:(UIControlStateNormal)];
        _Timebtn.titleLabel.font = kFont(11);
        [_Timebtn addTarget:self action:@selector(TimeClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_topView addSubview:_Timebtn];
        
        _expensebtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _expensebtn.frame = CGRectMake(_Timebtn.endX+77*newKwith, 50*newKhight, 70*newKwith, 30*newKhight);
        [_expensebtn setTitleColor:RGB(85, 85, 85) forState:(UIControlStateNormal)];
        [_expensebtn setTitle:@"按消费排序" forState:(UIControlStateNormal)];
        _expensebtn.titleLabel.font = kFont(11);
        [_expensebtn addTarget:self action:@selector(expenseClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_topView addSubview:_expensebtn];
        
        _selectbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _selectbtn.frame = CGRectMake(300*newKwith, 44*newKhight, 50*newKwith, 44*newKhight);
        [_selectbtn setTitleColor:RGB(185, 185, 185) forState:(UIControlStateNormal)];
        [_selectbtn setTitle:@"筛选" forState:(UIControlStateNormal)];
        [_selectbtn setImage:kimage(@"Yun_home_huiyuan_select") forState:(UIControlStateNormal)];
        _selectbtn.titleLabel.font = kFont(12);
        
        CGFloat totalHeight = (_selectbtn.imageView.frame.size.height + _selectbtn.titleLabel.frame.size.height);
        // 设置按钮图片偏移
        [_selectbtn setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - _selectbtn.imageView.frame.size.height), 0.0, 0.0, -_selectbtn.titleLabel.frame.size.width)];
        // 设置按钮标题偏移
        [_selectbtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -_selectbtn.imageView.frame.size.width, -(totalHeight - _selectbtn.titleLabel.frame.size.height),0.0)];
    
        [_topView addSubview:_selectbtn];

        
    }
    return _topView;
}

-(UIView *)bootmView {

    if (!_bootmView) {
        _bootmView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight-kNavBarHAndStaBarH-44*newKhight, kWidth, 44*newKhight)];
        _bootmView.backgroundColor = kWhiteColor;

        CGFloat w = kWidth/2;
        _ChongBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _ChongBtn.frame = CGRectMake(0, 0, w, 44*newKhight);
        [_ChongBtn setTitleColor:kRedColor forState:(UIControlStateNormal)];
        [_ChongBtn setTitle:@"充值营销" forState:(UIControlStateNormal)];
        _ChongBtn.titleLabel.font = kFont(14);
        [_bootmView addSubview:_ChongBtn];
        
       
        _messageBtn = [[RedBtn alloc]initWithFrame:CGRectMake(w, 0, w, 44*newKhight) text:@"群发消息"];
        [_bootmView addSubview:_messageBtn];
        [_messageBtn addTarget:self action:@selector(message:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _bootmView;
}


//群发消息
-(RedBtn *)MassSMSbtn {

    if (!_MassSMSbtn) {
        _MassSMSbtn = [[RedBtn alloc]initWithFrame:CGRectMake(0, kHeight-kNavBarHAndStaBarH, kWidth, 44*newKhight) text:@"发送消息"];
        [_MassSMSbtn addTarget:self action:@selector(massbtn:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _MassSMSbtn;
    
}

-(UITableView *)home_huiyuanTab {
    
    if (!_home_huiyuanTab) {
        
        _choosedArr = [[NSMutableArray alloc]initWithCapacity:0];
        _home_huiyuanTab = [[UITableView alloc]initWithFrame:CGRectMake(15*newKhight, _topView.endY+21*newKhight, kWidth-30*newKwith, kHeight-kNavigationBarH-10*newKhight-_topView.endY-20*newKhight-44*newKhight-10*newKhight)];
        _home_huiyuanTab.delegate = self;
        _home_huiyuanTab.dataSource = self;
        _home_huiyuanTab.rowHeight = 226*newKhight;
      //  [_home_huiyuanTab registerClass:[HuiyuanTableViewCell class] forCellReuseIdentifier:@"huiyuancell"];
        _home_huiyuanTab.backgroundColor = kClearColor;
        _home_huiyuanTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _home_huiyuanTab;
}
//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * identifier = [NSString stringWithFormat:@"cellId%ld",(long)indexPath.row];
    HuiyuanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HuiyuanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    //HuiyuanTableViewCell *cell = [[HuiyuanTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"huiyuancell"];
    
    if (_ifAllSelecteSwitch) {
        [cell UpdateCellWithState:_ifAllSelected];
        if (indexPath.row == _dataArr.count-1) {
            _ifAllSelecteSwitch  = NO;
        }
    }else {
    
    //    [cell UpdateCellWithState:_ifAllSelected];

    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
//tabview的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HuiyuanTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell UpdateCellWithState:!cell.isSelected];
    
    if (cell.isSelected) {
        [_choosedArr addObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
    }
    else{
        [_choosedArr removeObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
    }
    
    if (_choosedArr.count<_dataArr.count) {
        _ifAllSelected = NO;
        
        DLog(@" ------- 修改全选的状态 -----");
        [kNotificationCenter postNotificationName:@"kchangeright" object:nil];
//        UIButton * chooseIcon = (UIButton *)[_MyTable.tableHeaderView viewWithTag:10];
//        chooseIcon.selected = _ifAllSelected;
    }
    _block(cell.lb9.text,_choosedArr);
}

-(void)ReloadData{
    [self.MyTable reloadData];
}


//时间
-(void)TimeClick:(UIButton *)btn {
    [_expensebtn setTitleColor:RGB(85, 85, 85) forState:(UIControlStateNormal)];
    [_Timebtn setTitleColor:kRedColor forState:(UIControlStateNormal)];
    
}

//消费
-(void)expenseClick:(UIButton *)btn {

    [_Timebtn setTitleColor:RGB(85, 85, 85) forState:(UIControlStateNormal)];
    [_expensebtn setTitleColor:kRedColor forState:(UIControlStateNormal)];
    
    
}

//弹出发送消息 并增加按钮
-(void)message:(RedBtn *)btn{
    if (![ValidateUtil checkuserType]) {
        
        [WSProgressHUD showImage:nil status:@"暂无权限"];
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(showRightBtn)]) {
        
        [_delegate showRightBtn];
    }
    
    
    [UIView animateWithDuration:0.5 animations:^{
        _bootmView.frame = CGRectMake(0, kHeight-kNavBarHAndStaBarH, kWidth, 44*newKhight);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.MassSMSbtn.frame  =CGRectMake(0, kHeight-kNavBarHAndStaBarH-44*newKhight, kWidth, 44*newKhight);
        }];
    }];
}

//发完消息后复原
-(void)gunmassage {

    if (_delegate && [_delegate respondsToSelector:@selector(hideRightBtn)]) {
        
        [_delegate hideRightBtn];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.MassSMSbtn.frame  =CGRectMake(0, kHeight-kNavBarHAndStaBarH, kWidth, 44*newKhight);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            _bootmView.frame = CGRectMake(0, kHeight-kNavBarHAndStaBarH-44*newKhight, kWidth, 44*newKhight);
        }];
    }];

    
}

//群发消息选中后确定
-(void)massbtn:(RedBtn *)btn {

    if (_delegate && [_delegate respondsToSelector:@selector(onpress)]) {
        
        [_delegate onpress];
    }
}

//全选按钮的点击事件
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


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self endEditing:YES];
}


@end
