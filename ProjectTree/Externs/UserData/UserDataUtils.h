//
//  UserDataUtils.h
//  UIViewHelper
//
//  Created by macmin on 16/4/10.
//  Copyright © 2016年 caidaola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataUtils : NSObject


@property (nonatomic,copy, readonly) NSString *userID;

@property (nonatomic,copy, readonly) NSString *userName;

@property (nonatomic,copy, readonly) NSString *userPassword;

@property (nonatomic,copy, readonly) NSString *userToken;

@property (nonatomic,assign, readonly) BOOL isLogin;

///实例化单利对象
+ (UserDataUtils *)shareUserDataUtils;

///是否已登录
+ (BOOL)isLogin;

///用户登录所有数据
+ (void)saveUserDataWithUserInofDic:(NSDictionary *)uersInfo;

+ (NSDictionary *)getUserInfoData;

- (NSDictionary *)getUserInfoDic;

+ (void)clearUserInfoData;


///获取登录Token
+ (NSString *)getUseToken;


///用户ID
+ (NSString *)getUserID;


///用户名
+ (NSString *)getUserName;

+ (void)clearUserName;


///用户密码
+ (NSString *)getUserPassword;

+ (void)clearUserPassword;


@end
