//
//  YGNetworkTools.h
//  网易新闻
//
//  Created by liyonggui on 16/4/13.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

@interface YGNetworkTools : AFHTTPSessionManager

+ (instancetype)sharedNetworkTool;

@end
