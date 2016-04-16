//
//  YGLoopView.h
//  网易新闻
//
//  Created by liyonggui on 16/4/14.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGLoopView : UIView

- (instancetype)initWithUrls:(NSArray <NSString *>*)urls title:(NSArray <NSString *>*)titles didSelected:(void (^)())selected;

@end
