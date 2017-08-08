//
//  Alert.h
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/6/14.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alert : NSObject<TDAlertViewDelegate>

@property (strong, nonatomic)TDAlertView *alert;
-(void)alert:(NSString*)content;


@end
