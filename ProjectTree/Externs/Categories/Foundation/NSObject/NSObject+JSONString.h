//
//  NSObject+JSONString.h
//  PublicDrugComment-OC
//
//  Created by TaoYingjun on 16/1/25.
//  Copyright © 2016年 Shanghai Xuanyao Network Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSONString)

- (NSString *)jsonString;

-(id)objectForJsonString:(NSString *)jsonString;

@end
