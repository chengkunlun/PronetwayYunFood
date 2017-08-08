//
//  HuiYuan_saixuanViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/19.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "HuiYuan_saixuanViewController.h"
#import "ShaixuanView.h"
@interface HuiYuan_saixuanViewController (){
    ShaixuanView * MyTable;
    NSMutableArray * dataArr;
}

@property (strong, nonatomic) UIButton *rightBtn;
@end

@implementation HuiYuan_saixuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"筛选"];
    
    dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    dataArr = [NSMutableArray arrayWithObjects:@"当前在店",@"常客",@"会员",@"重要客户", nil];
    MyTable = [ShaixuanView ShareTableWithFrame:kBounds];
    MyTable.dataArr = dataArr;
    //选中内容
    MyTable.block = ^(NSString *chooseContent,NSMutableArray *chooseArr){
        NSLog(@"数据：%@ ; %@",chooseContent,chooseArr);
    };
    [self.view addSubview:MyTable];
    
    [self addSaixuanRightBtn];
    
    [kNotificationCenter addObserver:self selector:@selector(selectAll) name:@"selectAll" object:nil];
    // Do any additional setup after loading the view.
}

-(void)selectAll {

    [_rightBtn setTitle:@"全选" forState:(UIControlStateNormal)];
    _rightBtn.selected = NO;

}

//右按钮
-(void)addSaixuanRightBtn {

    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem  = btn;
    
    
}

-(UIButton *)rightBtn {

    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_rightBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        _rightBtn.frame = CGRectMake(0, 0, 50*newKwith, 44*newKhight);
        [_rightBtn setTitle:@"全选" forState:(UIControlStateNormal)];
        _rightBtn.titleLabel.font = kFont(16);
        [_rightBtn addTarget:self action:@selector(RightBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _rightBtn;
}

-(void)RightBtnClick:(UIButton *)btn {
    MyTable.ifAllSelecteSwitch = YES;
    btn.selected = !btn.selected;
    
    if (btn.selected == YES) {
        DLog(@"全选");
       
            
        [_rightBtn setTitle:@"取消" forState:(UIControlStateSelected)];
        MyTable.ifAllSelected = YES;
        [MyTable.choosedArr removeAllObjects];
        [MyTable.choosedArr addObjectsFromArray:MyTable.dataArr];
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            
            [_rightBtn setTitle:@"全选" forState:(UIControlStateNormal)];
        }];
        MyTable.ifAllSelected = NO;
        [MyTable.choosedArr removeAllObjects];

        DLog(@"取消");
    }
    
    [MyTable.MyTable reloadData];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
