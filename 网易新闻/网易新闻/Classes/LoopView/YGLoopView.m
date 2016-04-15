//
//  YGLoopView.m
//  网易新闻
//
//  Created by liyonggui on 16/4/14.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import "YGLoopView.h"

#import "YGFlowLayout.h"

@interface YGLoopView ()



@end

@implementation YGLoopView


- (instancetype)initWithUrls:(NSArray <NSString *>*)urls title:(NSArray <NSString *>*)titles didSelected:(void (^)())selected
{
    if (self = [super init])
    {
        
        
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        [self setupChildControl];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super init])
    {
        [self setupChildControl];
    }
    return self;
}

///  添加子控件
- (void)setupChildControl
{
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[YGFlowLayout new]];
    
    
    
}








@end
