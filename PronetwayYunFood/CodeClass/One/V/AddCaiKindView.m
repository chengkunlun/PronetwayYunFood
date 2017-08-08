//
//  AddCaiKindView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/17.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "AddCaiKindView.h"

@implementation AddCaiKindView

- (instancetype)initWithFrame:(CGRect)frame select:(NSString *)select
{
    self = [super initWithFrame:frame];
    if (self) {
        _select = select;
        [self addView:(NSString *)select];
    }
    return self;
}

-(keyboardView *)keyView {
    WeakType(self);
    _keyView = [[keyboardView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 44*newKhight)];
    _keyView.backgroundColor = kWhiteColor;
    _keyView.okclick = ^{
        
        [weakself endEditing:YES];
    };
    return _keyView;
}

-(void)addView:(NSString *)select{
    self.backgroundColor = kWhiteColor;
    //[self setupFoldingTableView];
    
    [self addBotBtn];
    [self addSubview:self.PhotoimgView];
    
    [self add:select];

    [kNotificationCenter addObserver:self selector:@selector(takeback) name:@"takeback" object:nil];
    
    [self addSubview:self.saveBtn];
    
}

-(void)addBotBtn {

    _btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _btn1.frame = CGRectMake(15*newKwith, 333*newKhight, kWidth-30*newKwith, 44*newKhight);
    _btn1.backgroundColor = RGB(242, 242, 242);
    [_btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_btn1];

    _lab1 = [[UILabel alloc]initWithFrame:CGRectMake(25*newKwith, 333*newKhight, kWidth-30*newKwith, 44*newKhight)];
    _lab1.textColor = RGB(85, 85, 85);
    _lab1.font = kFont(14);
    [self addSubview:_lab1];
    
    _btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _btn2.frame = CGRectMake(15*newKwith, _btn1.endY+10*newKhight, kWidth-30*newKwith, 44*newKhight);
    _btn2.backgroundColor = RGB(242, 242, 242);
    [_btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_btn2];
    
    _lab2 = [[UILabel alloc]initWithFrame:CGRectMake(25*newKwith, _btn1.endY+10*newKhight, kWidth-30*newKwith, 44*newKhight)];
    _lab2.textColor = RGB(85, 85, 85);
    _lab2.font = kFont(14);
    [self addSubview:_lab2];
    
    if ([self.select isEqualToString:@"菜品修改"]) {
        _lab2.text = @"下架";
        _lab1.text = @"热销菜品";
    }else {
        _lab2.text = @"菜品状态";
        _lab1.text = @"菜品分类";
    }
    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth-45*newKwith, _lab1.Y+18*newKhight, 14*newKwith, 8*newKhight)];
    arrow.image = kimage(@"Yun_home_addCai_jiantou");
    [self addSubview:arrow];
    
    UIImageView *arrow1 = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth-45*newKwith, _lab2.Y+18*newKhight, 14*newKwith, 8*newKhight)];
    arrow1.image = kimage(@"Yun_home_addCai_jiantou");
    [self addSubview:arrow1];
    
}

//第1个按钮
-(void)btn1Click:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(onpressBtn1)]) {
        [_delegate onpressBtn1];
    }
    [self takeback];
}
//第2个按钮
-(void)btn2Click:(UIButton *)btn {
    [self takeback];
    if (_delegate && [_delegate respondsToSelector:@selector(onpressBtn2)]) {
        
        [_delegate onpressBtn2];
    }
}
-(void)takeback {

    UITextField *CaiT = (UITextField *)[self viewWithTag:kYun_home_addCaiT];
    UITextField *CaiT1 = (UITextField *)[self viewWithTag:kYun_home_addCaiT+1];
    UITextField *Cai2 = (UITextField *)[self viewWithTag:kYun_home_addCaiT+2];

    [CaiT resignFirstResponder];
    [CaiT1 resignFirstResponder];
    [Cai2 resignFirstResponder];

    
}

