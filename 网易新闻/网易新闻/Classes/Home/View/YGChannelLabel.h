//
//  YGChannelLabel.h
//  网易新闻
//
//  Created by liyonggui on 16/4/17.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGChannelLabel : UILabel

+ (instancetype)labelWithText:(NSString *)text;

///  缩放比例 0---1
@property (nonatomic, assign) CGFloat scale;

@property (nonatomic, copy) void (^didSelected)();

@end
