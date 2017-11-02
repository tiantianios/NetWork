//
//  QZCartHeaderModel.m
//  搭搭手
//
//  Created by nieguizhi on 16/5/27.
//  Copyright © 2016年 nieguizhi. All rights reserved.
//

#import "QZCartHeaderModel.h"

@implementation QZCartHeaderModel
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"goods_list" : [QZCartCellModel class]};
}
@end