-(UIButton *)saveBtn {
    
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _saveBtn.frame = CGRectMake(0, kHeight-44*newKhight-kNavBarHAndStaBarH, kWidth, 44*newKhight);
        [_saveBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        _saveBtn.titleLabel.font = kBodlFont(16);
        [_saveBtn setTitle:@"保 存" forState:(UIControlStateNormal)];
        //[_XDBtn setImage:kimage(@"Yun_order_bottom") forState:(UIControlStateNormal)];
        [_saveBtn setBackgroundImage:kimage(@"Yun_order_bottom") forState:(UIControlStateNormal)];
           }
    return _saveBtn;
}


-(void)add:(NSString *)select {

    if ([select isEqualToString:@"菜品修改"]) {
        
        _arr = @[@"大龙虾",@"188.00¥",@"188.00¥"];

    }else {
    
       _arr = @[@"菜品名称",@"菜品单价",@"会员价"];
 
    }
    
    for (int i = 0; i<3; i++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(15*newKwith, _PhotoimgView.endY+10*newKhight+i*(54*newKhight), _PhotoimgView.width, 44*newKhight)];
        view.backgroundColor = RGB(242, 242, 242);
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10*newKwith, 0, view.width, 44*newKhight)];
        lab.textColor = RGB(85, 85, 85);
        lab.text = _arr[i];
        lab.font = kFont(14);
        lab.tag = kYun_caipin_changeCaipintag+i;
        [view addSubview:lab];
        
        UIView *liVC = [[UIView alloc] initWithFrame:CGRectMake(80*newKwith, 9*newKhight, 1*newKwith, 25*newKhight)];
        liVC.backgroundColor = RGB(85, 85, 85);
        [view addSubview:liVC];
        
        
        if ([_select isEqualToString:@"菜品修改"]) {//菜品修改
            
            NSArray *arr = @[@"商品名称",@"菜品单价",@"会员价"];
            
            UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-145*newKwith, 0, 100*newKwith, 44*newKhight)];
            lb.text = arr[i];
            lb.textAlignment = NSTextAlignmentRight;
            lb.textColor = RGB(153, 153, 153);
            lb.font = kFont(13);
            [view addSubview:lb];
            lab.hidden = YES;
            liVC.hidden = YES;
            liVC.frame = CGRectMake(5*newKwith, 9*newKhight, 1, 25*newKhight);
            
        }
        
        CGFloat w;
        if ([_select isEqualToString:@"菜品修改"]) {
            
            w = 260*newKwith;
        }else {
        
          w = kWidth-liVC.endX-30*newKwith;
            
        }
            UITextField *CaiT = [[UITextField alloc] initWithFrame:CGRectMake(liVC.endX +5*newKwith, 0, w, 44*newKhight)];
            CaiT.font = kFont(15);
        CaiT.textColor = RGB(85, 85, 86);
        CaiT.clearButtonMode = 1;
        CaiT.inputAccessoryView = self.keyView;

            if (i==0) {
                CaiT.keyboardType = UIKeyboardTypeDefault;
                CaiT.placeholder = @"例如红烧鱼";
            }else {
            
                CaiT.keyboardType = UIKeyboardTypeDecimalPad;
            }
            [view addSubview:CaiT];
            CaiT.tag = kYun_home_addCaiT + i;
     
        [self addSubview:view];
        
    }
    
}

