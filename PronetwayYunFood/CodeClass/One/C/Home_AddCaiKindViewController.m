//
//  Home_AddCaiKindViewController.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/17.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "Home_AddCaiKindViewController.h"
#import "AddCaiKindView.h"
#import "UIViewController+Animations.h"
#import "SelectViewController.h"
#import "postImage.h"
#import "UIImageView+LBBlurredImage.h"
@interface Home_AddCaiKindViewController ()<addCaiDelegate,selectDelegate,UITextFieldDelegate>
@property (strong, nonatomic) AddCaiKindView *addkindVC;
@property (strong, nonatomic) NSString *CaipinStatus;
@property (strong, nonatomic) NSString *caiStyleSid;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) UIImage *imgphoto;

@end

@implementation Home_AddCaiKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.selectStr isEqualToString:@"菜品修改"]) {
        
        [self setCustomerTitle:@"菜品修改"];
        _addkindVC = [[AddCaiKindView alloc]initWithFrame:kBounds select:@"菜品修改"];
        _addkindVC.delegate = self;
        
        UITextField *CaiT = (UITextField *)[_addkindVC viewWithTag:kYun_home_addCaiT];
        UITextField *CaiT1 = (UITextField *)[_addkindVC viewWithTag:kYun_home_addCaiT+1];
        UITextField *CaiT2 = (UITextField *)[_addkindVC viewWithTag:kYun_home_addCaiT+2];
        CaiT1.delegate = self;
        CaiT.delegate = self;
        CaiT2.delegate = self;

       // _addkindVC.lab1.text = self.caiModel.
        CaiT.text = self.caiModel.name;
        CaiT1.text = [NSString stringWithFormat:@"%0.2f",[self.caiModel.price floatValue]/100];
        CaiT2.text = [NSString stringWithFormat:@"%0.2f",[self.caiModel.vipprice floatValue]/100];
        
        //菜品种类的id
        for (StyleCaiPinModel *model in self.caipinArr) {
            
            if ([model.sid isEqualToString:self.caiModel.classifyid]) {
                
                _addkindVC.lab1.text = model.name;
                _caiStyleSid = self.caiModel.classifyid;
                break;
            }
        }
        //菜品图片地址
        _imageUrl = self.caiModel.imgpath;
        
        [_addkindVC.PhotoimgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kIP,self.caiModel.imgpath]]];
        [_addkindVC.PhotoimgView.image scaleToSize:CGSizeMake(kWidth-30*newKwith, 150*newKhight)];
        
        CGRect s =CGRectMake(0, 0, 98*newKwith, 150*newKhight);
        CGRect s1 = CGRectMake(248*newKwith, 0, 98*newKwith, 150*newKhight);
        UIImage *leftimg = [_addkindVC.PhotoimgView.image getSubImage:s];
        UIImage *rightimg = [_addkindVC.PhotoimgView.image getSubImage:s1];
        if (_addkindVC.PhotoimgView.image != nil) {
            _addkindVC.leftimgView.hidden = NO;
            [_addkindVC.leftimgView setImageToBlur:leftimg blurRadius:8 completionBlock:nil];
            _addkindVC.rightimgView.hidden = NO;
            [_addkindVC.rightimgView setImageToBlur:rightimg blurRadius:8 completionBlock:nil];
        }
        if ([self.caiModel.status isEqualToString:@"0"]) {
            _addkindVC.lab2.text = @"上架";
            _CaipinStatus = @"0";
        }else {
            _addkindVC.lab2.text = @"下架";
            _CaipinStatus = @"1";
        }
        [self.view addSubview:_addkindVC];
        _addkindVC.delegate = self;
        [self addTap];//上传图片
    }else {
        _addkindVC = [[AddCaiKindView alloc]initWithFrame:kBounds select:@"新增菜品"];
        [self.view addSubview:_addkindVC];
        _addkindVC.delegate = self;
        _addkindVC.lab1.text = self.styleModel.name;
        _caiStyleSid = self.styleModel.sid;
        _addkindVC.lab2.text = @"上架";
         _CaipinStatus = @"0";
        [self setCustomerTitle:@"新增菜品"];
        [self addTap];//上传图片
    }
}
-(void)onpressstylecaipin:(StyleCaiPinModel *)model {

    _addkindVC.lab1.text = model.name;
    _caiStyleSid = model.sid;
    
}
-(void)onpressAddCaipinStyle:(NSString *)style {

    _addkindVC.lab2.text = style;
    
    if ([style isEqualToString:@"上架"]) {
        _CaipinStatus = @"0";
    }else {
        _CaipinStatus = @"1";
    }
}
//按钮的点击事件
-(void)onpressBtn1 {
    if ([self.selectStr isEqualToString:@"菜品修改"]) {
        
        SelectViewController *selectVC = [SelectViewController new];
        selectVC.selectstr = @"菜品修改";
        selectVC.selectArr = self.caipinArr;
        selectVC.delegate = self;
        [self.navigationController pushViewController:selectVC animated:YES];
    }else {
        SelectViewController *selectVC = [SelectViewController new];
        selectVC.selectstr = @"菜品分类";
        selectVC.selectArr = self.caipinArr;
        selectVC.delegate = self;
        [self.navigationController pushViewController:selectVC animated:YES];
}}

