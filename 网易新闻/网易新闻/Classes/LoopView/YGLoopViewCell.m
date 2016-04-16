//
//  YGLoopViewCell.m
//  网易新闻
//
//  Created by liyonggui on 16/4/15.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import "YGLoopViewCell.h"

#import <UIImageView+WebCache.h>

@interface YGLoopViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@end


@implementation YGLoopViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.iconView = [[UIImageView alloc] init];
        
        [self addSubview:self.iconView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.frame = self.bounds;
    
}

- (void)setUrl:(NSURL *)url
{
    _url = url;
    
    [self.iconView sd_setImageWithURL:url];
    
    
}

@end
