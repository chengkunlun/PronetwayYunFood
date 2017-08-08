//
//  AddViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/13.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "AddViewController.h"
#import "AddView.h"
#define WEAK(weaks,s)  __weak __typeof(&*s)weaks = s;

@interface AddViewController ()<UITextFieldDelegate>
{
    
    NSArray *listArray;
    
}
@property (strong, nonatomic) AddView*addVC;

@property (nonatomic, strong) MLMOptionSelectView *cellView;
@property (strong, nonatomic) NSString *plateStr;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle:@"添加排号"];
    
    _addVC = [[AddView alloc]initWithFrame:kBounds];
    [_addVC.Savebtn addTarget:self action:@selector(BtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    _addVC.StarT.delegate = self;
    _addVC.EndT.delegate = self;
    [self.view addSubview:_addVC];
    
    _plateStr = [self.maxArr componentsJoinedByString:@","];
    
    //1. 去掉首尾空格和换行符
    _plateStr = [_plateStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //2. 去掉所有空格和换行符
    _plateStr = [_plateStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    _plateStr = [_plateStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    _plateStr = [_plateStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    DLog(@"%@",_plateStr);
    
    [self loadframe];
    
    listArray = self.codearr;
    _cellView = [[MLMOptionSelectView alloc] initOptionView];
    
    [self topBottom];

}

-(void)loadframe {

    if (self.maxArr.count == 0) {
        _addVC.subTitle.hidden = YES;
        _addVC.selectVC.frame = CGRectMake(15*newKwith, _addVC.StarT.endY+15*newKhight, kWidth-30*newKwith, 44*newKhight);
        
    }else {
    
        _addVC.subTitle.text = [NSString stringWithFormat:@"( 已经存在的区间 %@ )",_plateStr];
        CGFloat height = [StringUtil heightForString:_addVC.subTitle.text fontSize:13 andWidth:kWidth-30*newKwith];
        _addVC.subTitle.frame = CGRectMake(14*newKwith, _addVC.StarT.endY+5*newKhight, kWidth-30*newKwith, height-5*newKhight);
        _addVC.selectVC.frame = CGRectMake(15*newKwith, _addVC.subTitle.endY+5*newKhight, kWidth-30*newKwith, 44*newKhight);
    }
    
}

//点击换行保存
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string // return NO to not change text
{
    //判断是否超过 ACCOUNT_MAX_CHARS 个字符,注意要判断当string.leng>0
    //的情况才行，如果是删除的时候，string.length==0
    NSInteger length = textField.text.length;
    if (length >= ACCOUNT_MAX_CHARS && string.length >0)
    {
        return NO;
    }
    return YES;
}
- (void)topBottom {
    
    WEAK(weakTopB, _addVC.selectVC.btnlab);
    WEAK(weaklistArray, listArray);
    [_addVC.selectVC tapHandle:^{
        CGRect label3Rect = [MLMOptionSelectView targetView:_addVC.selectVC];
        [self defaultCell];
        _cellView.arrow_offset = .5;
        _cellView.vhShow = YES;
        _cellView.optionType = MLMOptionSelectViewTypeCustom;
        _cellView.selectedOption = ^(NSIndexPath *indexPath) {
          //  weakTopB.text = weaklistArray[indexPath.row];
            
            weakTopB.text = weaklistArray[indexPath.row];
            DLog(@"%ld",indexPath.row);
        };
        
        [_cellView showViewFromPoint:CGPointMake(label3Rect.origin.x, label3Rect.origin.y+label3Rect.size.height) viewWidth:kWidth-30*newKwith targetView:_addVC.selectVC direction:MLMOptionSelectViewBottom];
    }];
    
}

- (void)defaultCell {
    WEAK(weaklistArray, listArray);
    WEAK(weakSelf, self);
    _cellView.canEdit = NO;
    [_cellView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DefaultCell"];
    _cellView.cell = ^(NSIndexPath *indexPath){
        UITableViewCell *cell = [weakSelf.cellView dequeueReusableCellWithIdentifier:@"DefaultCell"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",weaklistArray[indexPath.row]];
        return cell;
    };
    _cellView.optionCellHeight = ^{
        return 40.f;
    };
    _cellView.rowNumber = ^(){
        return (NSInteger)weaklistArray.count;
    };
}
//保存按钮的点击事件
-(void)BtnClick:(RedBtn *)btn {

    DLog(@"----");
    
    if ([self checkT]) {
        
        NSString *min = _addVC.StarT.text;
        NSString *max = _addVC.EndT.text;
  
        NSString *finMin;
        NSString *finMax;
        if ( [min integerValue]<[max integerValue]) {
            finMin = min;
            finMax = max;
        }else {
            finMax = min;
            finMin = max;
        }

        NetworkManger *manger = [NetworkManger new];
        [manger paiduijiaohao:_addVC.selectVC.btnlab.text name:_addVC.nameT.text min:finMin max:finMax];
        manger.Addkezuofenqusuccessblock = ^{
            
           // [PronetwayYunFoodHandle shareHandle].isToreadjosn = YES;
            
            NetworkManger *manger = [NetworkManger new];
            [manger paiduiupdate];
            manger.Addkezuofenqusuccessblock = ^{
                //[PronetwayYunFoodHandle shareHandle].isToreadjosn = NO;
                [self.navigationController popViewControllerAnimated:YES];
            };
            //[self.navigationController popViewControllerAnimated:YES];
        };
    }
}

-(BOOL)checkT {

    if (kStringIsEmpty(_addVC.nameT.text)) {
        [self yaoBai:_addVC.nameT];
        return NO;
    }
    if ([self bijiao] == NO) {
        [WSProgressHUD showImage:nil status:@"新增区间有重复"];
        return NO;
    }
    if (kStringIsEmpty(_addVC.StarT.text)) {
        [self yaoBai:_addVC.StarT];

        return NO;
    }
    if (kStringIsEmpty(_addVC.EndT.text)) {
        [self yaoBai:_addVC.EndT];

        return NO;
    }
    
    if ([_addVC.selectVC.btnlab.text isEqualToString:@"客桌类型"]) {
        
        [WSProgressHUD showImage:nil status:@"客桌类型不能为空"];
        return NO;
    }
    
    
    
    return YES;
}


-(BOOL)bijiao {

    for (NSMutableArray *arr in self.maxArr) {
        
        if (arr.count==2) {
            
            int min = [arr[0] intValue];
            int max = [arr[1] intValue];
            
            if ([_addVC.StarT.text integerValue]>=min&&[_addVC.StarT.text integerValue]<=max) {
                
                return NO;
                break;
            }
            
            if ([_addVC.EndT.text integerValue]>=min&&[_addVC.EndT.text integerValue]<=max) {
                
                return NO;
                break;
            }
        }

    }
    return YES;
}


-(void)yaoBai:(UITextField *)textfield {
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.duration = 0.2;
    anim.repeatCount = 2;
    anim.values = @[@-20, @20, @-20];
    [textfield.layer addAnimation:anim forKey:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
