//
//  YGChannel.m
//  网易新闻
//
//  Created by liyonggui on 16/4/17.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import "YGChannel.h"

@implementation YGChannel


+ (instancetype)channelWithDict:(NSDictionary *)dict
{

    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];

    return obj;
}

- (void)setTid:(NSString *)tid
{
    _tid = [tid copy];
    self.URLString = [NSString stringWithFormat:@"/nc/article/headline/%@/0-20.html",tid];
}

///  防止报错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

///  返回所有模型数组
+ (NSArray *)channels
{
    // json文件全路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    // 获得二进制数据
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    // 转成字典
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    // 获得key
    NSString *rootKey = dic.keyEnumerator.nextObject;
    // 获得数组
    NSArray *arr = dic[rootKey];

    // 创建模型数组
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
    // 遍历数组
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {

        // 字典转模型
        [arrM addObject:[YGChannel channelWithDict:obj]];
        
    }];
    
    arrM = [arrM sortedArrayUsingComparator:^NSComparisonResult(YGChannel *obj1, YGChannel *obj2) {
        
        return [obj1.tid compare:obj2.tid];
    }].copy;

    return arrM;
}

@end
