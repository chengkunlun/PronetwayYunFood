//
//  explainView.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/7/25.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "explainView.h"

@implementation explainView

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text
{
    self.framee = frame;
    self = [super initWithFrame:frame];
    if (self) {
        [self addView:text];
    }
    return self;
}

-(void)addView:(NSString *)text{
    
    CGFloat autoH = [StringUtil heightForString:text fontSize:13 andWidth:self.framee.size.width];
    _explainlab = [[UILabel alloc]init];
    _explainlab.frame = CGRectMake(0, 0, self.framee.size.width, autoH);
    _explainlab.numberOfLines = 0;
    _explainlab.font = kFont(13);
    _explainlab.text = text;
    _explainlab.textColor = rgba(181, 181, 181, 0.9);
    self.frame = CGRectMake(self.framee.origin.x, self.framee.origin.y, self.framee.size.width, autoH);
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    _explainlab.attributedText = attributedString;
    [_explainlab sizeToFit];

    [self addSubview:_explainlab];

}


@end
