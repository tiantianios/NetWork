//
//  MetadataUrlProvider.h
//  NetWork
//
//  Created by tianxiuping on 2017/11/1.
//  Copyright © 2017年 TXP. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol UrlProvider <NSObject>

- (NSString *)urlForUrlID:(NSString *)urlID;

@end

@interface MetadataUrlProvider : NSObject

@property (nonatomic,strong) NSDictionary *mappings;

- (NSString *)urlForUrlID:(NSString *)urlID;

@end
