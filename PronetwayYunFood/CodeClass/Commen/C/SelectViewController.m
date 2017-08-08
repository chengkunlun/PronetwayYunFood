//
//  SelectViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/23.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "SelectViewController.h"

@interface SelectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *selectTab;
@property (strong, nonatomic) RedBtn *bootbtn;

@property (strong, nonatomic) NSIndexPath *tabselectindex;

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.selectTab respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.selectTab setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.selectTab respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.selectTab setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([self.selectstr isEqualToString:@"菜品分类"]) {
        [self setCustomerTitle:@"菜品分类"];
        
    }else if ([self.selectstr isEqualToString:@"菜品状态"]) {
    
        self.selectArr = [NSMutableArray arrayWithObjects:@"上架",@"下架", nil];
        
        [self setCustomerTitle:@"选择状态"];

    }else if ([self.selectstr isEqualToString:@"菜品修改"]) {
        [self setCustomerTitle:@"选择分类"];
        
    }else if ([self.selectstr isEqualToString:@"下架"]) {
        
        [self setCustomerTitle:@"选择状态"];

    }else if ([self.selectstr isEqualToString:@"客桌分区"]) {
        
        [self setCustomerTitle:@"客桌分区"];
    }else if ([self.selectstr isEqualToString:@"选择月份"]) {
        
        [self setCustomerTitle:@"选择月份"];
    }else if ([self.selectstr isEqualToString:@"选择店铺"]) {
        
        [self setCustomerTitle:@"选择店铺"];
    }
    
    [self.view addSubview:self.bootbtn];
    self.view.backgroundColor = kCbgColor;
    
    [self.view addSubview:self.selectTab];
    
    // Do any additional setup after loading the view.
}
//添加缺失的像素
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(UITableView *)selectTab {

    if (!_selectTab) {
        _selectTab = [[UITableView alloc]initWithFrame:CGRectMake(15*newKwith, 5*newKhight, kWidth-30*newKwith,kHeight-kNavBarHAndStaBarH-54*newKhight) style:(UITableViewStylePlain)];
        
        _selectTab.delegate = self;
        _selectTab.dataSource = self;
        [_selectTab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"selectcell"];
        _selectTab.backgroundColor  =kCbgColor;
        _selectTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _selectTab;
}

//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.selectArr.count;
}
//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectcell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"selectcell"];
    }
    
    NSInteger row = [indexPath row];
    NSInteger oldRow = [_lastPath row];
    
    if (row == oldRow && _lastPath!=nil) {
        //这个是系统中对勾的那种选择框
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor = kRedColor;
        
    }else{
        
        cell.textLabel.textColor = rgba(85, 85, 85, 1);
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    UIView *linVC = [[UIView alloc]initWithFrame:CGRectMake(0, 43*newKhight, kWidth, 1)];
    linVC.backgroundColor = kCbgColor;
    [cell addSubview:linVC];
    
    cell.textLabel.font = kFont(15);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([self.selectstr isEqualToString:@"菜品分类"]) {
        StyleCaiPinModel *model = self.selectArr[indexPath.row];
        cell.textLabel.text = model.name;

    }else if ([self.selectstr isEqualToString:@"菜品状态"]) {
        cell.textLabel.text = self.selectArr[indexPath.row];
        
    }else if ([self.selectstr isEqualToString:@"菜品修改"]) {
        
        StyleCaiPinModel *model = self.selectArr[indexPath.row];
        cell.textLabel.text = model.name;
        
    }else if ([self.selectstr isEqualToString:@"下架"]) {
        
        
    }else if ([self.selectstr isEqualToString:@"客桌分区"]) {
        
        kezhuofenquModel *moel = self.selectArr[indexPath.row];
        
        cell.textLabel.text = moel.name;

    }else if ([self.selectstr isEqualToString:@"选择月份"]) {
        
    }else if ([self.selectstr isEqualToString:@"选择店铺"]) {
        dianpuModel *model = self.selectArr[indexPath.row];
        cell.textLabel.text = model.name;
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    _tabselectindex = indexPath;
    
    NSInteger newRow = [indexPath row];
    
    NSInteger oldRow = (self.lastPath !=nil)?[self .lastPath row]:-1;
    
    if (newRow != oldRow) {

        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        newCell.textLabel.textColor =kRedColor;

        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:_lastPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        oldCell.textLabel.textColor = rgba(85, 85, 85, 1);
        self.lastPath = indexPath;
    }

    if ([self.selectstr isEqualToString:@"选择店铺"]) {
        dianpuModel *model = _selectArr[indexPath.row];
        [UserDefaults setObjectleForStr:model.sid key:ksid];
    }
    
    DLog(@"第 %ld 行",indexPath.row);
    
}


-(RedBtn *)bootbtn {

    if (!_bootbtn) {
        _bootbtn = [[RedBtn alloc]initWithFrame:CGRectMake(0, kHeight-kNavBarHAndStaBarH-44*newKhight, kWidth, 44*newKhight) text:@"确定"];
        [_bootbtn addTarget:self action:@selector(bootbtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _bootbtn;
}

-(void)bootbtnClick:(UIButton *)btn {
    
    DLog(@"你点了btn");
    
    if ([self.selectstr isEqualToString:@"菜品分类"]) {
        
        if (self.tabselectindex == nil) {
            [WSProgressHUD showImage:nil status:@"请选择菜品分类"];
            return;
        }
        
        StyleCaiPinModel *model = self.selectArr[self.tabselectindex.row];
        
        if (_delegate && [_delegate respondsToSelector:@selector(onpressstylecaipin:)]) {
            
            [_delegate onpressstylecaipin:model];
            
        }
        
    }else if ([self.selectstr isEqualToString:@"菜品状态"]) {
        if (self.tabselectindex == nil) {
            [WSProgressHUD showImage:nil status:@"请选择菜品状态"];
            return;
        }
        
        NSString *str = self.selectArr[_tabselectindex.row];
        if (_delegate && [_delegate respondsToSelector:@selector(onpressAddCaipinStyle:)]) {
            
            [_delegate onpressAddCaipinStyle:str];
            
        }
        
    }else if ([self.selectstr isEqualToString:@"菜品修改"]) {
        
        if (self.tabselectindex == nil) {
            [WSProgressHUD showImage:nil status:@"请选择菜品分类"];
            return;
        }
        
        StyleCaiPinModel *model = self.selectArr[self.tabselectindex.row];
        
        if (_delegate && [_delegate respondsToSelector:@selector(onpressstylecaipin:)]) {
            
            [_delegate onpressstylecaipin:model];
            
        }
        
        
    }else if ([self.selectstr isEqualToString:@"下架"]) {
        
        
    }else if ([self.selectstr isEqualToString:@"客桌分区"]) {
        
        if (self.tabselectindex == nil) {
            [WSProgressHUD showImage:nil status:@"请选择分区"];
            return;
        }
        kezhuofenquModel *model = self.selectArr[self.tabselectindex.row];
        
        if (_delegate && [_delegate respondsToSelector:@selector(onpressaddKezhuo:)]) {
            
            [_delegate onpressaddKezhuo:model];
            
        }
        
    }else if ([self.selectstr isEqualToString:@"选择月份"]) {
        
        
    }else if ([self.selectstr isEqualToString:@"选择店铺"]) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(onpressSelectDianpu)]) {
            
            [_delegate onpressSelectDianpu];
            
        }
        //从首页进入 //赋值
        
        dianpuModel *model = self.selectArr[_tabselectindex.row];
        
        [UserDefaults setObjectleForStr:model.name key:kdianpuName];
        [UserDefaults setObjectleForStr:model.sid key:ksid];
        [UserDefaults setObjectleForStr:model.address key:kadress];

        
        //防止切换店铺,点餐和收银选择默认会蹦;
        [PronetwayYunFoodHandle shareHandle].tableindex = nil;
        [PronetwayYunFoodHandle shareHandle].Incometableindex = nil;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
