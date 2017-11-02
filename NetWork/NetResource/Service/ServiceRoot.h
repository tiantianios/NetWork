//
//  ServiceRoot.h
//  NetWork
//
//  Created by tianxiuping on 2017/11/1.
//  Copyright © 2017年 TXP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceMethod.h"

@interface ServiceRoot : NSObject

+ (ServiceMethod *)findMethod:(NSString *)methodName;
+ (NSString *)getHostURLWithName:(NSString *)name;

@end
