//
//  QZCartCellModel.h
//  搭搭手
//
//  Created by nieguizhi on 16/5/27.
//  Copyright © 2016年 nieguizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QZCartCellModel : NSObject
//数量
@property (nonatomic, assign) NSInteger goods_num;
//cell 选中状态
@property (nonatomic, assign) NSInteger cellClickState;

@property (nonatomic, assign) NSInteger section;
//价格
@property (nonatomic, copy) NSString *goods_price;
//券的价格
@property (nonatomic, copy) NSString *coupon_price;
//ID
@property (nonatomic, copy)  NSString *goods_id;

@property (nonatomic, copy)  NSString *cart_id;

@property (nonatomic, copy)  NSString *goods_name;

@property (nonatomic, copy)  NSString *goods_jingle;

@property (nonatomic, copy)  NSString *goods_image;

@property (nonatomic, copy)  NSString *is_spe;

@end
