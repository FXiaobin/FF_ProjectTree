//
//  NSString+TCExtensions.m
//  TCHelpers
//
//  Created by tao_yingjun on 14-2-12.
//  Copyright (c) 2014年 tao_yingjun. All rights reserved.
//

#import "NSString+TCExtensions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (TCExtensions)


- (NSString *)thumbnailString {
    NSString *string = self;
    if (![string isUrl] && ![string hasPrefix:@"http"]) {
        string = [SEVERY_API stringByAppendingString:string];
    }
    
    if (![string hasPrefix:SEVERY_API]) {
        return string;
    }
    
    if ([string hasSuffix:@".jpg"] || [string hasSuffix:@".png"] || [string hasSuffix:@".jpeg"]) {
        return string;
    }
    
    string = [string stringByAppendingString:@"-thumb"];
    return string;
}

- (CGSize)sizeWithAttributes:(NSDictionary *)attrs limitSize:(CGSize)size {
    CGSize retSize = [self boundingRectWithSize:size
                                          options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attrs
                                          context:nil].size;
    
    return retSize;
}

- (NSString *)base64Encoding {
    NSData *stringData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [stringData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64String;
}

- (NSString *)base64Decoding {
    NSData *dataFromString = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *string = [[NSString alloc] initWithData:dataFromString encoding:NSUTF8StringEncoding];
    
    return string;
}

- (NSString *)trimmingString{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isHttp{
    if ([self hasPrefix:@"http"] || [self hasPrefix:@"https"]) {
        return YES;
    }
    return NO;
}

- (BOOL)isEmpty {
    if (self == nil) {
        return YES;
    }
    NSString *string = [self trimmingString];
    if ([string isEqualToString:@""] || string == nil) {
        return YES;
    }
    
    return NO;
}

-(BOOL) isNormal{
    NSString *regex = @"([^%&',;=!~?$]+)";
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	
	return [pred evaluateWithObject:self];
}

- (BOOL)isValidateNumber{
    NSString* regex = @"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [numberPre evaluateWithObject:self];
}

- (BOOL)isUserName{
	NSString *		regex = @"(^[A-Za-z0-9]{3,12}$)";
	NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	
	return [pred evaluateWithObject:self];
}

- (BOOL)isChineseUserName{
	NSString *		regex = @"(^[A-Za-z0-9\u4e00-\u9fa5]{3,12}$)";
	NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	
	return [pred evaluateWithObject:self];
}

- (BOOL)isUserPassword{
	NSString *		regex = @"(^[A-Za-z0-9]{6,20}$)";
	NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	
	return [pred evaluateWithObject:self];
}


- (BOOL)isEmail{
	
    NSString *emailRegEx =
	@"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
	@"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
	@"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
	@"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
	@"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
	@"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
	@"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
	
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

- (BOOL)isUrl{
    NSString *		regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
	NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	
	return [pred evaluateWithObject:self];
}

- (BOOL)isIPAddress{
	NSArray *			components = [self componentsSeparatedByString:@"."];
	NSCharacterSet *	invalidCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
	
	if ( [components count] == 4 ){
        
		NSString *part1 = [components objectAtIndex:0];
		NSString *part2 = [components objectAtIndex:1];
		NSString *part3 = [components objectAtIndex:2];
		NSString *part4 = [components objectAtIndex:3];
		
		if ( [part1 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part2 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part3 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part4 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound )
		{
			if ( [part1 intValue] < 255 &&
                [part2 intValue] < 255 &&
                [part3 intValue] < 255 &&
                [part4 intValue] < 255 )
			{
				return YES;
			}
		}
	}
	
	return NO;
}

- (BOOL)isTelephone{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return  [regextestmobile evaluateWithObject:self]   ||
    [regextestphs evaluateWithObject:self]      ||
    [regextestct evaluateWithObject:self]       ||
    [regextestcu evaluateWithObject:self]       ||
    [regextestcm evaluateWithObject:self];
}

//判断是否都是数字
-(BOOL)isNumber
{
    NSString *condition = @"^[0-9]*$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",condition];
    return [predicate evaluateWithObject:self];
}

//只能输入由26个英文字母组成的字符串
-(BOOL)isLetter
{
    NSString *condition = @"^[A-Za-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",condition];
    return [predicate evaluateWithObject:self];
}

//只能输入由数字和26个英文字母组成的字符串
-(BOOL)isHaveSpecialCharacter
{
    NSString *condition = @"^[A-Za-z0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",condition];
    return [predicate evaluateWithObject:self];
}


//只能输入汉字
-(BOOL)isChinese
{
    NSString *condition = @"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",condition];
    return [predicate evaluateWithObject:self];
}

