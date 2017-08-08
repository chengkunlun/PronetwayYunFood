//
//  Yun_order_XDView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/15.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Yun_order_XDView.h"
#import "Yun_order_XDTableViewCell.h"
@implementation Yun_order_XDView

- (instancetype)initWithFrame:(CGRect)frame sid:(NSString *)sid
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
        [self reloadJosnForgetAllListcaipin:sid];
    }
    return self;
}

-(NSMutableArray *)xdArr {

    if (!_xdArr) {
        _xdArr = [NSMutableArray arrayWithObjects:@"2",@"1",@"3",@"2", nil];
    }
    return _xdArr;
}

-(NSMutableArray *)FoodArr {
    
    if (!_FoodArr) {
        _FoodArr = [NSMutableArray array];
    }
    return _FoodArr;
}



-(void)addView{
    self.backgroundColor = kWhiteColor;
    [self addSubview:self.Yun_xdTableView];
    [self addSubview:self.XDBtn];
}

-(UIView *)BottomView {

    if (!_BottomView) {
    _BottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
        _lb4 = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-140*newKwith, 0, 120*newKwith, 44*newKhight)];
        _lb4.textColor = RGB(225, 102, 125);
        _lb4.font = kFont(14);
        _lb4.text = [NSString stringWithFormat:@"应支付: %@",self.allPrice];
        [_BottomView addSubview:_lb4];
        
//        _lb5 = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-140*newKwith, _lb4.endY + 5*newKhight, 120*newKwith, 20*newKhight)];
//        _lb5.textColor = RGB(172, 172, 172);
//        _lb5.font = kFont(12);
//        _lb5.text = @"总消费 : 9999 ¥";
//        [_BottomView addSubview:_lb5];
//        
//        _lb6 = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-140*newKwith,_lb5.endY+5*newKhight, 120*newKwith, 20*newKhight)];
//        _lb6.textColor = RGB(172, 172, 172);
//        _lb6.font = kFont(12);
//        _lb6.text = @"优惠券 : 999 ¥";
//        [_BottomView addSubview:_lb6];
       
        UIImageView *linVC = [[UIImageView alloc]initWithFrame:CGRectMake(0, _BottomView.height-1, kWidth, 1)];
        linVC.backgroundColor = RGB(247, 247, 247);
        [_BottomView addSubview:linVC];
        
//        _lb4.textAlignment = NSTextAlignmentRight;
//        _lb5.textAlignment = NSTextAlignmentRight;
//        _lb6.textAlignment = NSTextAlignmentRight;
//
        
    _BottomView.backgroundColor = kWhiteColor;
    }
    return _BottomView;
}


