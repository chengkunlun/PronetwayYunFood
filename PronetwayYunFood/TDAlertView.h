//
//  TDAlertView.h
//  AlertView
//
//  Created by 1217 on 2017/2/21.
//  Copyright © 2017年 等风起. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDAlertItem,TDAlertView;

@protocol TDAlertViewDelegate <NSObject>
@optional
- (void)alertView:(TDAlertView *)alertView didClickItemWithIndex:(NSInteger)itemIndex;
@end

@interface TDAlertView : UIView 

- (id)initWithTitle:(id)title /** NSString or NSAttributedString */
            message:(id)message /** NSString or NSAttributedString */
              items:(NSArray <TDAlertItem *>*)items
           delegate:(id <TDAlertViewDelegate>)delegate;

- (void)show;

@property (nonatomic ,weak) id <TDAlertViewDelegate>delegate;

@property (nonatomic, copy) dispatch_block_t OKBlock;
@property (nonatomic, copy) dispatch_block_t CancelBlock;


/** -- 回调可能会用到的 */
@property (nonatomic ,strong ,readonly) id title;
@property (nonatomic ,strong ,readonly) id message;
@property (nonatomic ,strong ,readonly) NSArray <TDAlertItem *>*items;
/** -- ------------- */

@property (nonatomic ,assign) BOOL hideWhenTouchBackground; // 点击弹框以外的区域时移除掉alertView 默认YES
@property (nonatomic ,assign) BOOL translucent; // 设置弹框轻微透明效果 默认YES

/**
 给弹框设置一张背景图片

 @param backgroundImage 要设置的UIImage对象
 @param alpha           透明度
 */
- (void)setBackgroundImage:(UIImage *)backgroundImage alpha:(CGFloat)alpha;


/** ------------------------------------- */
/** - 有关布局的一些设置 可能有些情况需要轻微调整 - */
/** ------------------------------------- */
@property (nonatomic ,assign) CGFloat optionsRowHeight; // 选项的高度 默认44
@property (nonatomic ,assign) CGFloat alertWidth; // 弹窗宽度 默认288
@property (nonatomic ,assign) UIEdgeInsets edgeInsets;

// 决定选项的布局方式
@property (nonatomic ,assign) NSInteger verticalMaxOptionCount; // 默认 5
@property (nonatomic ,assign) NSInteger horizontalMaxOptionCount; // 默认 2
/** ------------------------------------- */
/** ------------------------------------- */

@end


@interface TDAlertItem : NSObject

- (id)initWithTitle:(NSString *)title;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) UIColor *titleColor;
@property (nonatomic ,strong) UIColor *backgroundColor;
@property (nonatomic ,strong) UIColor *selectedBackgroundColor; // highlighted background color
@property (nonatomic ,strong) UIFont *font;
@end


