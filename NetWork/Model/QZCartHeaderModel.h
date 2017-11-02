//
//  QZCartHeaderModel.h
//  搭搭手
//
//  Created by nieguizhi on 16/5/27.
//  Copyright © 2016年 nieguizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QZCartCellModel.h"
@interface QZCartHeaderModel : NSObject
//头部 选中状态
@property (nonatomic, assign) NSInteger headClickState;

@property (nonatomic,strong)NSMutableArray <QZCartCellModel *> *goods_list;
//ID
@property (nonatomic, copy)  NSString *store_id;
//
@property (nonatomic, copy)  NSString *store_name;

@end