-(UITableView *)Yun_xdTableView {

    if (!_Yun_xdTableView) {
        _Yun_xdTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10*newKhight, kWidth, kHeight-44*newKhight-kNavBarHAndStaBarH)];
        _Yun_xdTableView.delegate = self;
        _Yun_xdTableView.dataSource = self;
        _Yun_xdTableView.rowHeight = 70*newKhight;
       // _Yun_xdTableView.backgroundColor = [UIColor cyanColor];
        [_Yun_xdTableView registerClass:[Yun_order_XDTableViewCell class] forCellReuseIdentifier:@"yunxdcell"];
        _Yun_xdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _Yun_xdTableView;
}
//下单按钮的单击事件
-(UIButton *)XDBtn {

    if (!_XDBtn) {
        _XDBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _XDBtn.frame = CGRectMake(0, kHeight-44*newKhight-kNavBarHAndStaBarH, kWidth, 44*newKhight);
        [_XDBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        _XDBtn.titleLabel.font = kBodlFont(16);
        [_XDBtn setTitle:@"下 单" forState:(UIControlStateNormal)];
        //[_XDBtn setImage:kimage(@"Yun_order_bottom") forState:(UIControlStateNormal)];
        [_XDBtn setBackgroundImage:kimage(@"Yun_order_bottom") forState:(UIControlStateNormal)];
        [_XDBtn addTarget:self action:@selector(xdBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _XDBtn;
}

//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.FoodArr.count;
}
//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Yun_order_XDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yunxdcell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[Yun_order_XDTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"yunxdcell"];
    }
    cell.jianBtn.tag = kYun_order_XD_jian +indexPath.row;
    [cell.jianBtn addTarget:self action:@selector(jianBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    cell.jiabtn.tag = kYun_order_XD_jia +indexPath.row;
    [cell.jiabtn addTarget:self action:@selector(jiaBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    //赋值
    cell.model = self.FoodArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 80*newKhight;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    return self.BottomView;
}
//减
-(void)jianBtnClick:(UIButton *)attentionBtn {

    NSInteger  index = attentionBtn.tag-kYun_order_XD_jian;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
    Yun_order_XDTableViewCell *cell = [self.Yun_xdTableView cellForRowAtIndexPath:indexPath];
    
    NSString *str = self.xdArr[attentionBtn.tag-kYun_order_XD_jian];
    NSInteger number = [str integerValue];
    
    if (number == 1) {
        
        TDAlertItem *item1 = [[TDAlertItem alloc] initWithTitle:@"取消"];
        TDAlertItem *item2 = [[TDAlertItem alloc] initWithTitle:@"确认"];
        item2.titleColor = [UIColor redColor];
        TDAlertView *alert = [[TDAlertView alloc] initWithTitle:@"温馨提示" message:@"好货不等人,确认要删除吗?" items:@[item1,item2] delegate:self];
        alert.hideWhenTouchBackground = NO;
        [alert show];
        alert.OKBlock = ^{
                    
            [self.xdArr removeObjectAtIndex:index];
            [self.Yun_xdTableView reloadData];
        };
        DLog(@"确认要删除吗");
        return;
    }
    cell.lb3.text = [NSString stringWithFormat:@"%ld",--number];
    
    cell.lb4.text = [NSString stringWithFormat:@"%ld ¥",188*number];
    
    [self.xdArr replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%ld",number]];
    
}

//加
-(void)jiaBtnClick:(UIButton *)btn {
    
    NSInteger  index = btn.tag-kYun_order_XD_jia;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
    Yun_order_XDTableViewCell *cell = [self.Yun_xdTableView cellForRowAtIndexPath:indexPath];
    
    NSString *str = self.xdArr[btn.tag-kYun_order_XD_jia];
    NSInteger number = [str integerValue];
    
    cell.lb3.text = [NSString stringWithFormat:@"%ld",++number];
    cell.lb4.text = [NSString stringWithFormat:@"%ld ¥",188*number];
    
     [self.xdArr replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%ld",number]];
    
}

#pragma 下单的点击事件
-(void)xdBtnClick:(UIButton *)btn {

    if (self.xdBlock) {
        self.xdBlock();
    }
}

//从c端获取数据
-(void)reloadJosnForgetAllListcaipin:(NSString *)sid {
    
    NSString *urlstr = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kgetAllLisstcai,[UserDefaults objectForKeyStr:ksid],kgetAllLisstcai1,sid];
    DLog(@"获取购物车菜品 -- %@",urlstr);
    
    [CKLRequestManger GET:urlstr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"] isEqualToString:@"0"]) {
            NSArray *arr = dic[@"eimdata"];
            [self.FoodArr removeAllObjects];
            for (NSDictionary *dict in arr) {
                
                XDModel *model = [XDModel setUpModelWithDictionary:dict];
                [self.FoodArr addObject:model];
            }
            [self.Yun_xdTableView reloadData];
            _lb4.text = [NSString stringWithFormat:@"应支付:¥ %@",[self allPrice:self.FoodArr]];
            
            if (_delegate && [_delegate respondsToSelector:@selector(TogetXDArr:)]) {
                
                [_delegate TogetXDArr:self.FoodArr];
            }
            
        }else {
            
            [WSProgressHUD showImage:nil status:dic[@"result"]];
        }
    } failure:^(NSError *error) {
        
        DLog(@"%@",error);
    }];
}
#pragma mark -- 计算钱
-(NSString *)allPrice:(NSMutableArray *)Arr {
        //计算钱
       float all = 0.00;
        for (XDModel *model in Arr) {
            
            all += [model.price integerValue]*[model.quantity integerValue];
        }
    all = all/100;
    NSString *alstr = [NSString stringWithFormat:@"%0.2f",all];
    return alstr;
}

@end