-(void)onpressBtn2 {
    
    if ([self.selectStr isEqualToString:@"菜品修改"]) {
        
        SelectViewController *selectVC = [SelectViewController new];
        selectVC.selectstr = @"菜品状态";
        selectVC.delegate = self;
        [self.navigationController pushViewController:selectVC animated:YES];
    }else {
        SelectViewController *selectVC = [SelectViewController new];
        selectVC.selectstr = @"菜品状态";
        selectVC.delegate = self;
        [self.navigationController pushViewController:selectVC animated:YES];
    }
}

//给图片添加点击事件
-(void)addTap {
    _addkindVC.PhotoimgView.userInteractionEnabled = YES;
    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView:)];
    PrivateLetterTap.numberOfTouchesRequired = 1; //手指数
    
    PrivateLetterTap.numberOfTapsRequired = 1; //tap次数
    
    _addkindVC.PhotoimgView.contentMode = UIViewContentModeScaleToFill;
    [_addkindVC.PhotoimgView addGestureRecognizer:PrivateLetterTap];
    
    [_addkindVC.saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
}

//添加图片
-(void)tapAvatarView:(UITapGestureRecognizer*)tapgester{

    [self showCanEdit:YES photo:^(UIImage *photo) {
        
        _imgphoto = photo;
        _addkindVC.PhotoimgView.image = [photo scaleToSize:CGSizeMake(kWidth-30*newKwith, 150*newKhight)];
        _addkindVC.lb.hidden = YES;
    }];
}

-(void)saveBtnClick:(id)sender {

    if ([self.selectStr isEqualToString:@"菜品修改"]) {//修改
        if ([self checkT]) {
            
            if (_imgphoto == nil) {//没有选择图片
                
                //添加并保存
                UITextField *CaiT = (UITextField *)[_addkindVC viewWithTag:kYun_home_addCaiT];
                UITextField *CaiT1 = (UITextField *)[_addkindVC viewWithTag:kYun_home_addCaiT+1];
                UITextField *CaiT2 = (UITextField *)[_addkindVC viewWithTag:kYun_home_addCaiT+2];
                NetworkManger *manger = [NetworkManger new];
                [manger addCaipin:CaiT.text price:[NSString stringWithFormat:@"%0.2f",[CaiT1.text floatValue]*100] vipPrice:[NSString stringWithFormat:@"%0.2f",[CaiT2.text floatValue]*100] stySid:_caiStyleSid status:_CaipinStatus imagepath:_imageUrl action:@"edit" sid:self.caiModel.sid];
                manger.Addkezuofenqusuccessblock = ^{
                    
                    [self.navigationController popViewControllerAnimated: YES];
                };
                
            }else {//
            
                [self postimage:@"edit"];
                
            }
        DLog(@"可以了");
        }
    }else {//新增
        if ([self checkT]) {
            
            if ([self.CaipinStatus isEqualToString:@"1"]) {
                
            [WSProgressHUD showImage:nil status:@"新增菜品状态只能为上架"];
            return;
            }
            //上传
        [self postimage:@"add"];
        DLog(@"可以了");
            
        }
    }
    DLog(@"保存");
}
//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

