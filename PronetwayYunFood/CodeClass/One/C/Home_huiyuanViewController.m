//
//  Home_huiyuanViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/16.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_huiyuanViewController.h"
#import "Home_huiyuanView.h"
#import "HuiYuan_saixuanViewController.h"
#import "Hui_xiaoxiViewController.h"
#import "ChongzhiViewController.h"

@interface Home_huiyuanViewController ()<HomehuiyuanDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) Home_huiyuanView *HYvc;
@property (strong, nonatomic) UIButton *rightBtn;
//tableView
@property (nonatomic,strong) UITableView *skTableView;
@property (nonatomic) BOOL backstion;

//搜索历史view
@property (strong, nonatomic) UIView *SearchheaderView;
@property (strong, nonatomic)UILabel *hostNameLab;
@property (strong, nonatomic) NSMutableArray *searchBarArr;

@end

@implementation Home_huiyuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"我的会员"];
    
    _HYvc = [[Home_huiyuanView alloc]initWithFrame:kBounds];
    [_HYvc.ChongBtn addTarget:self action:@selector(chongBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_HYvc.selectbtn addTarget:self action:@selector(selectbtn:) forControlEvents:(UIControlEventTouchUpInside)];
    _HYvc.delegate = self;
    _HYvc.searchController.searchBar.delegate = self;
    self.definesPresentationContext=YES;

    [self.view addSubview:_HYvc];
    
    //多选 和全选
    
    //选中内容
    _HYvc.block = ^(NSString *chooseContent,NSMutableArray *chooseArr){
        NSLog(@"数据：%@ ; %@",chooseContent,chooseArr);
    };
    
    [kNotificationCenter addObserver:self selector:@selector(changeRightBtn) name:@"kchangeright" object:nil];
    
}

//发送消息的代理事件
-(void)onpress {

    if (![ValidateUtil checkuserType]) {
        
        [WSProgressHUD showImage:nil status:@"暂无权限!"];
        return;
    }
    [self.navigationController pushViewController:[Hui_xiaoxiViewController new] animated:YES];
}
//创建右按钮的代理事件
-(void)showRightBtn {
    if (_rightBtn.hidden == YES) {
        _rightBtn.hidden = NO;
    }else {
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
        self.navigationItem.rightBarButtonItem = right;
    }
}


-(UIButton *)rightBtn {
    if (!_rightBtn) {
        
    _rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _rightBtn.frame = CGRectMake(0, 0, 60*newKwith, 44*newKhight);
    _rightBtn.titleLabel.font = kBodlFont(16);
    [_rightBtn setTitle:@"全选" forState:(UIControlStateNormal)];
    [_rightBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [_rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:(UIControlEventTouchUpInside)];
         }
    return _rightBtn;
}

#pragma mark --- tableview delegate ---

//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  3;
    
}

//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HuiyuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HuiyuanseatchCell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[HuiyuanTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"HuiyuanseatchCell"];
    }
    
    
    return cell;
    
}

//筛选
-(void)selectbtn:(UIButton *)btn {

    [self.navigationController pushViewController:[HuiYuan_saixuanViewController new] animated:YES];
}

//充值营销
-(void)chongBtnClick:(UIButton *)btn {

    if (![ValidateUtil checkuserType]) {
        
        [WSProgressHUD showImage:nil status:@"暂无权限!"];
        return;
    }
    [self.navigationController pushViewController:[ChongzhiViewController new] animated:YES];
    
}
//右按钮的点击事件
-(void)rightClick:(UIButton *)btn {

    btn.selected = !btn.selected;
    btn.selected = !_HYvc.ifAllSelected;

   // _HYvc.ifAllSelecteSwitch = !_HYvc.ifAllSelecteSwitch;
   // _HYvc.ifAllSelected = !_HYvc.ifAllSelected;
    if (btn.selected == YES) {
        DLog(@"全选");
        _HYvc.ifAllSelected = YES;
        _HYvc.ifAllSelecteSwitch = YES;
        [_HYvc.choosedArr removeAllObjects];
        [_HYvc.choosedArr addObjectsFromArray:_HYvc.dataArr];
        DLog(@"%@",_HYvc.choosedArr);
        [_rightBtn setTitle:@"取消" forState:(UIControlStateSelected)];

    }else {
        _HYvc.ifAllSelected = NO;
        _HYvc.ifAllSelecteSwitch = NO;

        [_rightBtn setTitle:@"全选" forState:(UIControlStateNormal)];
        [_HYvc.choosedArr removeAllObjects];

        DLog(@"取消");
    }
    
    [_HYvc.home_huiyuanTab reloadData];
}
-(void)changeRightBtn {

    [_rightBtn setTitle:@"全选" forState:(UIControlStateNormal)];
    _rightBtn.selected = NO;
}
//隐藏右按钮
-(void)hideRightBtn {

    _rightBtn.hidden = YES;
}

