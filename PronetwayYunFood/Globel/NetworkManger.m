//
//  NetworkManger.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/26.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "NetworkManger.h"

@implementation NetworkManger

//添加
-(void)reloadJosnForaddkezhuofenqu:(NSString *)input {

    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@",kIpandPort,kaddkezuofenqu1,input,kaddkezuofenqu2,[UserDefaults objectForKeyStr:ksid],kaddkezuofenqu3];
    
    DLog(@"添加客桌分区 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"添加成功"];
            [kNotication postNotificationName:@"reloadfenqu" object:nil];//发通知
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
        }else if ([dic[@"result"] isEqualToString:@"2"]){
        
        [WSProgressHUD showImage:nil status:@"必填参数为空"];
            
        }else if ([dic[@"result"] isEqualToString:@"12"]){
            
            [WSProgressHUD showImage:nil status:@"类型已经存在"];
            
        }else {
        [WSProgressHUD showImage:nil status:@"添加失败"];
            
    }
        
  } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"系统错误"];
        DLog(@"%@",error);
    }];
    

}

//修改
-(void)reloadJosnForchangekezhuofenqu:(kezhuofenquModel *)model input:(NSString *)input {

    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",kIpandPort,kchangekezuofenqu1,input,kchangekezuofenqu2,model.sid,kchangekezuofenqu3,[UserDefaults objectForKeyStr:ksid],kchangekezuofenqu5,model.znumberint];
    
    DLog(@"修改客桌分区 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"修改成功"];
            [kNotication postNotificationName:@"reloadfenqu" object:nil];//发通知
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
            
            
        }else {
            
            
            [WSProgressHUD showImage:nil status:@"修改失败"];
        }
        
        
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器出错"];
        DLog(@"%@",error);
    }];
    
}

//删除客桌分区
-(void)deletkezhuofenqu:(kezhuofenquModel *)model{

    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kdeletkezhuofenqu1,model.sid,kdeletkezhuofenqu2,[UserDefaults objectForKeyStr:ksid]];
    
    DLog(@"修改客桌分区 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"删除成功"];
        [kNotication postNotificationName:@"reloadfenqu" object:nil];//发通知
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }

            
        }else if ([dic[@"result"]isEqualToString:@"9"]) {
        
            [WSProgressHUD showImage:nil status:@"客桌被占用,不能删除"];
            
        }else  {
            
            [WSProgressHUD showImage:nil status:@"删除失败"];
            
        }
        
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器出错"];
        DLog(@"%@",error);
    }];
}
//批量删除客桌分区/单个删除分区
-(void)deletepf:(NSString *)sid {

    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kdeletkezhuofenqu1,sid,kdeletkezhuofenqu2,[UserDefaults objectForKeyStr:ksid]];
    
    DLog(@"批量删除客桌分区 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"删除成功"];
            [kNotication postNotificationName:@"reloadfenqu" object:nil];//发通知
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
                
            }

            
        }else if ([dic[@"result"]isEqualToString:@"9"]) {
            
            [WSProgressHUD showImage:nil status:@"客桌被占用,不能删除"];
            
        }else {
            
            [WSProgressHUD showImage:nil status:@"删除失败"];
            
        }
        
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器出错"];
        DLog(@"%@",error);
    }];
    
}

//添加桌位
-(void)addkezhuoNumbers:(NSString *)deskNumbers people:(NSString *)people fenqu:(NSString *)fenqu model:(kezhuofenquModel *)model {

    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",kIpandPort,kTJkezhuo1,deskNumbers,kTJkezhuo2,[UserDefaults objectForKeyStr:ksid],kTJkezhuo3,people,kTJkezhuo4,model.sid];
    
    DLog(@"添加客桌 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"添加成功"];
            [kNotication postNotificationName:@"reloadkezuo" object:nil];//发通知
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
            
            
           
            
        }else if ([dic[@"result"] isEqualToString:@"11"]) {
        
            [WSProgressHUD showImage:nil status:@"添加客桌名称重复"];
        }else {
        
            [WSProgressHUD showImage:nil status:@"添加失败"];
        }
        
        
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

//删除客桌
-(void)deletekezuoaAll:(NSString *)sid {

    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kdeletkezhuo1,sid,kdeletkezhuo2,[UserDefaults objectForKeyStr:ksid]];
    
    DLog(@"批量删除客桌 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"删除成功"];
           [kNotication postNotificationName:@"reloadkezuo" object:nil];//发通知
            
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
            
            
        }
        else if ([dic[@"result"]isEqualToString:@"9"]) {
            
            [WSProgressHUD showImage:nil status:@"客桌被占用,不能删除"];
            
        }else {
            
            [WSProgressHUD showImage:nil status:@"删除失败"];
            
        }
        
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器出错"];
        DLog(@"%@",error);
    }];
}

