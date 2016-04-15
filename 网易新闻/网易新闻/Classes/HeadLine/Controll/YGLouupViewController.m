//
//  YGLouupViewController.m
//  网易新闻
//
//  Created by liyonggui on 16/4/14.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import "YGLouupViewController.h"

#import "YGNetworkTools.h"
#import "YGHeadLine.h"

@interface YGLouupViewController ()

@end

@implementation YGLouupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [YGHeadLine headLineWithSuccess:^(NSArray *array) {
        
        
        
        
        
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}













@end
