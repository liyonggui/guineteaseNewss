//
//  YGChannelLabel.m
//  网易新闻
//
//  Created by liyonggui on 16/4/17.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import "YGChannelLabel.h"

#define kNormalFontSize 14 // 默认
#define kSelectedFontSize 18 // 选中

@implementation YGChannelLabel

+ (instancetype)labelWithText:(NSString *)text
{
    YGChannelLabel *label = [YGChannelLabel new];
    
    label.text = text;
    
    label.font = [UIFont systemFontOfSize:kSelectedFontSize];
    
    // 字体自适应
    [label sizeToFit];
    
    label.font = [UIFont systemFontOfSize:kNormalFontSize];
    
    // 打开交互
    label.userInteractionEnabled = YES;
    
    return label;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%@",self.text);
    if (self.didSelected)
    {
        self.didSelected();
    }
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    // 计算最大缩放比例
    CGFloat maxScale = (CGFloat)(kSelectedFontSize - kNormalFontSize) / kNormalFontSize;
    
    // 计算真实的缩放比例
    CGFloat realScale = scale * maxScale + 1;
    
    // 缩放
    self.transform = CGAffineTransformMakeScale(realScale, realScale);
    
    // 设置颜色
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
    
}

@end
