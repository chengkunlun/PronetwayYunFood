//
//  FishMealViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/20.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "FishMealViewController.h"
#import "FishMealView.h"

#import "incomeModel.h"
#import "mutilModel.h"

@interface FishMealViewController ()

@property (strong, nonatomic)FishMealView *fishVC ;
@property (strong, nonatomic) NSMutableArray *allcaiArr;
@property (strong, nonatomic) NSMutableArray *incomeArr;

@end

@implementation FishMealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomerTitle:@"收银"];
    
    [self reloadjosnForlist];
    
   _fishVC = [[FishMealView alloc]initWithFrame:kBounds];
    [_fishVC.fishMealBtn addTarget:self action:@selector(fishmeal:) forControlEvents:(UIControlEventTouchUpInside)];
    [_fishVC.goonBtn addTarget:self action:@selector(goonBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
   [self.view addSubview:_fishVC];
    
    
        
    // Do any additional setup after loading the view.
}

-(void)goonBtnClick:(UIButton *)btn {

    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark --- 懒加载 ---
-(NSMutableArray *)incomeArr {
    
    if (!_incomeArr) {
        _incomeArr = [NSMutableArray array];
    }
    return _incomeArr;
    
}

-(NSMutableArray *)allcaiArr {
    
    if (!_allcaiArr) {
        _allcaiArr = [NSMutableArray array];
    }
    return _allcaiArr;
}

-(void)fishmeal:(UIButton *)btn {

    [self fishMeal];
}


//结束用餐
-(void)fishMeal {


    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kfinishMeals1,self.model.sid,kfinishMeals12,[UserDefaults objectForKeyStr:ksid]];
    DLog(@"结束用餐 -- %@",url);
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
    NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"用餐结束!"];
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([dic[@"result"]isEqualToString:@"0"]) {
        
            [WSProgressHUD showImage:nil status:@"该桌订单未支付,或者已经完成用餐"];
        }
        
    } failure:^(NSError *error) {
        DLog(@"%@",error);
        [WSProgressHUD showImage:nil status:@"解析出错"];
    }];
    
    
}

-(void)reloadjosnForlist {
    
    NSString *urlstr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",kIpandPort,kincome_getlist1,@"",self.model.sid,kincome_getlist2,[UserDefaults objectForKeyStr:ksid],kincome_getlist3,[UserDefaults objectForKeyStr:kpid]];
    DLog(@"收银获取菜品列表的url %@",urlstr);
    
    [CKLRequestManger GET:urlstr parameters:nil success:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"]isEqualToString:@"0"]) {
            NSArray *arr = dic[@"orderinfo"];
            if (arr.count == 0) {
                
                return ;
            }
            
            for (NSDictionary *dict in arr) {
                
                mutilModel *model = [mutilModel setUpModelWithDictionary:dict];
                [self.allcaiArr addObject:model];
                
            }
            DLog(@"mubArr -- %ld",self.allcaiArr.count);
            
            for (mutilModel *model in self.allcaiArr) {
                
                NSArray *arr1 = model.dishesinfo;
                NSMutableArray *mbArr = [NSMutableArray array];
                
                for (NSDictionary *dictt in arr1) {
                    incomeModel *model = [incomeModel setUpModelWithDictionary:dictt];
                    [mbArr addObject:model];
                    
                }
                [self.incomeArr addObject:mbArr];
            }
            
            //刷新数据源
            
            if (self.incomeArr.count!=0) {
                
                NSString *str = [self AllPrice:self.allcaiArr];
                _fishVC.moneyLab.text = str;
                
            }
        }else {
            
            [WSProgressHUD showImage:nil status:@"无数据"];
        }
        
        
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}


-(NSString *)AllPrice:(NSMutableArray *)Arr {
    //计算钱
    float all = 0.00;
    for (mutilModel *model in Arr) {
        
        all += model.cmoney ;
    }
    return   [NSString stringWithFormat:@"¥ %0.2f",all/100];
    
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
