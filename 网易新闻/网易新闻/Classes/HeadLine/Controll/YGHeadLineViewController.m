//
//  YGLouupViewController.m
//  网易新闻
//
//  Created by liyonggui on 16/4/14.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import "YGHeadLineViewController.h"

#import "YGNetworkTools.h"
#import "YGHeadLine.h"
#import "YGLoopView.h"

@interface YGHeadLineViewController ()

@end

@implementation YGHeadLineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [YGHeadLine headLineWithSuccess:^(NSArray *array) {

        NSArray *urls = [array valueForKeyPath:@"imgsrc"];
        NSArray *titles = [array valueForKeyPath:@"title"];
        
        YGLoopView *loopView = [[YGLoopView alloc] initWithUrls:urls title:titles didSelected:^{
            
        }];
        
        loopView.frame = self.view.frame;
        
        // 添加到父容器
        [self.view addSubview:loopView];
        
//        NSLog(@"%@",array);
        
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}













@end
