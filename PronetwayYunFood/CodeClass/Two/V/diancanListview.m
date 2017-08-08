//
//  diancanListview.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/31.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "diancanListview.h"

@implementation diancanListview

- (instancetype)initWithFrame:(CGRect)frame height:(CGFloat)height;
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView:height];
    }
    return self;
}

-(void)addView:(CGFloat)hegiht{
    
    _bg = [[UIView alloc]initWithFrame:self.frame];
    _bg.alpha = 0.6;
    _bg.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapccick:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_bg addGestureRecognizer:tap];
    
    [self addSubview:_bg];
    
    _tab = [[UITableView alloc]initWithFrame:CGRectMake(0, self.height, kWidth, hegiht)];
    _tab.backgroundColor = kWhiteColor;
    _tab.delegate = self;
    _tab.dataSource = self;
    _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tab registerClass:[ListTableViewCell class] forCellReuseIdentifier:@"listcell"];
    [self addSubview:_tab];
    
    _startH = hegiht;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _tab.frame = CGRectMake(0, self.height-hegiht, kWidth, hegiht);
    }];
    
   // [Animations moveUp:_tab andAnimationDuration:0.3 andWait:NO andLength:hegiht];
    
    
}
-(void)cleck {
    
    [self dismiss];
    
    if (self.clearBlock) {
        self.clearBlock();
    }
}

-(void)tapccick:(UITapGestureRecognizer *)tap {

    [UIView animateWithDuration:0.5 animations:^{
        
        _tab.frame = CGRectMake(0, kHeight, kWidth, 0.1);
        _bg.alpha = 0;
        self.alpha  =0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    
    }];
    
    if (self.clickbacgroundBlock) {
        self.clickbacgroundBlock();
    }
}

//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.alertListArr.count;
    
}
//展示cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listcell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[ListTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"listcell"];
    }
    
    Home_CaiPinModel *model = self.alertListArr[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //按钮添加点击事件
    [cell.addBtn addTarget:self action:@selector(addbtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.reduceBtn addTarget:self action:@selector(reducebtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 44*newKhight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 40*newKhight;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return self.headerView;
}

-(UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 40*newKhight)];
        _headerView.backgroundColor = kCbgColor;
        
        UIView *linB = [[UIView alloc]initWithFrame:CGRectMake(5*newKwith, 5*newKhight, 5*newKwith, 30*newKhight)];
        linB.backgroundColor = kRedColor;
        [_headerView addSubview:linB];
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(linB.endX+5, 0, kWidth, 40*newKhight)];
        lb.text = @"购物车";
        lb.textColor = RGB(85, 85, 85);
        lb.font = kFont(15);
        [_headerView addSubview:lb];
        
        _clearBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _clearBtn.frame = CGRectMake(kWidth-70*newKwith, 0, 50*newKhight, 40*newKhight);
        [_clearBtn setTitle:@"清空" forState:(UIControlStateNormal)];
        [_clearBtn setTitleColor:RGB(85, 85, 85) forState:(UIControlStateNormal)];
        _clearBtn.titleLabel.font = kFont(15);
        [_clearBtn addTarget:self action:@selector(cleck) forControlEvents:(UIControlEventTouchUpInside)];
        [_headerView addSubview:_clearBtn];
    }
    return _headerView;
    
}

//右边添加事件事件
- (void)addbtnClick:(UIButton *)sender event:(id)event
{
    
    if (self.addBlock) {
        self.addBlock();
    }
    
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tab];
    NSIndexPath *indexPath= [_tab indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil)
    {
        Home_CaiPinModel *model = self.alertListArr[indexPath.row];
        model.selectnumber ++;
        [self.alertListArr replaceObjectAtIndex:indexPath.row withObject:model];

        if (_delegate && [_delegate respondsToSelector:@selector(onpressaddBtn:selectArr:)]) {
            
            [_delegate onpressaddBtn:model selectArr:self.alertListArr];
        }
        
        [self.tab reloadData];
    }
}

//右边减少事件事件
- (void)reducebtnClick:(UIButton *)sender event:(id)event
{
    if (self.reduceBlock) {
        self.reduceBlock();
    }
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tab];
    NSIndexPath *indexPath= [_tab indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil)
    {
        Home_CaiPinModel *model = self.alertListArr[indexPath.row];
        
       // Home_CaiPinModel *m = self.alertListArr[indexPath.row];
        
       // DLog(@"右边 -- %ld",m.selectnumber);
        DLog(@"弹出 -- %ld",model.selectnumber);
        
        if (model.selectnumber == 1) {
            model.selectnumber--;

            [self.alertListArr removeObjectAtIndex:indexPath.row];
            
            if (self.alertListArr.count<7) {
                
                CGFloat h = self.tab.height;
                [UIView animateWithDuration:0.5 animations:^{
                    
                    self.tab.frame = CGRectMake(0, self.tab.origin.y+44*newKhight, kWidth, h-44*newKhight);
                }];
            }
            [self.tab  reloadData];
        }else {
            model.selectnumber --;
            [self.alertListArr replaceObjectAtIndex:indexPath.row withObject:model];
            [self.tab reloadData];
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(onpressreduceBtn:selectArr:)]) {
            
            [_delegate onpressreduceBtn:model selectArr:self.alertListArr];
        }
        
        if (self.self.alertListArr.count == 0) {
            
            [self dismiss];
            
        }
    }
}

-(void)dismiss {

    
    [UIView animateWithDuration:0.5 animations:^{
        
        _tab.frame = CGRectMake(0, kHeight, kWidth, 0.1);
        _bg.alpha = 0;
        self.alpha  =0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];

}

@end
