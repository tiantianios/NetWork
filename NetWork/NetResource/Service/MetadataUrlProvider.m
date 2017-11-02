//
//  MetadataUrlProvider.m
//  NetWork
//
//  Created by tianxiuping on 2017/11/1.
//  Copyright © 2017年 TXP. All rights reserved.

#import "MetadataUrlProvider.h"

@implementation MetadataUrlProvider

- (NSString *)urlForUrlID:(NSString *)urlID
{
    return [_mappings objectForKey:urlID];
}

@end
