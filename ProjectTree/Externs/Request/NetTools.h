//
//  NetTools.h
//  coc
//
//  Created by fanxiaobin on 2017/3/24.
//  Copyright © 2017年 liwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetTools : NSObject

+ (NetTools *)manager;

/// 网络监测
@property (nonatomic,copy) void (^noNetBlock) (BOOL isNet);

///放在每个请求中 来监测当前请求时是否有网络
- (void)networkReachabilityMonitoring;

///单独放在BaseViewController中来监测进入每个页面时是否有网络 (可添加一个BOOL属性来保存)
- (void)networkReachabilityMonitoringBlock:(void (^) (BOOL isNet))block;

/// POST
-(void)POST:(NSString *)urlString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(id error))failure noNet:(void(^)(BOOL hasNet))noNet;

/// GET
-(void)GET:(NSString *)urlString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(id error))failure noNet:(void(^)(BOOL hasNet))noNet;


@end
