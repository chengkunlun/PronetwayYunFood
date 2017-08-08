//
//  MyconmeeViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/7.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "MyconmeeViewController.h"
#import "my_listModel.h"
#import "My_TableViewCell.h"
#import "my_retchModel.h"
#import "IncomeListViewController.h"
@interface MyconmeeViewController ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
{

    RefreshManager *mananer;

}
@property (strong, nonatomic) UITableView *My_tab;
@property (strong, nonatomic) NSMutableArray *listArr;
@property (strong, nonatomic) NSString *refreshType;
@property (assign) int  refresh;
@property (strong, nonatomic) NSArray *arr;

@end

@implementation MyconmeeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kWhiteColor;
    
    mananer = [RefreshManager new];
    
    if ([self.selectStr isEqualToString:@"充值"]) {
        [self setCustomerTitle:@"充值"];
        [self reloadJosnForreatch];
    }else if ([self.selectStr isEqualToString:@"提现"]) {
        [self setCustomerTitle:@"提现"];
    }else if ([self.selectStr isEqualToString:@"营业额"]) {
        
        [self setCustomerTitle:@"营业额"];
        [self reloadJosnForListType:@"all" start:@"0" limit:@"10"];
    }else if ([self.selectStr isEqualToString:@"现金支付"]) {
        
        [self setCustomerTitle:@"现金支付" ];
        [self reloadJosnForListType:@"cash" start:@"0" limit:@"10"];
    }else if ([self.selectStr isEqualToString:@"线上支付"]) {
        [self setCustomerTitle:@"线上支付"];
        [self reloadJosnForListType:@"online" start:@"0" limit:@"10"];

    }
    
    //添加tabview
    [self.view addSubview:self.My_tab];
    
    //添加刷新
    [mananer addrefreshtab:self.My_tab];
    mananer.delegate = self;
    
    // Do any additional setup after loading the view.
}



-(NSMutableArray *)listArr {

    if (!_listArr) {
        _listArr = [[NSMutableArray alloc]init];
    }
    return _listArr;
}

-(UITableView *)My_tab {
    
    if (!_My_tab) {
        _My_tab = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kWidth, kHeight-kNavBarHAndStaBarH)];
        _My_tab.delegate = self;
        _My_tab.dataSource = self;
        [_My_tab registerClass:[My_TableViewCell class] forCellReuseIdentifier:@"my_tabcell"];
        _My_tab.rowHeight = 60*newKhight;
        _My_tab.backgroundColor = kClearColor;
        _My_tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _My_tab;
}
//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listArr.count;
}
//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    My_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my_tabcell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[My_TableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"my_tabcell"];
    }
    if ([self.selectStr isEqualToString:@"充值"]) {

        
    }else if ([self.selectStr isEqualToString:@"提现"]) {

        
    }else if ([self.selectStr isEqualToString:@"营业额"]) {
        
        cell.onlinModel = self.listArr[indexPath.row];


    }else if ([self.selectStr isEqualToString:@"现金支付"]) {
        
        cell.cashModel = self.listArr[indexPath.row];


    }else if ([self.selectStr isEqualToString:@"线上支付"]) {

        cell.onlinModel = self.listArr[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//tabview的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    IncomeListViewController *incomelistVC = [IncomeListViewController new];
    incomelistVC.selectStr = @"mycount";
    if (self.listArr.count>indexPath.row) {
        
        my_listModel *model = self.listArr[indexPath.row];
        incomelistVC.order = model.orderno;
        incomelistVC.allMoney = model.money;
    }
    if ([self.selectStr isEqualToString:@"充值"]) {
        
    }else if ([self.selectStr isEqualToString:@"提现"]) {
        
    }else if ([self.selectStr isEqualToString:@"营业额"]) {
        [self.navigationController pushViewController:incomelistVC animated:YES];

    }else if ([self.selectStr isEqualToString:@"现金支付"]) {
        [self.navigationController pushViewController:incomelistVC animated:YES];

    }else if ([self.selectStr isEqualToString:@"线上支付"]) {
        [self.navigationController pushViewController:incomelistVC animated:YES];

    }
    
}

//现金 线上 所有营业额
-(void)reloadJosnForListType:(NSString *)type start:(NSString *)start limit:(NSString *)limit {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@",kIpandPort,kGetUserList,kGetUserList5, [UserDefaults objectForKeyStr:ksid],kGetUserList1,self.startTime,kGetUserList2,self.endTime,kGetUserList4 ,type,kGetUserList7,start,kGetUserList8,limit];
    DLog(@"我的账户获取列表%@",urlStr);
    
    [CKLRequestManger GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if (dic[@"result"]) {
            
            _arr = dic[@"eimdata"];
            
            if (kStringIsEmpty(_refreshType)) {
                
                if (_arr.count == 0) {
                    
                    [WSProgressHUD showImage:nil status:@"暂无数据"];
                    return;
                }
            }
            if ([self.refreshType isEqualToString:@"top"]) {
                
                [self.listArr removeAllObjects];
            }
            [_arr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                my_listModel *model = [my_listModel setUpModelWithDictionary:dict];
                [self.listArr addObject:model];
            }];
            
            //倒序排列
            [[self.listArr reverseObjectEnumerator] allObjects];
            
        }
        
        if ([_refreshType isEqualToString:@"top"]) {
            [self delayreload:1.5];
            
        }else if ([_refreshType isEqualToString:@"bottom"]) {
            
            [self delayreload:1.5];
            
        }else {
            [self.My_tab reloadData];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器出错"];
        DLog(@"%@",error);
    }];
}

