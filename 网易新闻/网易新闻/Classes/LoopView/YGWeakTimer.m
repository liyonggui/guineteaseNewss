//
//  YGWeakTimer.m
//  网易新闻
//
//  Created by liyonggui on 16/4/16.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import "YGWeakTimer.h"

@interface YGWeakTimer ()
@property (nonatomic, weak) id aTarget;
@property (nonatomic, assign) SEL aSelector;
@end

@implementation YGWeakTimer

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    YGWeakTimer *timer = [YGWeakTimer new];
    
    timer.aTarget = aTarget;
    timer.aSelector = aSelector;
    
    return [NSTimer scheduledTimerWithTimeInterval:ti target:timer selector:@selector(fire:) userInfo:userInfo repeats:yesOrNo];
}

- (void)fire:(id)obj
{
    [self.aTarget performSelector:self.aSelector withObject:obj];
}















@end
