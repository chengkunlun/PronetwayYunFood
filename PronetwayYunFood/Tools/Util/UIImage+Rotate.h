//
//  UIImage+Rotate.h
//  LoveHome
//
//  Created by yi on 14-3-27.
//  Copyright (c) 2014年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Rotate)

+(UIImage *)rotateImage:(UIImage *)aImage;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
//截取部分图像
-(UIImage*)getSubImage:(CGRect)rect;

//等比例缩放
-(UIImage*)scaleToSize:(CGSize)size;
@end
