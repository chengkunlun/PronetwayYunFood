//
//  wifiMobanViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/22.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "wifiMobanViewController.h"
#import "WiFiTableViewCell.h"
@interface wifiMobanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UITableView *mobanTab;
@property (strong, nonatomic) UIImageView *sessionImg;
@property (strong, nonatomic) UILabel *sessionLab;
@end

@implementation wifiMobanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mobanTab];
    
    // Do any additional setup after loading the view.
}

-(UITableView *)mobanTab {

    if (!_mobanTab) {
        _mobanTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kNavBarHAndStaBarH-44*newKhight) style:(UITableViewStylePlain)];
        
        _mobanTab.delegate = self;
        _mobanTab.dataSource = self;
        [_mobanTab registerClass:[WiFiTableViewCell class] forCellReuseIdentifier:@"wificell"];
        _mobanTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _mobanTab;
}
//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        
        return 1;
    }
    return  3;
    
}
//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WiFiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wificell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[WiFiTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"wificell"];
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 233*newKhight;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 44*newKhight;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
    headerView.backgroundColor = kWhiteColor;
    
    _sessionImg = [[UIImageView alloc]initWithFrame:CGRectMake(-10*newKwith, 0, kWidth+20*newKwith, 49*newKhight)];
    _sessionImg.image = kimage(@"Yun_huiyuan_sectionimg");
    _sessionLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
    _sessionLab.textAlignment = NSTextAlignmentCenter;
    _sessionLab.textColor = RGB(51, 51, 51);
    _sessionLab.font = kFont(14);
    [_sessionImg addSubview:_sessionLab];
    if (section == 0) {
        self.sessionLab.text = @"我的当前模板";
    }else {
        self.sessionLab.text = @"更多模板";
    }
    [headerView addSubview:_sessionImg];
    return headerView;
}

-(UIImageView *)sessionImg {

    if (!_sessionImg) {
           }
    return _sessionImg;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