//手机号码验证
-(BOOL)isMobilePhone
{
    NSString *condition = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",condition];
    return [predicate evaluateWithObject:self];
}

//验证身份证号（15位或18位数字）
-(BOOL)isCardID{
    if ((self.length != 15) || (self.length != 18)) {
        return NO;
    }
    NSString *condition = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",condition];
    return [identityCardPredicate evaluateWithObject:self];
}

//密码验证
-(BOOL)isPassword{
    NSString *condition =@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *prediction = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",condition];
    
    return [prediction evaluateWithObject:self];
}

//银行卡验证
-(BOOL)isBankCard
{
    if (self.length < 16) {
        return NO;
    }
    
    NSInteger oddsum = 0;     //奇数求和
    NSInteger evensum = 0;    //偶数求和
    NSInteger allsum = 0;
    NSInteger cardNoLength = (NSInteger)[self length];
    // 取了最后一位数
    NSInteger lastNum = [[self substringFromIndex:cardNoLength-1] intValue];
    //测试的是除了最后一位数外的其他数字
    NSString *bankCard = [self substringToIndex:cardNoLength - 1];
    for (NSInteger i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [bankCard substringWithRange:NSMakeRange(i-1, 1)];
        NSInteger tmpVal = [tmpString integerValue];
        if (cardNoLength % 2 ==1 ) {//卡号位数为奇数
            if((i % 2) == 0){//偶数位置
                
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{//奇数位置
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

//车牌号验证
-(BOOL)isCarNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:self];
}

//是否包含有空格
-(BOOL)isHaveSpace
{
    NSRange _range = [self rangeOfString:@" "];
    if (_range.location == NSNotFound) {
        //        有空格
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)hasString:(NSString*)substring{
	return !([self rangeOfString:substring].location == NSNotFound);
}

- (NSString *)MD5{
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (uint32_t)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for (i=0;i<CC_MD5_DIGEST_LENGTH;i++) {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

- (NSString*)formattedPhoneNumberWithLastCharacterRemoved:(BOOL)deleteLastChar{
	if(self.length<1) return @"";
	
	NSError *error = NULL;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\s-\\(\\)]" options:NSRegularExpressionCaseInsensitive error:&error];
	NSString *digits = [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
	
	
	// should we delete the last digit?
	if(deleteLastChar)
		digits = [digits substringToIndex:digits.length - 1];
    
	
	// 123 456 7890
	// format the number.. if it's less then 7 digits.. then use this regex.
	BOOL leadingOne = [digits hasPrefix:@"1"];
    
	if((digits.length > 11 && leadingOne) || (digits.length > 10 && !leadingOne))
		return digits;
	
	NSStringCompareOptions opt = NSRegularExpressionSearch;
	NSRange range = NSMakeRange(0, digits.length);
	
	NSString *occurence, *replace;
    
	
	if(digits.length < 5 && leadingOne){
		occurence = @"(\\d{1})(\\d+)";
		replace = @"$1 ($2)";
		
	}else if(digits.length < 8 && leadingOne){
		occurence = @"(\\d{1})(\\d{3})(\\d+)";
		replace = @"$1 ($2) $3";
		
	}else if(digits.length<7){
		occurence = @"(\\d{3})(\\d+)";
		replace = @"($1) $2";
		
	}else if(digits.length > 6 && leadingOne){
		occurence = @"(\\d{1})(\\d{3})(\\d{3})(\\d+)";
		replace = @"$1 ($2) $3-$4";
		
	}else{
		occurence = @"(\\d{3})(\\d{3})(\\d+)";
		replace = @"($1) $2-$3";
	}
    
	digits = [digits stringByReplacingOccurrencesOfString:occurence withString:replace options:opt range:range];
    
	return digits;
}

- (NSAttributedString *)convertToHTMLAttibuteString {
    NSError *error;
    NSAttributedString *attributeString = [[NSAttributedString alloc] initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:&error];
    
    attributeString = [[NSAttributedString alloc] initWithData:[attributeString.string dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:&error];
    
    
    return attributeString;
}

- (NSAttributedString *)characterSpace:(long)space{
    
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt32Type,&space);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSKernAttributeName : (id)CFBridgingRelease(num)}];
    
    return attributedString;
}

@end

