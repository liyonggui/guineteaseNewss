//
//  YGNetworkTools.m
//  网易新闻
//
//  Created by liyonggui on 16/4/13.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import "YGNetworkTools.h"

@implementation YGNetworkTools

+ (instancetype)sharedNetworkTool
{
    static YGNetworkTools *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // http://c.m.163.com/nc/ad/
        NSURL *basicUrl = [NSURL URLWithString:@"http://c.m.163.com/nc/ad/"];
        
        instance = [[self alloc] initWithBaseURL:basicUrl];
        
        
    });
    return instance;
}

@end
