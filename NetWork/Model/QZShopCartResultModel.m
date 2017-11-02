//
//  QZShopCartResultModel.m
//  搭搭手
//
//  Created by nieguizhi on 16/5/29.
//  Copyright © 2016年 nieguizhi. All rights reserved.
//

#import "QZShopCartResultModel.h"

@implementation QZShopCartResultModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"cart_list" : [QZCartHeaderModel class]};
}


@end
