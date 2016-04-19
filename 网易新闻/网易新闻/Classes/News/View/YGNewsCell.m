//
//  YGNewsCell.m
//  网易新闻
//
//  Created by liyonggui on 16/4/16.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import "YGNewsCell.h"

#import "YGNews.h"
#import <UIImageView+WebCache.h>

@interface YGNewsCell ()
///  图片
@property (nonatomic, weak) IBOutlet UIImageView *iconView;
///  标题
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
///  摘要
@property (nonatomic, weak) IBOutlet UILabel *digestLabel;
///  跟帖数
@property (nonatomic, weak) IBOutlet UILabel *replyCountLabel;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *images;


@end

@implementation YGNewsCell

- (void)setNews:(YGNews *)news
{
    _news = news;
    
    self.titleLabel.text = news.title;
    self.digestLabel.text = news.digest;
    self.replyCountLabel.text = [NSString stringWithFormat:@"%@跟帖",news.replyCount];
//    self.replyCountLabel.text = news.replyCount.description;

    [self.iconView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    
    [news.imgextra enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 根据idx获得图片
        UIImageView *imageView = self.images[idx];
        
        // 获得图片URL
        NSString *imageUrl = obj[@"imgsrc"];
        
        // 设置图片
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        
    }];
}

+ (NSString *)identifierWithNews:(YGNews *)news
{
    if (news.imgextra)
    {
        return @"YGMoreImgsCell";
    }
    else if (news.imgType)
    {
        return @"YGBigImgCell";
    }
    
    return @"YGNewsCell";
}

+ (CGFloat)cellRowHeightWithNews:(YGNews *)news
{
    if (news.imgextra)
    {
        return 120;
    }
    else if (news.imgType)
    {
        return 170;
    }
    
    return 80;
}



@end
