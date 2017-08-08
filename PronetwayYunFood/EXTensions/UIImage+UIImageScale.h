//
//  UIImage+UIImageScale.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/6.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageScale)

-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;

//返回裁剪区域图片,返回裁剪区域大小图片
- (UIImage *)clipWithImageRect:(CGRect)clipRect clipImage:(UIImage *)clipImage;

@end