-(BOOL)checkT {
    
    UITextField *CaiT = (UITextField *)[_addkindVC viewWithTag:kYun_home_addCaiT];
    UITextField *CaiT1 = (UITextField *)[_addkindVC viewWithTag:kYun_home_addCaiT+1];
    UITextField *CaiT2 = (UITextField *)[_addkindVC viewWithTag:kYun_home_addCaiT+2];
    
    if (kStringIsEmpty(CaiT.text)) {
        [WSProgressHUD showImage:nil status:@"请填写菜品名称"];
        return NO;
    }
    if ([self strem:CaiT.text]) {
        
        [WSProgressHUD showImage:nil status:@"菜品名称之间不能有空格"];
    }
    if (kStringIsEmpty(CaiT1.text)) {
        [WSProgressHUD showImage:nil status:@"请填写菜品单价"];
        return NO;
    }
    if (kStringIsEmpty(CaiT2.text)) {
        [WSProgressHUD showImage:nil status:@"请设置会员价"];
        return NO;
    }
    if (kStringIsEmpty(self.caiStyleSid)) {
        [WSProgressHUD showImage:nil status:@"请选择菜品种类"];
        return NO;
    }
    if (kStringIsEmpty(self.CaipinStatus)) {
        [WSProgressHUD showImage:nil status:@"请选择菜品状态"];
        return NO;
    }
    
    
    if ([self.selectStr isEqualToString:@"菜品修改"]) {
        if (kStringIsEmpty(_imageUrl)) {
            [WSProgressHUD showImage:nil status:@"请选择菜品图片"];
            return NO;
        }
        
    }else {
    
    if (_imgphoto == nil) {
        [WSProgressHUD showImage:nil status:@"请选择菜品图片"];
        return NO;
    }
 }
    return YES;
}

-(BOOL)strem:(NSString *)str {

    NSRange _range = [str rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        
        return YES;
        
    }else {
        return NO;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
}

//上传图片
-(void)postimage:(NSString *)action{
    
    [WSProgressHUD showWithStatus:@"正在上传 .."];
    //上传之前压缩图片
    UIImage *img = [self imageWithImage:_imgphoto scaledToSize:CGSizeMake(400*newKwith, 400*newKhight)];
    
    NSArray *Ar = [NSArray arrayWithObjects:img, nil];
    
    NSDictionary *dict = @{@"FunName":@"ict_uploadpicture",@"path":@"/uploadNews",@"appfile":[NSString stringWithFormat:@"%@%@",[DateUtil getCurrentTimestamp],@".png"]};
    
    [postImage uploadWithURL:[NSString stringWithFormat:@"%@%@",kIpandPort,@"/pronline/upload"] parameters:dict images:Ar name:@"app_user_header" fileName:[NSString stringWithFormat:@"%@%@",[DateUtil getCurrentTimestamp],@".png"] mimeType:@"png" progress:^(NSProgress *progress) {
        CGFloat stauts = 100.f * progress.completedUnitCount/progress.totalUnitCount;
        DLog(@"progerss---%0.0f",stauts);
    } success:^(id responseObject) {
        DLog(@"成功了");
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"result"] isEqualToString:@"0"]) {
            [WSProgressHUD showImage:nil status:@"上传成功"];
            //_IconIM.image = Photoimage;
            NSString *SeverlinkUrl = dic[@"link"];
            
            _imageUrl = SeverlinkUrl;
            
            //添加并保存
            UITextField *CaiT = (UITextField *)[_addkindVC viewWithTag:kYun_home_addCaiT];
            UITextField *CaiT1 = (UITextField *)[_addkindVC viewWithTag:kYun_home_addCaiT+1];
            UITextField *CaiT2 = (UITextField *)[_addkindVC viewWithTag:kYun_home_addCaiT+2];
            NetworkManger *manger = [NetworkManger new];
            [manger addCaipin:CaiT.text price:[NSString stringWithFormat:@"%0.2f",[CaiT1.text floatValue]*100]  vipPrice:[NSString stringWithFormat:@"%0.2f",[CaiT2.text floatValue]*100]  stySid:_caiStyleSid status:_CaipinStatus imagepath:_imageUrl action:action sid:self.caiModel.sid];
            manger.Addkezuofenqusuccessblock = ^{
                //设置蒙板页面
                [UserDefaults setObjectleForStr:@"YES" key:kshowCai];
                
                [self.navigationController popViewControllerAnimated: YES];
            };
            
        }else {
            [WSProgressHUD showImage:nil status:dic[@"msg"]];
            
        }
        
    } failure:^(NSError *error) {
        DLog(@"%@",error);
        [WSProgressHUD showImage:nil status:@"服务器错误"];
        [WSProgressHUD dismiss];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