-(UIImageView *)PhotoimgView {

    if (!_PhotoimgView) {
        
        _PhotoimgView = [[UIImageView alloc]initWithFrame:CGRectMake(15*newKwith, 10*newKhight, kWidth-30*newKwith, 150*newKhight)];
        
        if ([_select isEqualToString:@"菜品修改"]) {
            
//            // blur效果
//            _LeftEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//            _LeftEfView.frame = CGRectMake(0, 0, 98*newKwith, 150*newKhight);
//            _LeftEfView.alpha = 0.98;
//            [self.PhotoimgView insertSubview:_LeftEfView atIndex:0];
//            
            _leftimgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 98*newKwith, 150*newKhight)];
            _leftimgView.userInteractionEnabled = YES;
            _leftimgView.hidden = YES;
            [self.PhotoimgView addSubview:_leftimgView];
            
            _PhotoimgView.image = kimage(@"bgxia");
            _PhotoimgView.layer.shadowColor = [[UIColor blackColor] CGColor];//阴影颜色
            _PhotoimgView.layer.shadowOffset = CGSizeMake(4, 4);//偏移距离
            _PhotoimgView.layer.shadowOpacity = 0.2;//不透明度
            _PhotoimgView.layer.shadowRadius =3.0;//半径
            _PhotoimgView.contentMode = UIViewContentModeScaleAspectFill;
            
//            // blur效果
//            _RightEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//            _RightEfView.frame = CGRectMake(248*newKwith, 0, 98*newKwith, 150*newKhight);
//            _RightEfView.alpha = 0.98;
//            [_PhotoimgView addSubview:_RightEfView];
            
            _rightimgView = [[UIImageView alloc]initWithFrame:CGRectMake(248*newKwith, 0, 98*newKwith, 150*newKhight)];
            _rightimgView.userInteractionEnabled = YES;
            _rightimgView.hidden = YES;
            [self.PhotoimgView addSubview:_rightimgView];
            
        }else {
        _PhotoimgView.image = kimage(@"Yun_home_addKindCai");
            _lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 106*newKhight, _PhotoimgView.width, 28)];
            _lb.textAlignment = NSTextAlignmentCenter;
            _lb.text = @"添加菜品";
            _lb.font = kFont(12);
            _lb.textColor = kGreenColor;
            [_PhotoimgView addSubview:_lb];
        }
    }
    return _PhotoimgView;
}



// 创建tableView
- (void)setupFoldingTableView
{
    YUFoldingTableView *foldingTableView = [[YUFoldingTableView alloc] initWithFrame:CGRectMake(15*newKwith, 397*newKhight-kNavBarHAndStaBarH, kWidth-30*newKwith, kHeight-397*newKhight-44*newKhight)];
    _foldingTableView = foldingTableView;
    [self addSubview:foldingTableView];
    _foldingTableView.backgroundColor = kWhiteColor;
    
    foldingTableView.foldingDelegate = self;
}

#pragma mark - YUFoldingTableViewDelegate / required（必须实现的代理）
// 返回箭头的位置
- (YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    // 没有赋值，默认箭头在左
    return self.arrowPosition ? :YUFoldingSectionHeaderArrowPositionRight;
}
//分区
- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return 2;
}
//分行
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section
{
    if (section == 0) {//菜品分类
        
        return 4;
    }
    return 3;//菜品状态;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section
{
    return 44*newKhight;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44*newKhight;
}
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if ([_select isEqualToString:@"菜品修改"]) {
            return @"热销菜品";
        }
        return @"菜品分类";
    }else if(section == 1){
        
        if ([_select isEqualToString:@"菜品修改"]) {
            return @"下架";
        }
        return @"菜品状态";
    }
    return [NSString stringWithFormat:@"Title %ld",(long)section];
}


//展示cell
- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ForcellID = @"ForcellID";
    
    UITableViewCell *cell = [yuTableView dequeueReusableCellWithIdentifier:ForcellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ForcellID];
    }
    
    if ([_select isEqualToString:@"菜品修改"]) {

        DLog(@"菜品修改");
        
    }else {
        DLog(@"新增菜品");
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DLog(@"%ld -- %ld",indexPath.section,indexPath.section);
    
       [yuTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView backgroundColorForHeaderInSection:(NSInteger )section {

    return RGB(242, 242, 242);
}

-(UIFont*)yuFoldingTableView:(YUFoldingTableView *)yuTableView fontForTitleInSection:(NSInteger)section {

    return kFont(14);
}

-(UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView textColorForTitleInSection:(NSInteger)section {

    return RGB(85, 85, 85);
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self endEditing:YES];
}

-(void)dealloc {

    [kNotificationCenter removeObserver:self];
}

@end
