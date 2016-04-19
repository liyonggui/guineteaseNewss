//
//  YGNews.m
//  网易新闻
//
//  Created by liyonggui on 16/4/16.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import "YGNews.h"

#import "YGNetworkTools.h"

@implementation YGNews

+ (instancetype)newsWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

///  防止报错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

///  加载新闻数组
///
///  @param success 成功回调
///  @param failed  失败回调
+ (void)loadNewsDataWithURLString:(NSString *)urlString Success:(void (^)(NSArray *news))success failed:(void (^)(NSError *error))failed
{
    // 断言
    NSAssert(success != nil, @"成功回调不能为空");
    
    [[YGNetworkTools sharedNetworkTool] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        // 获得字典第一个key
        NSString *rootKey = responseObject.keyEnumerator.nextObject;
        
        // 根据rootKey获得数组
        NSArray *array = responseObject[rootKey];
        
        // 创建模型数组
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:array.count];
        
        // 遍历数组
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            [arrM addObject:[YGNews newsWithDict:obj]];
            
        }];
        
        // 模型数组传给回调方法
        success(arrM.copy);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed)
        {
            failed(error);
        }
    }];
    
    
}











@end
