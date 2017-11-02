//
//  ViewController.m
//  NetWork
//
//  Created by tianxiuping on 2017/11/1.
//  Copyright © 2017年 TXP. All rights reserved.


#import "ViewController.h"
#import "Request.h"
#import "QZShopCartResultModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setRequest];
}

- (void)setRequest{
    

    [[Request sharedClient] requestWithName:@"参数名称" withParameters:nil successCallBack:^(QZShopCartResultModel *objc) {
        
        
        
    } failCallback:^(NSString *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
