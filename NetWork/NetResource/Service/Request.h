//
//  Request.h
//  NetWork
//
//  Created by tianxiuping on 2017/11/1.
//  Copyright © 2017年 TXP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject

+ (instancetype)sharedClient;

- (void)requestWithName:(NSString *)urlName withParameters:(NSMutableDictionary *)dict successCallBack:(void(^)(id))successCallback failCallback:(void(^)(NSString *))failCallback;
- (void)downLoadFileWithURL:(NSString *)url successCallBack:(void(^)(id))successCallback failCallback:(void(^)(NSString *))failCallback;

@end
