//
//  QZShopCartResultModel.h
//  搭搭手
//
//  Created by nieguizhi on 16/5/29.
//  Copyright © 2016年 nieguizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QZCartHeaderModel.h"
@interface QZShopCartResultModel : NSObject

@property (nonatomic, copy) NSString *order_type;
@property (nonatomic, copy) NSString *goods_freight;
@property (nonatomic, copy) NSString *sum;
@property (nonatomic, strong) NSMutableArray<QZCartHeaderModel *> *cart_list;

@end
