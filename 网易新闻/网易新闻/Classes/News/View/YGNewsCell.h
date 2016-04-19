//
//  YGNewsCell.h
//  网易新闻
//
//  Created by liyonggui on 16/4/16.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YGNews;

@interface YGNewsCell : UITableViewCell

@property (nonatomic, strong) YGNews *news;

+ (NSString *)identifierWithNews:(YGNews *)news;

+ (CGFloat)cellRowHeightWithNews:(YGNews *)news;

@end
