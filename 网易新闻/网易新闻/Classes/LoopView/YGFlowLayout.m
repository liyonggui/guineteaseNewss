//
//  YGFlowLayout.m
//  网易新闻
//
//  Created by liyonggui on 16/4/14.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import "YGFlowLayout.h"

@implementation YGFlowLayout


- (void)prepareLayout
{
    [super prepareLayout];
    
    self.itemSize = self.collectionView.bounds.size;
//    NSLog(@"%@",NSStringFromCGRect(self.collectionView.bounds));
//    NSLog(@"%@",NSStringFromCGSize(self.itemSize));
    
    // 设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置间距
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    
   
    
    
}

@end
