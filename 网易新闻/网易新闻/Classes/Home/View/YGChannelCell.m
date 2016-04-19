//
//  YGChannelCell.m
//  网易新闻
//
//  Created by liyonggui on 16/4/19.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import "YGChannelCell.h"

#import "YGNewsViewController.h"

@interface YGChannelCell ()

//@property (nonatomic, strong) YGNewsViewController *newsVC;

@end

@implementation YGChannelCell

//- (void)awakeFromNib
//{
//    
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
//    
//    // 创建箭头指向的控制器
//    self.newsVC = sb.instantiateInitialViewController;
//    
//    [self addSubview:self.newsVC.view];
//    
//}

//- (void)setUrlString:(NSString *)urlString
//{
//    _urlString = urlString;
//    
//    self.newsVC.urlString = urlString;
//}

- (void)setNewsVC:(YGNewsViewController *)newsVC
{
    _newsVC = newsVC;
    
    [self addSubview:newsVC.view];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.newsVC.view.frame = self.bounds;
}


@end
