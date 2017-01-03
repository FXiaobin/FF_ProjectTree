//
//  FXBNetManager.h
//  ProjectTree
//
//  Created by lovepinyao on 16/8/24.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "SVProgressHUD.h"

//成功或失败的回调
typedef void(^completeBlock)(id responseObject, NSError *error);
typedef void(^progressBlock)(CGFloat progress);



@interface FXBNetManager : NSObject

+ (FXBNetManager *)manager;


+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(completeBlock)successBlock failure:(completeBlock)failureBlock;

+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(completeBlock)successBlock failure:(completeBlock)failureBlock;

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters progress:(progressBlock)progressBlock success:(completeBlock)successBlock failure:(completeBlock)failureBlock;

+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters progress:(progressBlock)progressBlock success:(completeBlock)successBlock failure:(completeBlock)failureBlock;


/**
 *  上传图片文件
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param images     图片数组
 *  @param name       文件对应服务器上的字段
 *  @param fileName   文件名
 *  @param mimeType   图片文件的类型,例:png、jpeg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)uploadWithURL:(NSString *)URL
                                  parameters:(NSDictionary *)parameters
                                      images:(NSArray<UIImage *> *)images
                                        name:(NSString *)name
                                    fileName:(NSString *)fileName
                                    mimeType:(NSString *)mimeType
                                    progress:(progressBlock)progress
                                     success:(completeBlock)success
                                     failure:(completeBlock)failure;

/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (__kindof NSURLSessionTask *)downloadWithURL:(NSString *)URL
                                       fileDir:(NSString *)fileDir
                                      progress:(progressBlock)progress
                                       success:(void(^)(NSString *filePath))success
                                       failure:(completeBlock)failure;

@end