//批量添加桌位
-(void)pddkezhuoNumberspeople:(NSString *)people  model:(kezhuofenquModel *)model seid:(NSString *)seid enid:(NSString *)enid {

    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@",kIpandPort,kaddAllkehzuo,kTJkezhuo2,[UserDefaults objectForKeyStr:ksid],kTJkezhuo3,people,kTJkezhuo4,model.sid,kaddAllkehzuo1,seid,kaddAllkehzuo2,enid];
    
    DLog(@"批量添加客桌 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"添加成功"];
            [kNotication postNotificationName:@"reloadkezuo" object:nil];//发通知
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
            //取消蒙板
            [UserDefaults setObjectleForStr:@"YES" key:kshowdeskManager];
            
        }else if ([dic[@"result"] isEqualToString:@"11"]) {
            if (self.Failblock) {
                self.Failblock();
            }
            [WSProgressHUD showImage:nil status:@"添加客桌名称重复"];
        }else {
            if (self.Failblock) {
                self.Failblock();
            }
            [WSProgressHUD showImage:nil status:@"添加失败"];
        }
        
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
        
        
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (data != nil) {
            //            id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            DLog(@"批量添加客桌服务器返回错误主体 error--%@", str); //就可以获取到错误时返回的body信息。
        }
    }];
}
//给课桌分区排序
-(void)paixuFenqu:(NSString *)plateStr {

    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kFenqupaixu1,plateStr,kFenqupaixu2,[UserDefaults objectForKeyStr:ksid]];
    
    DLog(@"客桌分区排序 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"排序成功"];
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
        }else {
            [WSProgressHUD showImage:nil status:@"添加失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

//修改桌位
-(void)changeKezhuo:(NSString *)zoneid seatnum:(NSString *)seatnum numid:(NSString *)numbid  sid:(NSString *)sid oldnumid:(NSString *)oldnumid oldzoneid:(NSString *)oldzoneid{

        NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",kIpandPort,kXGkehzuo1,numbid,kXGkehzuo2,[UserDefaults objectForKeyStr:ksid],kXGkehzuo3,seatnum,kXGkehzuo4,zoneid,kXGkehzuo5,sid,@"&oldzoneid=",oldzoneid,@"&oldnumid=",oldnumid];
        
        DLog(@"修改客桌 -- %@",str);
        [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
            
            NSDictionary *dic = (NSDictionary *)responseObject;
            if ([dic[@"result"] isEqualToString:@"0"]) {
                
                [WSProgressHUD showImage:nil status:@"修改成功"];
                [kNotication postNotificationName:@"reloadkezuo" object:nil];//发通知
                if (self.Addkezuofenqusuccessblock) {
                    self.Addkezuofenqusuccessblock();
                }
                
            }else if ([dic[@"result"] isEqualToString:@"11"]) {
            
                [WSProgressHUD showImage:nil status:@"客桌编号重复"];
            }else {
                
                [WSProgressHUD showImage:nil status:@"修改失败"];
            }
        } failure:^(NSError *error) {
            [WSProgressHUD showImage:nil status:@"服务器错误"];
            DLog(@"%@",error);
        }];
}

//添加菜品种类
-(void)addCaipinstyle:(NSString *)CaipinStylestr {
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@",kIpandPort,kaddCaiPinstyle1,CaipinStylestr,kaddCaiPinstyle2,[UserDefaults objectForKeyStr:ksid],kaddCaiPinstyle3];
    
    DLog(@"添加菜品种类 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"添加成功"];
            [kNotication postNotificationName:@"reloadJosnForstyleCaipin" object:nil];//发通知
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
            
        }else if ([dic[@"result"]isEqualToString:@"2"]) {
        
            [WSProgressHUD showImage:nil status:@"已有相同分类"];
        }
        else {
            
            [WSProgressHUD showImage:nil status:@"添加失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

//添加菜品/修改菜品
-(void)addCaipin:(NSString *)caiPinName price:(NSString *)price vipPrice:(NSString *)vipPrice stySid:(NSString *)stySid status:(NSString  *)status imagepath:(NSString *)imagepath action:(NSString *)action sid:(NSString *)sid{

    NSString *str;
    
    if ([action isEqualToString:@"add"]) {
        
     str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",kIpandPort,kAddcaipin,action, kAddcaipin1,caiPinName,kAddcaipin2,[UserDefaults objectForKeyStr:ksid],kAddcaipin3,price,kAddcaipin4,vipPrice,kAddcaipin5,stySid,kAddcaipin6,status,kAddcaipin7,caiPinName,kAddcaipin8,imagepath];
        DLog(@"添加菜品 -- %@",str);
    }else {
    
        str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",kIpandPort,kAddcaipin,action, kAddcaipin1,caiPinName,kAddcaipin2,[UserDefaults objectForKeyStr:ksid],kAddcaipin3,price,kAddcaipin4,vipPrice,kAddcaipin5,stySid,kAddcaipin6,status,kAddcaipin7,caiPinName,kAddcaipin8,imagepath,@"&sid=",sid];
        DLog(@"修改菜品 -- %@",str);
    }
    
    [CKLRequestManger GET:[str stringByReplacingOccurrencesOfString:@" " withString:@""] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"添加成功"];
            [kNotication postNotificationName:@"reloadjosnForcaipin" object:nil];//发通知到菜品管理界面,修改菜品
            
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
            
        }else if ([dic[@"result"]isEqualToString:@"7"]) {
        
         
            [WSProgressHUD showImage:nil status:@"已有相同菜品"];
        }else {
            
            [WSProgressHUD showImage:nil status:@"添加失败"];
        }
        
        
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
    
}
//修改菜品种类
-(void)changeCaipinStyle:(StyleCaiPinModel *)caipinStyle name:(NSString *)name {

    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",kIpandPort,kChangeCaipinstyle1,name,kChangeCaipinstyle2,[UserDefaults objectForKeyStr:ksid],kChangeCaipinstyle3,caipinStyle.orderid,kChangeCaipinstyle4,caipinStyle.sid];
    
    DLog(@"修改菜品种类 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"修改成功"];
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
        [kNotication postNotificationName:@"reloadJosnForstyleCaipin" object:nil];//发通知到菜品管理界面,修改菜品种类

        }else {
            [WSProgressHUD showImage:nil status:@"修改失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

//给菜品排序
-(void)paixuForsort:(NSString *)sort {

    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kPXCaiPin,[UserDefaults objectForKeyStr:ksid],kPXCaiPin1,sort];
    
    DLog(@"给菜品排序 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"排序成功"];
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
        }else {
            [WSProgressHUD showImage:nil status:@"排序失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

-(void)addsFood:(NSString *)groupid tableid:(NSString *)tableid content:(NSString *)content {

    [WSProgressHUD showShimmeringString:@"生成订单.."];
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",kIpandPort,kadds1,[UserDefaults objectForKeyStr:ksid],kadds2,tableid,kadds3,content];
    
    DLog(@"购物车批量添加排序 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
            [WSProgressHUD dismiss];
        }else {
            [WSProgressHUD showImage:nil status:@"添加失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

-(void)delet:(NSString *)caiSid {

    //删除菜品
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kdeletCaiPin1,caiSid,kdeletCaiPin2,[UserDefaults objectForKeyStr:ksid]];
    
    DLog(@"删除菜品 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
            [WSProgressHUD dismiss];
        }else {
            
            [WSProgressHUD showImage:nil status:@"删除失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

//删除菜品种类
-(void)deleteCaiStyle:(NSString *)setyleSid {

    //删除菜品
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kdeleteCaipinstyle1,[UserDefaults objectForKeyStr:ksid],kdeleteCaipinstyle2,setyleSid];
    
    DLog(@"删除菜品种类 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"删除成功"];
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
            [WSProgressHUD dismiss];
        }else {
            [WSProgressHUD showImage:nil status:@"删除失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

//排队叫号,新增客桌类型
-(void)paiduijiaohao:(NSString *)code name:(NSString *)name min:(NSString *)min max:(NSString *)max {

    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",kIpandPort,kpaidui_add1,code,kpaidui_add2,name,kpaidui_add3,min,kpaidui_add4,max,kpaidui_add5,[UserDefaults objectForKeyStr:ksid]];
    DLog(@"叫号新增客桌%@",urlStr);
    
    [CKLRequestManger GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [WSProgressHUD showImage:nil status:@"添加成功"];
            [kNotificationCenter postNotificationName:@"reloadjosnForpaiduiGetlist" object:nil];
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
            [WSProgressHUD dismiss];
        }else {
            DLog(@"叫号添加 %@",dic);
            [WSProgressHUD showImage:nil status:@"添加失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}

//删除
-(void)deletepaiduilist:( paidui_listModel *)model {

    //删除菜品
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",kIpandPort,kpaidui_delet1,model.sid,kpaidui_delet3,[UserDefaults objectForKeyStr:ksid],kpaidui_delet2,model.code];
    
    DLog(@"排队叫号删除 -- %@",str);
    [CKLRequestManger GET:str parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [kNotificationCenter postNotificationName:@"reloadjosnForpaiduiGetlist" object:nil];

            [WSProgressHUD showImage:nil status:@"删除成功"];
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
            [WSProgressHUD dismiss];
        }else {
            DLog(@"排队叫号删除返回的字典是%@",dic);
            [WSProgressHUD showImage:nil status:@"删除失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
    
}

//排号新增
-(void)paiHaoadd:(NSString *)tel num:(NSString *)num {

    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",kIpandPort,kpai_add1,[UserDefaults objectForKeyStr:ksid],kpai_add2,num,kpai_add2,tel];
    DLog(@"排号新增客桌%@",urlStr);
    
    [CKLRequestManger GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
        }else {
            [WSProgressHUD showImage:nil status:@"添加失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}
//叫号更新
-(void)paiduiupdate {

    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",kIpandPort,kpaidui_update1,[UserDefaults objectForKeyStr:ksid]];
    DLog(@"叫号更新客桌%@",urlStr);
    
    [CKLRequestManger GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
        }else {
            [WSProgressHUD showImage:nil status:@"更新失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}
#pragma mark --新增
//充值营销增加
-(void)memberPayAddrecharge:(NSString *)recharge give:(NSString *)give total:(NSString *)total startdate:(NSString *)startdate enddate:(NSString *)enddate status:(NSString *)status {

    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",kIpandPort,kHuiyuan_Addchongzhi1,recharge,kHuiyuan_Addchongzhi2,give,kHuiyuan_Addchongzhi3,total,kHuiyuan_Addchongzhi4,startdate,kHuiyuan_Addchongzhi5,enddate,kHuiyuan_Addchongzhi6,status,kHuiyuan_Addchongzhi7, [UserDefaults objectForKeyStr:ksid]];
    DLog(@"我的会员充值营销新增%@",urlStr);
    
    [CKLRequestManger GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            
            [kNotificationCenter postNotificationName:@"reloadForchongzhigetList" object:nil];
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
        }else {
            [WSProgressHUD showImage:nil status:@"添加失败"];
        }
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        DLog(@"%@",error);
    }];
}


//修改订单状态
-(void)reloadOrderStatus:(NSString *)orderno type:(NSString *)type {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@",kIpandPort,kchangeorderDYStatus1,orderno,kchangeorderDYStatus2,type];
    DLog(@"修改客桌订单状态  type is %@ -- %@",url,type);
    
    [CKLRequestManger GET:url parameters:nil success:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"]isEqualToString:@"0"]) {
            
            if (self.Addkezuofenqusuccessblock) {
                self.Addkezuofenqusuccessblock();
            }
            
            [WSProgressHUD showImage:nil status:@"订单状态修改成功"];
        }else {
            if (self.Failblock) {
                self.Failblock();
            }
            [WSProgressHUD showImage:nil status:@"订单状态修改失败"];
        }
        
    } failure:^(NSError *error) {
        [WSProgressHUD showImage:nil status:@"服务器出错"];
        if (self.Failblock) {
            self.Failblock();
        }
    }];
    
}




@end
