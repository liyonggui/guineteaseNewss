//
//  YGHomeViewController.m
//  网易新闻
//
//  Created by liyonggui on 16/4/17.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import "YGHomeViewController.h"

#import "YGChannel.h"
#import "YGChannelLabel.h"
#import "YGChannelCell.h"
#import "YGNewsViewController.h"

@interface YGHomeViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

///  模型数组
@property (nonatomic, strong) NSArray *channels;

///  频道view
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
///  布局参数
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

///  控制器缓存池
@property (nonatomic, strong) NSMutableDictionary *controllerCache;

///  频道标签索引
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation YGHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self setupChannelView];
    
}

#pragma mark - 添加子控件到collectionView

- (void)setupChannelView
{
    self.currentIndex = 0;
    // 不要自动调整UIScrollView偏移量
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat labelX = 8;
    CGFloat labelY = 0;
    CGFloat labelH = self.scrollView.frame.size.height;
    
    NSInteger index = 0;
    // 添加频道标签
    for (YGChannel *channel in self.channels)
    {
        // 创建标签
        YGChannelLabel *label = [YGChannelLabel labelWithText:channel.tname];
        //        NSLog(@"%@",channel.tname);
        
        // 设置标记
        label.tag = index++;
        __weak typeof(self) weakSelf = self;
        __weak typeof(label) weakLabel = label;
        // 监听label的点击
        [label setDidSelected:^{
            
            // 点击之前选中的label的scale = 0
            YGChannelLabel *currentLabel = weakSelf.scrollView.subviews[weakSelf.currentIndex];
            currentLabel.scale = 0;
            // 当前点击label的scale = 1
            weakLabel.scale = 1;
            // 重新赋值currentIndex
            weakSelf.currentIndex = weakLabel.tag;
            // 滚动到指定位置
            [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:weakLabel.tag inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            // 计算scrollView X方向要偏移的值
            CGFloat offset = weakLabel.center.x - self.scrollView.frame.size.width * 0.5;
            // 计算最大滚动范围
            CGFloat maxOffset = weakSelf.scrollView.contentSize.width - weakSelf.scrollView.frame.size.width;
            if (offset < 0)
            {
                offset = 0;
            }
            else if (offset >= maxOffset)
            {
                offset = maxOffset;
            }
            [weakSelf.scrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
        }];
        
        CGFloat labelW = label.frame.size.width;
        //        NSLog(@"%f",labelW);
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        // 字体居中
        label.textAlignment = NSTextAlignmentCenter;
        
        // 添加到父容器
        [self.scrollView addSubview:label];
        
        labelX +=labelW;
    }
    
    // 设置滚动范围
    self.scrollView.contentSize = CGSizeMake(labelX, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    // 默认头条选中
    YGChannelLabel *label = self.scrollView.subviews[self.currentIndex];
    label.scale = 1.0;
    NSLog(@"%zd",self.scrollView.subviews.count);
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self setupFlowLayout];
}

#pragma mark - 布局FlowLayout属性

- (void)setupFlowLayout
{
    self.flowLayout.itemSize = self.collectionView.frame.size;
    // 水平滚动
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 间距
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    
    // 分页
    self.collectionView.pagingEnabled = YES;
    // 去除滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YGChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"channelCell" forIndexPath:indexPath];
    YGChannel *channel = self.channels[indexPath.item];
    
    // 获取新闻控制器
    YGNewsViewController *newsVC = [self newsVC:channel];
    // 控制器赋值给cell
    cell.newsVC = newsVC;
    return cell;
}

#pragma mark - 根据频道模型获得新闻控制器
- (YGNewsViewController *)newsVC:(YGChannel *)channel
{
    YGNewsViewController *newsVC = self.controllerCache[channel.tid];
    if (newsVC == nil)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
        
        // 加载箭头指向控制器
        newsVC = sb.instantiateInitialViewController;
        
        // 传递频道
        newsVC.urlString = channel.URLString;
        
        // 添加到缓存池
        [self.controllerCache setObject:newsVC forKey:channel.tid];
    }
    
    return newsVC;
}

#pragma mark - UIScrollView 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获得当前选中的频道标签
    YGChannelLabel *currentLabel = self.scrollView.subviews[self.currentIndex];
    
    // 获得当前可视的items
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    
    // 下一个频道
    YGChannelLabel *nextLabel = nil;
    
    // 遍历数组寻找下一个标签
    for (NSIndexPath *indexPath in indexPaths)
    {
        if (indexPath.item != self.currentIndex)
        {
            nextLabel = self.scrollView.subviews[indexPath.item];
            break;
        }
    }
    
    // 没有下一个标签
    if (nextLabel == nil)
    {
        return;
    }
    
    // 计算下一个标签的缩放比例
    CGFloat nextScale = ABS(self.collectionView.contentOffset.x / self.collectionView.frame.size.width - self.currentIndex);
    
    // 当前频道缩放比例
    CGFloat currentScale = 1 - nextScale;
    
    // 设置比例
    currentLabel.scale = currentScale;
    nextLabel.scale = nextScale;
    
    //    NSLog(@"%f *** %f",currentScale,nextScale);
    
    // 重新赋值currentIndex属性
    self.currentIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 计算scrollView X方向要偏移的值
    CGFloat offset = nextLabel.center.x - self.scrollView.frame.size.width * 0.5;
    // 计算最大滚动范围
    CGFloat maxOffset = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
    if (offset < 0)
    {
        offset = 0;
    }
    else if (offset >= maxOffset)
    {
        offset = maxOffset;
    }
    
    [self.scrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currentIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    //    NSLog(@"self.currentIndex == %zd",self.currentIndex);
}


#pragma mark - 懒加载
- (NSArray *)channels
{
    if (_channels == nil)
    {
        _channels = [YGChannel channels];
    }
    return _channels;
}

- (NSMutableDictionary *)controllerCache
{
    if (_controllerCache == nil)
    {
        _controllerCache = [[NSMutableDictionary alloc] init];
    }
    return _controllerCache;
}





@end