-(void)dealloc {

    DLog(@"😁");
}
#pragma  mark --- seachbardelegate ----
//开始编辑
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    //修改取消按钮的颜色
    [searchBar setShowsCancelButton:YES animated:YES];
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
    [cancelBtn setTitleColor:ksearchBarCancelTextColor forState:(UIControlStateNormal)];
    cancelBtn.titleLabel.font = kFont(ksearchBarCancelTextFont);
    
    [_HYvc.searchController.view addSubview:self.skTableView];
    if (self.searchBarArr.count>0) {
        
        self.skTableView.tableHeaderView = self.SearchheaderView;
        _hostNameLab.text = @"历史结果";
    }
}
//点击搜索是 触发事件
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _hostNameLab.text = @"🔍结果";
    if (self.searchBarArr.count==0) {
        
        [WSProgressHUD showImage:nil status:@"无匹配项"];
    }
    [searchBar resignFirstResponder]; //searchBar失去焦点
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
    cancelBtn.enabled = YES; //把enabled设置为yes
    
}
//取消按钮的点击事件
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self Tabviewdissmiss];
}
////模糊查询
//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    [self.searchBarArr removeAllObjects];
//    for (int i = 0; i < self.FoodArr.count; i++) {
//        Home_CaiPinModel *model = self.FoodArr[i];
//        NSString *string =model.name ;
//        if (string.length >= searchText.length) {
//            
//            if([string rangeOfString:searchText].location !=NSNotFound)
//            {
//                [_searchBarArr addObject:model];
//            }
//        }
//    }
//    _hostNameLab.text = @"🔍结果";
//    // [searchBar resignFirstResponder];
//    [self.skTableView reloadData];
//}
-(UITableView*)skTableView {
    
    if (!_skTableView) {
        _skTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHAndStaBarH, kWidth, kHeight-kNavBarHAndStaBarH) style:(UITableViewStylePlain)];
        
        _skTableView.delegate = self;
        _skTableView.dataSource = self;
        _skTableView.rowHeight = 226*newKhight;
        _skTableView.showsVerticalScrollIndicator = NO;
        [_skTableView registerClass:[HuiyuanTableViewCell class] forCellReuseIdentifier:@"HuiyuanseatchCell"];
        _skTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _backstion = NO;
    }
    return _skTableView;
}

-(void)Tabviewdissmiss {
    
    [_HYvc.searchController.searchBar resignFirstResponder];
    _HYvc.searchController.searchBar.showsCancelButton = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _skTableView.alpha = 0;
        
    } completion:^(BOOL finished) {
        _backstion = YES;
        _skTableView = nil;
        [_skTableView removeFromSuperview];
    }];
}
-(UIView *)SearchheaderView {
    
    if (!_SearchheaderView) {
        
        _SearchheaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        _hostNameLab  = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kWidth, 44*newKhight)];
        _hostNameLab.textColor = rgba(85, 85, 85, 1);
        _hostNameLab.font = kFont(13);
        _hostNameLab.text = @"历史结果";
        [_SearchheaderView addSubview:_hostNameLab];
        
        UIView *lin =[[UIView alloc]initWithFrame:CGRectMake(10, 43*newKhight, kWidth, 1)];
        lin.backgroundColor = kCbgColor;
        [_SearchheaderView addSubview:lin];
        
    }
    return _SearchheaderView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
