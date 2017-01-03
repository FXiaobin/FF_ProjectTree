//
//  CommonDefine.h
//  ProjectTree
//
//  Created by lovepinyao on 16/8/27.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h


//非常实用的打印，包括打印的类名——方法名－行数－打印的内容
#ifdef DEBUG
#define DDLogDebug(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DDLogDebug(...)
#endif


//非常实用的打印，包括打印的类名——方法名－行数－打印的内容
#ifdef DEBUG
#define DDLog(...) NSLog(@"%s [第%d行] %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define DDLog(...)
#endif


//角度转弧度
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

//对象循环引用弱化
#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//获取系统时间戳
#define getCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]

//颜色
#define MAIN_FONT(fontSize) [UIFont fontWithName:@"PingFang SC" size:fontSize]
#define BG_COLOR            [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]
#define MAIN_COLOR          RGB(251.0,83.0,67.0)
#define CONTENT_COLOR       HexRGB(0x333333)
#define TITLE_COLOR         HexRGB(0x666666)
#define CY_COLOR        RGB(80.0,200.0,224.0)

//rgb色值
#define RGB(r,g,b)          [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define RGBA(r,g,b,a)       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//十六进制色值
#define HexRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#pragma mark --- 系统相关
//状态栏高度
#define STATUS_BAR_HEIGHT 20
//NavBar高度
#define NAVIGATION_BAR_HEIGHT 44
//状态栏 ＋ 导航栏 高度 64
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))

#define SCREEN_RECT         ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH        ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)
#define CONTENT_HEIGHT      (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)
#define SCREEN_RATE         (SCREEN_WIDTH / 375.0)

//屏幕分辨率
#define SCREEN_RESOLUTION   (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))
//竖屏
#define IsPortrait ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)


//判断是否 Retina屏、设备是否iPhone 5、是否是iPad
#define Is_Retina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 判断是否为iPhone */
#define Is_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/** 判断是否是iPad */
#define Is_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 判断是否为iPod */
#define Is_iPod ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 分辨率375x667，像素750x1334，@2x */
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x */
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


//文件目录
#define kPathHome            NSHomeDirectory()
#define kPathTemp            NSTemporaryDirectory()
#define kPathDocument        [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kPathCache           [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kPathSearch          [kPathDocument stringByAppendingPathComponent:@"Search.plist"]


/** 获取系统版本 */
#define iOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DEVICE_UUID [UIDevice currentDevice].identifierForVendor.UUIDString

/*  APP信息   */
#define APP_INFODIC [[NSBundle mainBundle] infoDictionary]
#define APP_NAME    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define APP_BILUD   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


/** 是否为iOS6 */
#define iOS6 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) ? YES : NO)

/** 是否为iOS7 */
#define iOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)

/** 是否为iOS8 */
#define iOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO)

/** 是否为iOS9 */
#define iOS9 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? YES : NO)



#pragma mark --- 工具
/*  数据本地持久化 */
#define kUserDefaults                 [NSUserDefaults standardUserDefaults]
#define kUserDefaultsGet(key)         [kUserDefaults objectForKey:key]
#define kUserDefaultsSave(obj,key)    [kUserDefaults setObject:obj forKey:key];     [kUserDefaults synchronize];
#define kUserDefaultsRemove(key)      [kUserDefaults removeObjectForKey:key];       [kUserDefaults synchronize];

#define kShowAlert(message)    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"cancel" otherButtonTitles: @"OK"];[alert show];




#endif /* CommonDefine_h */
