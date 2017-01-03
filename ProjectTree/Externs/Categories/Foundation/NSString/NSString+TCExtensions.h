//
//  NSString+TCExtensions.h
//  TCHelpers
//
//  Created by tao_yingjun on 14-2-12.
//  Copyright (c) 2014年 tao_yingjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TCExtensions)


- (NSString *)thumbnailString;

//去除首尾空格和换行符
- (NSString *)trimmingString;

- (BOOL)isEmpty;
- (BOOL)isHttp;

//正则匹配
- (BOOL)isEmail;
- (BOOL)isNormal;
- (BOOL)isValidateNumber;
- (BOOL)isTelephone;
- (BOOL)isUserName;
- (BOOL)isChineseUserName;
- (BOOL)isUserPassword;
- (BOOL)isUrl;
- (BOOL)isIPAddress;

-(BOOL)isNumber;
-(BOOL)isLetter;
-(BOOL)isHaveSpecialCharacter;
-(BOOL)isChinese;
-(BOOL)isMobilePhone;
-(BOOL)isCardID;
-(BOOL)isPassword;
-(BOOL)isBankCard;
-(BOOL)isCarNo;
-(BOOL)isHaveSpace;

- (BOOL)hasString:(NSString*)substring;

- (NSString *)MD5;

- (NSString*)formattedPhoneNumberWithLastCharacterRemoved:(BOOL)deleteLastChar;

- (CGSize)sizeWithAttributes:(NSDictionary *)attrs limitSize:(CGSize)size;

- (NSString *)base64Encoding;
- (NSString *)base64Decoding;

- (NSAttributedString *)convertToHTMLAttibuteString;
//字间距
- (NSAttributedString *)characterSpace:(long)space;

@end


