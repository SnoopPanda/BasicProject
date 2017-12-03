//
//  SPLaunchManager.h
//  BasicProject
//
//  Created by WangJie on 2017/12/3.
//  Copyright © 2017年 SnoopPanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLaunchManager : NSObject

+ (instancetype)manager;
- (void)launchInWindow:(UIWindow *)window;

@end
