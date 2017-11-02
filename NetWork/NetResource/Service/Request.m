//
//  Request.m
//  NetWork
//
//  Created by tianxiuping on 2017/11/1.
//  Copyright © 2017年 TXP. All rights reserved.
//

#import "Request.h"
#import "ServiceRoot.h"
#import "AFHTTPSessionManager.h"
#import "ServiceMethod.h"
#import "YYModel.h"

#define kAPI_KEY @""
static AFHTTPSessionManager *manager = nil;

@implementation Request

+(instancetype)sharedClient
{
    static Request *r = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        r = [[Request alloc] init];
    });
    
    return r;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        manager = [AFHTTPSessionManager manager];
        AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
        serializer.timeoutInterval = 20;
        manager.requestSerializer = serializer;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    return self;
}

- (void)requestWithName:(NSString *)urlName withParameters:(NSMutableDictionary *)dict successCallBack:(void(^)(id))successCallback failCallback:(void(^)(NSString *))failCallback
{
    ServiceMethod *method = [ServiceRoot findMethod:urlName];
    
    manager.requestSerializer.timeoutInterval = method.timeout;
    
    if ([method.method isEqualToString:@"GET"])
    {
        [manager GET:method.url parameters:dict progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else if ([method.method isEqualToString:@"POST"])
    {
        NSMutableDictionary *parameters = [self creatPostParametersWithArray:dict andServiceMethod:method];
        
        [manager POST:method.url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            Class cla = NSClassFromString(method.returnType);

            id object = [cla new];
             [object yy_modelSetWithDictionary:responseObject];
            successCallback(object);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failCallback([NSString stringWithFormat:@"%@",error]);
        }];
    }
}

- (NSMutableDictionary *)creatPostParametersWithArray:(NSMutableDictionary *)dict andServiceMethod:(ServiceMethod *)method
{
   //配置系统参数
    NSMutableDictionary *apiParam = [[NSMutableDictionary alloc] initWithObjectsAndKeys:kAPI_KEY,@"key",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],@"version",nil];
    return apiParam;
}

- (void)downLoadFileWithURL:(NSString *)url successCallBack:(void(^)(id))successCallback failCallback:(void(^)(NSString *))failCallback
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) failCallback(error.description);
        successCallback(filePath.relativePath);
    }];
    [downloadTask resume];
}

@end
