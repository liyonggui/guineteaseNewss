//
//  YGNews.h
//  网易新闻
//
//  Created by liyonggui on 16/4/16.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGNews : NSObject

///  标题
@property (nonatomic, copy) NSString *title;
///  图片
@property (nonatomic, copy) NSString *imgsrc;
///  跟贴数
@property (nonatomic, copy) NSNumber *replyCount;
///  新闻摘要
@property (nonatomic, copy) NSString *digest;
///  多图
@property (nonatomic, strong) NSArray *imgextra;
///  大图显示标志
@property (nonatomic, assign) BOOL imgType;

+ (instancetype)newsWithDict:(NSDictionary *)dict;

///  加载新闻数组
///
///  @param success 成功回调
///  @param failed  失败回调
+ (void)loadNewsDataWithURLString:(NSString *)urlString Success:(void (^)(NSArray *news))success failed:(void (^)(NSError *error))failed;

@end
