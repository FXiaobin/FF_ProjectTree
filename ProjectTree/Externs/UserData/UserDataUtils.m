//
//  UserDataUtils.m
//  UIViewHelper
//
//  Created by macmin on 16/4/10.
//  Copyright © 2016年 caidaola. All rights reserved.
//

#import "UserDataUtils.h"

#define Login_UserInfo_Data         @"login_userInfo_data"
/// 需要配置下面的宏定义与登录信息的key字符串相对应
#define Login_User_ID               @"user_id"
#define Login_User_Name             @"username"
#define Login_User_Password         @"password"
#define Login_user_token            @"userToken"

@implementation UserDataUtils

+ (UserDataUtils *)shareUserDataUtils{
    
    static UserDataUtils *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

+ (BOOL)isLogin{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:Login_UserInfo_Data];
    NSDictionary *userInfoDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return userInfoDic.count > 0 ? YES : NO;
}

- (BOOL)isLogin{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:Login_UserInfo_Data];
    NSDictionary *userInfoDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return userInfoDic.count > 0 ? YES : NO;
}

#pragma mark ---- 用户所用登录信息
+ (void)saveUserDataWithUserInofDic:(NSDictionary *)uersInfo{
    if (uersInfo == nil) {
        return;
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *userInfoData = [NSKeyedArchiver archivedDataWithRootObject:uersInfo];
    [ud setObject:userInfoData forKey:Login_UserInfo_Data];
    [ud synchronize];
}

+ (NSDictionary *)getUserInfoData{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *userData = [ud objectForKey:Login_UserInfo_Data];
    NSDictionary *infoDic = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    return infoDic;
}

- (NSDictionary *)getUserInfoDic{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *userData = [ud objectForKey:Login_UserInfo_Data];
    NSDictionary *infoDic = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    return infoDic;
}

+ (void)clearUserInfoData{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Login_UserInfo_Data];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getUseToken{
    NSDictionary *userInfo = [self getUserInfoData];
    NSString *userToken = userInfo[Login_user_token];
    
    return userToken;
}

-(NSString *)userToken{
    NSDictionary *userInfo = [self getUserInfoDic];
    NSString *userToken = userInfo[Login_user_token];
    
    return userToken;
}

#pragma mark ----  用户ID
-(NSString *)userID{
    NSDictionary *userInfoDic = [self getUserInfoDic];
    NSString *userID = userInfoDic[Login_User_ID];
    
    return userID;
}

+ (NSString *)getUserID{
    NSDictionary *userInfoDic = [self getUserInfoData];
    NSString *userID = userInfoDic[Login_User_ID];
    
    return userID;
}

+ (void)clearUserID{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Login_User_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark ---- 用户名
- (NSString *)userName{
    NSDictionary *userInfoDic = [self getUserInfoDic];
    NSString *userName = userInfoDic[Login_User_Name];
  
    return userName;
}

+ (NSString *)getUserName{
    NSDictionary *userInfoDic = [self getUserInfoData];
    NSString *userName = userInfoDic[Login_User_Name];

    return userName;
}

+ (void)clearUserName{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Login_User_Name];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark ---- 用户密码
-(NSString *)userPassword{
    NSDictionary *userInfoDic = [self getUserInfoDic];
    NSString *userPwd = userInfoDic[Login_User_Password];
    
    return userPwd;
}

+ (NSString *)getUserPassword{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *userPwdData = [ud objectForKey:Login_User_Password];
    NSString *userPwd = [NSKeyedUnarchiver unarchiveObjectWithData:userPwdData];
    
    return userPwd;
}

+ (void)clearUserPassword{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Login_User_Password];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
