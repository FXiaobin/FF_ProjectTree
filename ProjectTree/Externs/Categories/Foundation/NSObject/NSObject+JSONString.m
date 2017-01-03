//
//  NSObject+JSONString.m
//  PublicDrugComment-OC
//
//  Created by TaoYingjun on 16/1/25.
//  Copyright © 2016年 Shanghai Xuanyao Network Technology Co., Ltd. All rights reserved.
//

#import "NSObject+JSONString.h"

@implementation NSObject (JSONString)

- (NSString *)jsonString {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

-(id)objectForJsonString:(NSString *)jsonString{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"-- json字符串解析失败 ---");
        return nil;
    }
    return obj;
}

@end