-(void)delayreload:(int)time {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if ([self.refreshType isEqualToString:@"top"]) {
            [mananer stoprefreshHeader];
            if (_arr.count == 0) {
                
                [WSProgressHUD showImage:nil status:@"没有数据了"];
                return;
            }
            [self.My_tab reloadData];

            
        }else if ([self.refreshType isEqualToString:@"bottom"]) {
        
            [mananer stoprefreshFoot];
            if (_arr.count == 0) {
                
                [WSProgressHUD showImage:nil status:@"没有数据了"];
                return;
            }
            [self.My_tab reloadData];
        }
    });
}


//充值
-(void)reloadJosnForreatch {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",kIpandPort,kgetUserPayinfo, [UserDefaults objectForKeyStr:kpid]];
    DLog(@"充值 %@",urlStr);
    
    [CKLRequestManger GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if (dic[@"result"]) {
            
            NSArray *arr = dic[@"eimdata"];
            
            if (arr.count == 0) {
                [WSProgressHUD showImage:nil status:@"暂无数据"];
                return ;
            }
            
            [arr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                my_retchModel *model = [my_retchModel setUpModelWithDictionary:dict];
                [self.listArr addObject:model];
            }];
        }
        //倒序排列
         [[self.listArr reverseObjectEnumerator] allObjects];
        
        [self.My_tab reloadData];
        
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器出错"];
        DLog(@"%@",error);
    }];
}

//头部刷新点击事件
-(void)headerRefreshClick {

    _refreshType = @"top";
    
    _refresh = 0;
    
    if ([self.selectStr isEqualToString:@"充值"]) {
    }else if ([self.selectStr isEqualToString:@"提现"]) {
    }else if ([self.selectStr isEqualToString:@"营业额"]) {
        
    [self reloadJosnForListType:@"all" start:[NSString stringWithFormat:@"%d",_refresh] limit:@"10"];
    }else if ([self.selectStr isEqualToString:@"现金支付"]) {
        [self setCustomerTitle:@"现金支付" ];
        [self reloadJosnForListType:@"cash" start:[NSString stringWithFormat:@"%d",_refresh] limit:@"10"];
    }else if ([self.selectStr isEqualToString:@"线上支付"]) {
        [self setCustomerTitle:@"线上支付"];
        [self reloadJosnForListType:@"online" start:[NSString stringWithFormat:@"%d",_refresh] limit:@"10"];
    }
}

//底部刷新点击事件
-(void)footRefreshClick {

    _refreshType = @"bottom";
    
    _refresh = 10*(++_refresh);
    
    if ([self.selectStr isEqualToString:@"充值"]) {
    }else if ([self.selectStr isEqualToString:@"提现"]) {
    }else if ([self.selectStr isEqualToString:@"营业额"]) {
        
        [self reloadJosnForListType:@"all" start:[NSString stringWithFormat:@"%d",_refresh] limit:@"10"];
    }else if ([self.selectStr isEqualToString:@"现金支付"]) {
        [self setCustomerTitle:@"现金支付" ];
        [self reloadJosnForListType:@"cash" start:[NSString stringWithFormat:@"%d",_refresh] limit:@"10"];
    }else if ([self.selectStr isEqualToString:@"线上支付"]) {
        [self setCustomerTitle:@"线上支付"];
        [self reloadJosnForListType:@"online" start:[NSString stringWithFormat:@"%d",_refresh] limit:@"10"];
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
