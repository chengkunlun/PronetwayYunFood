//
//  AppDelegate.m
//  PronetwayYunFood
//
//  Created by ckl@pmm on 2017/5/5.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "AppDelegate.h"
#import "YunBaseViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [kNotificationCenter addObserver:self selector:@selector(gotomain) name:@"gotomain" object:nil];
    
    if ([[UserDefaults objectForKeyStr:kloginStatuekey] isEqualToString:@"YES"]) {
        
         YunBaseViewController *tabbar = [[YunBaseViewController alloc] init];
         self.window.rootViewController = tabbar;
        
    }else {
        LoginAndRegisterViewController *logVC = [LoginAndRegisterViewController new];
        self.window.rootViewController = logVC;

    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    // Override point for customization after application launch.
    return YES;
}

-(void)gotomain {

//    self.loginVC  = [LoginAndRegisterViewController new];
//    
//    self.loginVC.view.transform = CGAffineTransformMakeScale(1, 1);
//    self.loginVC.view.alpha = 1;
//    [UIView animateWithDuration:1.5f animations:^{
//        self.loginVC.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
//        self.loginVC.view.alpha = 0;
//    } completion:^(BOOL finished) {
//        [self.loginVC.view removeFromSuperview];
//    }];
  
    
     YunBaseViewController *tabbar = [[YunBaseViewController alloc] init];
     self.window.rootViewController = tabbar;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    DLog(@"app将要进入后台");
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    DLog(@"app将要退出");
    //.系统设置界面保存的开关状态置为NO,停止后台进程
    [UserDefaults setObjectleForStr:@"NO" key:ksavebackground];
    
}


@end
