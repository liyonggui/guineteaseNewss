//
//  YGChannel.h
//  网易新闻
//
//  Created by liyonggui on 16/4/17.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGChannel : NSObject

///  频道名称
@property (nonatomic, copy) NSString *tname;
///  频道id
@property (nonatomic, copy) NSString *tid;

///  频道新闻数据对应的URL
@property (nonatomic, copy) NSString *URLString;

+ (instancetype)channelWithDict:(NSDictionary *)dict;

///  返回所有模型数组
+ (NSArray *)channels;

@end
