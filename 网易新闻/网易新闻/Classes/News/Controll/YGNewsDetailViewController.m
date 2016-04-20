//
//  YGNewsDetailViewController.m
//  网易新闻
//
//  Created by liyonggui on 16/4/19.
//  Copyright © 2016年 liyonggui. All rights reserved.
//

#import "YGNewsDetailViewController.h"

#import "YGNews.h"
#import "YGNetworkTools.h"

@interface YGNewsDetailViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

///  时间和来源
@property (nonatomic, copy) NSString *timeAndSource;
///  标题
@property (nonatomic, copy) NSString *newsTitle;
///  内容
@property (nonatomic, copy) NSString *content;

@end

@implementation YGNewsDetailViewController

- (void)loadView
{
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.webView.delegate = self;
    self.view = self.webView;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // http://c.m.163.com/nc/article/9IG74V5H00963VRO_BL41R29MbjjikeupdateDoc/full.html
    // BL1KEQNO00234L7P
    // 9IG74V5H00963VRO_BL41R29MbjjikeupdateDoc
    self.webView.backgroundColor = [UIColor whiteColor];
//     NSLog(@"%@",self.news.detailURLStirng);
    // NSLog(@"%@",self.news);
    // 加载新闻详细数据
    [[YGNetworkTools sharedNetworkTool] GET:self.news.detailURLStirng parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        NSDictionary *data = responseObject[responseObject.keyEnumerator.nextObject];
//        NSLog(@"%@",data);
        // 时间
        self.timeAndSource = [NSString stringWithFormat:@"%@  %@",data[@"ptime"],data[@"source"]];
        self.newsTitle = data[@"title"];
        self.content = data[@"body"];
        // 获得图片数组
        NSArray *arr = data[@"img"];
        
        // 遍历数组
        for (NSDictionary *dic in arr)
        {
            // 获得ref
            NSString *ref = dic[@"ref"];
            // 获得图片url
            NSString *src = dic[@"src"];
            
            NSString *imgTag = [NSString stringWithFormat:@"<img src=\"%@\" width=\"100%%\" />",src];
            
            // 将body中的ref字符串替换成src字符串
            self.content = [self.content stringByReplacingOccurrencesOfString:ref withString:imgTag];
        }
        
        // 加载webView
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"detail.html" ofType:nil]];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - webView 代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 调用js方法
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"changeContent('%@','%@','%@')",self.newsTitle,self.timeAndSource,self.content]];
    
}


@end
