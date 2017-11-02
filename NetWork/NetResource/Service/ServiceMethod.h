//
//  ServiceMethod.h
//  NetWork
//
//  Created by tianxiuping on 2017/11/1.
//  Copyright © 2017年 TXP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceMethod : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *method;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *parameters;
@property (nonatomic) BOOL showErrorMessage;
@property (nonatomic) int timeout;
@property (nonatomic,strong) NSString *returnType;
@property (nonatomic,strong) NSString *timeoutMessage;
@property (nonatomic,strong) NSString *fallbackMessage;
@property (nonatomic) BOOL isCookieEnabled;

@end
