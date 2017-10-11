//
//  NetTools.m
//  coc
//
//  Created by fanxiaobin on 2017/3/24.
//  Copyright © 2017年 liwei. All rights reserved.
//

#import "NetTools.h"
#import <AFNetworking/AFNetworking.h>

@implementation NetTools

+ (NetTools *)manager{
    static NetTools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[NetTools alloc] init];
    });
    return tools;
}

- (void)networkReachabilityMonitoring{
    __block BOOL hasNet = YES;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            hasNet = NO;
            //NSLog(@"--- 没有网络 ----");
        }else{
            hasNet = YES;
            //NSLog(@"--- has有网络 ----");
        }
        
        self.noNetBlock(hasNet);
        
    }];
    
    [manager startMonitoring];
}

- (void)networkReachabilityMonitoringBlock:(void (^) (BOOL isNet))block{
    
    __block BOOL hasNet = YES;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            hasNet = NO;
            //NSLog(@"--- 没有网络 ----");
        }else{
            hasNet = YES;
            //NSLog(@"--- has有网络 ----");
        }
        
        block(hasNet);
      
    }];
    
    [manager startMonitoring];
}


-(void)POST:(NSString *)urlString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(id))failure noNet:(void (^)(BOOL))noNet{
    
    [self networkReachabilityMonitoring];
    _noNetBlock = noNet;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15.0;
    NSSet *set = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",
                  @"application/json;charset=UTF-8", @"application/x-www-form-urlencoded", nil];
    manager.responseSerializer.acceptableContentTypes = set;
    
    
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


-(void)GET:(NSString *)urlString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(id))failure noNet:(void (^)(BOOL))noNet{
 
    [self networkReachabilityMonitoring];
    _noNetBlock = noNet;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15.0;
    
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
