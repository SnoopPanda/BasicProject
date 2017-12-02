//
//  SPMacros.h
//  BasicProject
//
//  Created by WangJie on 2017/12/2.
//  Copyright © 2017年 SnoopPanda. All rights reserved.
//

#ifndef SPMacros_h
#define SPMacros_h

// Custom Macros

#pragma mark - 全局颜色配置
#define BACKGROUND_IMAGE                                           (__bridge id)[UIImage imageNamed:@"application_bg"].CGImage
#define UIColorFromRGB(rgbValue)                                  UIColorFromRGBA(rgbValue, 1.0)
#define UIColorFromRGBA(rgbValue, alphaValue)                     [UIColor colorWithRed : ((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green : ((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue : ((float)(rgbValue & 0xFF)) / 255.0 alpha : alphaValue]
#define UIColorWithRGB(red, gre, blue)                            [UIColor colorWithRed : ((float)red) / 255.0 green : ((float)gre) / 255.0 blue : ((float)blue) / 255.0 alpha : 1.0]

#pragma mark - UI 方法宏
#define SHOWSTATUS_SUCCESS(msg, inview)                           [SVProgressHUD showSuccessWithStatus : msg];
#define SHOWSTATUS_ERROR(msg, inview)                             [SVProgressHUD showErrorWithStatus : msg];
#define SHOWSTATUS_LOADING(msg, inview)                           [SVProgressHUD showWithStatus : msg];
#define SHOWSTATUS_CLEAR                                          [SVProgressHUD dismiss];

#define RGBACOLOR(r, g, b, a)                                     [UIColor colorWithRed : (r) / 255.f green : (g) /                                 255.f blue : (b) / 255.f alpha : (a)]

#ifndef RGB0X
#define RGB0X(rgbValue)                                           [UIColor colorWithRed : ((float)((rgbValue & 0xFF0000) >> 16)) / 255.f \
green : ((float)((rgbValue & 0xFF00) >> 8)) / 255.f                   \
blue : ((float)(rgbValue & 0xFF)) / 255.f alpha : 1.0f]

#endif

#define RGB0X1(rgbValue)                                          [UIColor colorWithRed : ((float)((rgbValue & 0xFF0000) >> 16)) / 255.f \
green : ((float)((rgbValue & 0xFF00) >> 8)) / 255.f                   \
blue : ((float)(rgbValue & 0xFF)) / 255.f alpha : 0.3f]

#pragma mark - iOS版本号
#define OS_VERSION                                                [[[UIDevice currentDevice] systemVersion] floatValue]

#pragma mark - OS版本号判断
#define SYSTEM_VERSION_EQUAL_TO(v)                                ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)                            ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)                ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                               ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)                   ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#pragma mark - App版本号
#define APP_VERSION                                               [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#pragma mark - 屏幕宽高
#define SCREEN_HEIGHT                                             [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                                              [UIScreen mainScreen].bounds.size.width
#define SCALE_5                                                   (SCREEN_WIDTH / 320)
#define SCALE_6                                                   (SCREEN_WIDTH / 375)
#define SCALE_6P                                                  (SCREEN_WIDTH / 414)

#pragma mark -
/**
 Synthsize a weak or strong reference.
 
 Example:
     @weakify(self)
     [self doSomething^{
         @strongify(self)
         if (!self) return;
         ...
     }];
 
 */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif




#endif /* SPMacros_h */
