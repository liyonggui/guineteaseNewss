//
//  YGLoopView.m
//  网易新闻
//
//  Created by liyonggui on 16/4/14.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import "YGLoopView.h"

#import "YGFlowLayout.h"
#import "YGLoopViewCell.h"

@interface YGLoopView () <UICollectionViewDataSource,UICollectionViewDelegate>

///  图片的url
@property (nonatomic, strong) NSArray *urls;

///  标题数组
@property (nonatomic, strong) NSArray *titles;

///  标题
@property (nonatomic, weak) UILabel *titleLabel;

///  分页控件
@property (nonatomic, weak) UIPageControl *pageControl;

///  定时器
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation YGLoopView


- (instancetype)initWithUrls:(NSArray <NSString *>*)urls title:(NSArray <NSString *>*)titles didSelected:(void (^)())selected
{
    if (self = [super init])
    {
        self.urls = urls;
        self.titles = titles;
        
        // 设置标题
        self.titleLabel.text = self.titles[0];
        
        // 设置分页显示
        self.pageControl.numberOfPages = self.urls.count;
        
        // 开线程，完成数据源方法才调用,调用block时，数据源方法已经执行完
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.urls.count > 1)
            {
                // 默认滚动到指定位置
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.urls.count inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
                // 开始定时器
                [self addTimer];
            }
        });
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setupChildControl];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupChildControl];
    }
    return self;
}

#pragma mark - 定时器相关方法
///  添加定时器
- (void)addTimer
{
    if (self.timer) return;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
    // 添加到运行环
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)update
{
    // 计算页号
    NSInteger page = self.collectionView.contentOffset.x / self.collectionView.frame.size.width;
//    NSLog(@"%zd",page);
    // 计算偏移量
    CGFloat offsetX = (page + 1) * self.collectionView.frame.size.width;
    
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

#pragma mark - 添加子控件
///  添加子控件
- (void)setupChildControl
{
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[YGFlowLayout new]];
    
    // 设置数据源
    collectionView.dataSource = self;
    // 设置代理
    collectionView.delegate =self;
     // 设置分页
    collectionView.pagingEnabled = YES;
    // 去除弹簧
    collectionView.bounces = NO;
    // 注册cell
    [collectionView registerClass:[YGLoopViewCell class] forCellWithReuseIdentifier:@"loopCell"];
    // 隐藏滚动条
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView = collectionView;
    // 添加到父容器
    [self addSubview:collectionView];
    
    // 创建标题label
    UILabel *titleLabel = [[UILabel alloc] init];
    // 添加到父容器
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    titleLabel.textColor = [UIColor blackColor];
    
    // 分页控件
    UIPageControl *page = [UIPageControl new];
    // 设置颜色
    page.currentPageIndicatorTintColor = [UIColor redColor];
    page.pageIndicatorTintColor = [UIColor grayColor];
    // 添加到父容器
    [self addSubview:page];
    self.pageControl = page;
    
    
}

#pragma mark - 布局子控件frame
///  布局子控件frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat titleH = 30.0f;
    
    CGRect temp = self.bounds;
    temp.size.height -= titleH;
    self.collectionView.frame = temp;
    
    CGFloat marginX = 10;
    
    // 分页控件frame
    CGFloat pageW = 40;
    CGFloat pageX = self.frame.size.width - pageW - marginX;
    CGFloat pageH = titleH;
    CGFloat pageY = self.collectionView.frame.size.height;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
    // 标题frame
    CGFloat titleX = marginX * 0.5;
    CGFloat titleY = pageY;
    CGFloat titleW = pageX - titleX;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
}

#pragma mark - UIScrollViewDelegate 代理方法

///  开始拖拽时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

///  滚动时调用，切换分页控件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = (CGFloat)scrollView.contentOffset.x / scrollView.frame.size.width + 0.5;
//    NSLog(@"%zd",index);
//    self.pageControl.currentPage = index;
    self.titleLabel.text = self.titles[index % self.urls.count];
    self.pageControl.currentPage = index % self.urls.count;
//     NSLog(@"%zd",self.pageControl.currentPage);
}

///  滚动结束时调用
// 0-11   0-3 4-7 8-11
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (index == 0 || index == [self.collectionView numberOfItemsInSection:0] -1)
    {
        CGFloat offsetX = (self.urls.count - (index == 0 ? 0 : 1)) * scrollView.frame.size.width;
        self.collectionView.contentOffset = CGPointMake(offsetX, 0);
//        NSLog(@"%f",offsetX);
    }
    // 开始定时器
    [self addTimer];
}

///  自动滚动时调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}

#pragma mark - UICollectionViewDataSource 数据源
/// 有几组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

///  每组有几个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.urls.count * 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YGLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"loopCell" forIndexPath:indexPath];
//    cell.url = self.urls[indexPath.item];
    cell.url = [NSURL URLWithString:self.urls[indexPath.item % self.urls.count]];
//    NSLog(@"%@",cell.url);
    return cell;
}



@end
