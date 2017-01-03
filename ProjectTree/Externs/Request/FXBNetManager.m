//
//  FXBNetManager.m
//  ProjectTree
//
//  Created by lovepinyao on 16/8/24.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "FXBNetManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation FXBNetManager

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

+(FXBNetManager *)manager{
    FXBNetManager *manager = [[self alloc] init];
    return manager;
}

+ (void)initializeManager:(AFHTTPSessionManager *)manager{

    //设置请求参数的类型:JSON (AFJSONRequestSerializer,AFHTTPRequestSerializer)
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    //设置请求的超时时间
    manager.requestSerializer.timeoutInterval = 15.0f;
    //设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    //打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

+ (void)showHUD{
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setMinimumDismissTimeInterval:2.0];
    //设置前景色背景色需要将风格设置为自定义才起作用
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor purpleColor]];
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
}

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(completeBlock)successBlock failure:(completeBlock)failureBlock{
    
    [self showHUD];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];
    
    //[self initializeManager:manager];
   
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //[SVProgressHUD dismiss]; //这个放到外面来控制消失
        successBlock(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(nil, error);
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
    
}

+(void)POST:(NSString *)url parameters:(NSDictionary *)parameters progress:(progressBlock)progressBlock success:(completeBlock)successBlock failure:(completeBlock)failureBlock{
    
    [self showHUD];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        CGFloat progress = uploadProgress.completedUnitCount / uploadProgress.totalUnitCount * 1.0;
        progressBlock(progress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       //[SVProgressHUD dismiss]; //这个放到外面来控制消失
        successBlock(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(nil, error);
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];

}


+(void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(completeBlock)successBlock failure:(completeBlock)failureBlock{
    
    [self showHUD];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //[SVProgressHUD dismiss]; //这个放到外面来控制消失
        successBlock(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(nil, error);
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

+(void)GET:(NSString *)url parameters:(NSDictionary *)parameters progress:(progressBlock)progressBlock success:(completeBlock)successBlock failure:(completeBlock)failureBlock{
    
    [self showHUD];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        CGFloat progress = uploadProgress.completedUnitCount / uploadProgress.totalUnitCount * 1.0;
        progressBlock(progress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //[SVProgressHUD dismiss]; //这个放到外面来控制消失
        successBlock(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(nil, error);
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}


#pragma mark - 上传图片文件

+ (NSURLSessionTask *)uploadWithURL:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                             images:(NSArray<UIImage *> *)images
                               name:(NSString *)name
                           fileName:(NSString *)fileName
                           mimeType:(NSString *)mimeType
                           progress:(progressBlock)progressBlock
                            success:(completeBlock)successBlock
                            failure:(completeBlock)failureBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];
    return [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //压缩-添加-上传图片
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@%lu.%@",fileName,(unsigned long)idx,mimeType ? mimeType : @"jpeg"] mimeType:[NSString stringWithFormat:@"image/%@",mimeType ? mimeType : @"jpeg"]];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        CGFloat progress = uploadProgress.completedUnitCount / uploadProgress.totalUnitCount * 1.0;
        successBlock ? progressBlock(progress) : nil;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject, nil) : nil;
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock ? failureBlock(nil, error) : nil;
       
    }];
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(progressBlock)progressBlock
                              success:(void(^)(NSString *))success
                              failure:(completeBlock)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        CGFloat progress = downloadProgress.completedUnitCount / downloadProgress.totalUnitCount * 1.0;
        progressBlock ? progressBlock(progress) : nil;
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
        DDLogDebug(@"downloadDir = %@",downloadDir);
        
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if(failure && error) {failure(nil, error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    
    //开始下载
    [downloadTask resume];
    
    return downloadTask;
    
}


@end
