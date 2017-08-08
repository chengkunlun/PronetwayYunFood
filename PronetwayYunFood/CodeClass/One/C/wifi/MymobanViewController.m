//
//  MymobanViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/23.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "MymobanViewController.h"
#import "WiFiTableViewCell.h"
@interface MymobanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *mobanTab;
@end

@implementation MymobanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setCustomerTitle:@"我的模板"];
    
    //我的模板
    [self.view addSubview:self.mobanTab];
}

-(UITableView *)mobanTab {
    
    if (!_mobanTab) {
        _mobanTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kNavBarHAndStaBarH) style:(UITableViewStylePlain)];
        _mobanTab.delegate = self;
        _mobanTab.dataSource = self;
        [_mobanTab registerClass:[WiFiTableViewCell class] forCellReuseIdentifier:@"mywificell"];
        _mobanTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _mobanTab;
}
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
    
    WiFiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mywificell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[WiFiTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"mywificell"];
    }
    cell.selectStr  = @"我的模板";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 233*newKhight;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
