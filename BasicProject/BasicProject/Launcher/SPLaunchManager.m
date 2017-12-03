//
//  SPLaunchManager.m
//  BasicProject
//
//  Created by WangJie on 2017/12/3.
//  Copyright © 2017年 SnoopPanda. All rights reserved.
//

#import "SPLaunchManager.h"

@implementation SPLaunchManager

+ (instancetype)manager {
    static SPLaunchManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
- (void)launchInWindow:(UIWindow *)window {
    
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.view.backgroundColor = [UIColor redColor];
    [window setRootViewController:tabBarVC];
    [window makeKeyAndVisible];
}

@end
