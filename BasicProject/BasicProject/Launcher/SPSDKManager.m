//
//  SPSDKManager.m
//  BasicProject
//
//  Created by WangJie on 2017/12/3.
//  Copyright © 2017年 SnoopPanda. All rights reserved.
//

#import "SPSDKManager.h"
#import "NXVLogFormatter.h"
#import "Harpy.h"

@interface SPSDKManager()<HarpyDelegate>
@end

@implementation SPSDKManager

+ (instancetype)manager {
    static SPSDKManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)launchInWindow:(UIWindow *)window {
    
    // DDLog - 日志系统
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setLogFormatter:[NXVLogFormatter new]];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    DDLogDebug(@"fileLogger filePath: %@", fileLogger.currentLogFileInfo.filePath);
    
    // Harpy - 自动更新
    Harpy *harpy = [[Harpy alloc] init];
    harpy.presentingViewController = window.rootViewController;
    harpy.delegate = self;
    harpy.appName = @"xxx";
    harpy.alertType = HarpyAlertTypeForce;
    harpy.countryCode = @"CN";
    harpy.forceLanguageLocalization = HarpyLanguageChineseSimplified;
    harpy.debugEnabled = true;
    [harpy checkVersion];
}

#pragma mark - HarpyDelegate
- (void)harpyDidShowUpdateDialog
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)harpyUserDidLaunchAppStore
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)harpyUserDidSkipVersion
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)harpyUserDidCancel
{
    NSLog(@"%s", __FUNCTION__);
}

@end
