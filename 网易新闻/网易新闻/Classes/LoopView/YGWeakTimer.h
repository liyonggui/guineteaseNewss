//
//  YGWeakTimer.h
//  网易新闻
//
//  Created by liyonggui on 16/4/16.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YGWeakTimer : NSObject

+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

@end
