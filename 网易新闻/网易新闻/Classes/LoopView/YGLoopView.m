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

@interface YGLoopView () <UICollectionViewDataSource>

///  图片的url
@property (nonatomic, strong) NSArray *urls;

///  标题数组
@property (nonatomic, strong) NSArray *titles;

///  标题
@property (nonatomic, weak) UILabel *titleLabel;

///  分页控件
@property (nonatomic, weak) UIPageControl *pageControl;

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
//        self.pageControl.currentPage = 1;
        
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


#pragma mark - 添加子控件
///  添加子控件
- (void)setupChildControl
{
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[YGFlowLayout new]];
    
    // 设置数据源
    collectionView.dataSource = self;
     // 设置分页
    collectionView.pagingEnabled = YES;
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

#pragma mark - 数据源
/// 有几组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

///  每组有几个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.urls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YGLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"loopCell" forIndexPath:indexPath];
    cell.url = self.urls[indexPath.item];
    
    return cell;
}



@end
