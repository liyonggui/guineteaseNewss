//
//  YGChannelCell.h
//  网易新闻
//
//  Created by liyonggui on 16/4/19.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YGNewsViewController;

@interface YGChannelCell : UICollectionViewCell

//@property (nonatomic, copy) NSString *urlString;

@property (nonatomic, strong) YGNewsViewController *newsVC;

@end
