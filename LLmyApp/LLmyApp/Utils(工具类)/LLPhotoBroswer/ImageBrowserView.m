//
//  ImageBrowserView.m
//  PhotoBrowser
//
//  Created by chenyaolin on 16/3/11.
//  Copyright © 2016年 chenyaolin. All rights reserved.
//

#import "ImageBrowserView.h"
#import "ZoomingScrollView.h"
#import "LLmyApp-Swift.h"

@interface ImageBrowserView ()
@property (nonatomic, assign) NSInteger lastPageIndex;
@property (nonatomic, assign) NSInteger dx;
@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) NSMutableSet *recycledPages;
@property (nonatomic, strong) NSMutableSet *visiblePages;
@property (nonatomic, assign) BOOL isRePage;
@property (nonatomic, strong) UILabel *pageLabel;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) ZoomingScrollView *currentZoomScrollView;
@end
@implementation ImageBrowserView

- (instancetype)initWithImagesArray:(NSArray *)imagePaths defaultSelectIndex:(NSInteger)defaultSelectIndex {
    self = [super init];
    if (self) {
        _images = imagePaths;
        _defaultSelectIndex = defaultSelectIndex;
        [self commonInit];
        
        [self loadView];
    }
    return self;
}

- (void)dealloc {
    [self.recycledPages removeAllObjects];
}
- (void)commonInit {
    _scrollView = [UIScrollView new];
    [self addSubview:_scrollView];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _pageIndex = 0;
    _lastPageIndex = 1;
    _dx = 30;
    self.alpha = 0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapedEvent:)];
    [self addGestureRecognizer:tap];
    
    [self pageLabel];
    //实例化两个集合
    _recycledPages = [[NSMutableSet alloc] initWithCapacity:0];
    _visiblePages = [[NSMutableSet alloc] initWithCapacity:0];
    
    //初始化页码label
    [self pageLabel];
    
    //先不要
//    _navigationView = [self navigationView];
}

- (void)loadView {
    [self setBackgroundColor:[UIColor blackColor]];
    [_scrollView setBackgroundColor:[UIColor blackColor]];
    [_scrollView setPagingEnabled:YES];
    
    [_scrollView setFrame:CGRectMake(-_dx, 0, kScreenWidth + _dx * 2, kScreenHeight)];
    
    self.scrollView.contentSize = CGSizeMake((kScreenWidth + _dx * 2) * _images.count, kScreenHeight);
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    [self.scrollView setContentOffset:CGPointMake(_defaultSelectIndex * (kScreenWidth + _dx * 2), 0)];
    
    [self titlePages];
}

- (void)show {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
    
    [self showPageLabel:nil];
}
- (void)viewTapedEvent:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)titlePages
{
    //计算可见页码
    CGRect visibleBounds = _scrollView.bounds;
    
    //出现在屏幕最左边的页码
    int firstNeededPageIndex=floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds));
    //出现在屏幕最右边的页码
    int lastNeededPageIndex=floorf(CGRectGetMaxX(visibleBounds) / CGRectGetWidth(visibleBounds));

    //左右各多加载一页
    firstNeededPageIndex = MAX(firstNeededPageIndex - 1, 0);
    
    lastNeededPageIndex = MIN(lastNeededPageIndex + 1, (int)_images.count - 1);
    
    //收藏不可见页，以备复用
    for (ZoomingScrollView *page in _visiblePages) {
        if (page.pageIndex < firstNeededPageIndex || page.pageIndex > lastNeededPageIndex ) {
            //中止图片下载
            [page.imageView sd_cancelCurrentImageLoad];
            //收录
            [_recycledPages addObject:page];
            //移除
            [page removeFromSuperview];
        }
    }
    //从可见集合中去掉回收集合包含的内容
    [_visiblePages minusSet:_recycledPages];
    
    //添加新可见页
    for (int index = firstNeededPageIndex; index<=lastNeededPageIndex; index++) {
        //不是可见页则处理，否则不处理
        if (![self isDisplayingPageForIndex:index]) {
            //是否存在可复用的实例
            ZoomingScrollView *page = [self dequeueRecycledPage];
            
            if (page==nil) {//不存在就创建
                page = [[ZoomingScrollView alloc] init];
            }
            
            //设置页码
            [page setPageIndex:index];
            page.frame = CGRectInset(CGRectMake((kScreenWidth + _dx * 2) * index, 0, kScreenWidth + _dx * 2, kScreenHeight), _dx, 0);
            page.superView = self;
            id object = [_images objectAtIndex:index];
            if ([object isKindOfClass:[NSString class]]) {
                 NSString *imgStr = object;
                 [page setImageWithString:imgStr];
            }else if ([object isKindOfClass:[UIImage class]]) {
                [page setImageWithImage:object];
            }
           
           
            [self.scrollView addSubview:page];

            //加入可见集合
            [_visiblePages addObject:page];
        }
    }
}

- (BOOL)isDisplayingPageForIndex:(NSInteger)index
{
    BOOL foundPage = NO;
    for (ZoomingScrollView *page in _visiblePages) {
        if (page.pageIndex == index) {
            foundPage = YES;
            break;
        }
    }
    return foundPage;
}

- (ZoomingScrollView *)dequeueRecycledPage
{
    ZoomingScrollView *page=[_recycledPages anyObject];
    if (page) {
        [_recycledPages removeObject:page];
    }
    return page;
}

#pragma mark - scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
//
    
    _pageIndex = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5) + 1;
    
    if (_lastPageIndex == _pageIndex) {
        return;
    }else{
        _lastPageIndex = _pageIndex;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSInteger currentPage = self.scrollView.contentOffset.x / self.bounds.size.width;

    for (ZoomingScrollView *temp in [scrollView subviews]) {
        if (currentPage == (temp.frame.origin.x - _dx ) / (self.bounds.size.width + (2 * _dx)) && _currentZoomScrollView == nil) {
            _currentZoomScrollView = temp;
            break;
        }
    }
    if (_currentZoomScrollView) {
        _oldX = _currentZoomScrollView.frame.origin.x;
    }else{
        _oldX = scrollView.contentOffset.x;
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hidePageLabel:) object:nil];
    [self showPageLabel:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5) + 1;
    [_pageLabel setText:[NSString stringWithFormat:@"%ld / %lu", (long)currentPage, (unsigned long)_images.count]];
    [_pageLabel sizeToFit];
    
    if (scrollView.contentOffset.x < _oldX) { //右滑
        if (scrollView.contentOffset.x <= _oldX - self.bounds.size.width - 2 * _dx) {
            [self resetAllZoomView];
        }
    }else if (scrollView.contentOffset.x > _oldX) {
        if (scrollView.contentOffset.x >= _oldX + self.bounds.size.width - 2 * _dx) {
            [self resetAllZoomView];
        }
    }
}

- (void)resetAllZoomView {
    [self titlePages];
    for (ZoomingScrollView *sv in [self.scrollView subviews]) {
        if ([sv isKindOfClass:[UIScrollView class]]) {
            [sv setZoomScale:1];
        }
    }
    _currentZoomScrollView = nil;
}
#pragma mark - lazy load
- (UIView *)navigationView {
    if (!_navigationView) {
        _navigationView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        _navigationView.backgroundColor = [UIColor colorWithRed:0.1761 green:0.1761 blue:0.1761 alpha:1.0];
        [self addSubview:_navigationView];
        
        _title = [[UILabel alloc]init];
        [_title setFont:[UIFont systemFontOfSize:18]];
        [_title setText:[NSString stringWithFormat:@"%d/%d", (int)_pageIndex, (int)_images.count]];
        [_title setTextColor:[UIColor whiteColor]];
        [_title setFrame:CGRectMake(_navigationView.frame.size.width / 2 - _title.frame.size.width / 2, 0, _navigationView.frame.size.width, _navigationView.frame.size.height)];
        _title.center = _navigationView.center;
        [_navigationView addSubview:_title];
        
    }else{
        [self addSubview:_navigationView];
    }
    return _navigationView;
}

- (UILabel *)pageLabel {
    if (_pageLabel == nil) {
        _pageLabel = [[UILabel alloc]init];
        [_pageLabel setText:[NSString stringWithFormat:@"%d / %lu", (int)_defaultSelectIndex + 1, (unsigned long)_images.count]];
        [_pageLabel setTextColor:[UIColor whiteColor]];
        [_pageLabel setFont:[UIFont systemFontOfSize:16]];
        [self addSubview:_pageLabel];
        [_pageLabel setAlpha:0];
        [_pageLabel setFrame:CGRectMake((kScreenWidth - _pageLabel.frame.size.width) / 2, kScreenHeight - 50, kScreenWidth, 30)];
        [_pageLabel sizeToFit];
        _pageLabel.center = CGPointMake(kScreenWidth / 2, _pageLabel.center.y);
    }
    return _pageLabel;
}

#pragma mark - timer
- (void)hidePageLabel:(id)sender {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf.pageLabel setAlpha:0];
    } completion:^(BOOL finished) {
//        [_timer invalidate];
//        _timer = nil;
    }];
}

- (void)showPageLabel:(id)sender {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf.pageLabel setAlpha:1];
    } completion:^(BOOL finished) {
//        [_timer invalidate];
//        _timer = nil;
        [weakSelf performSelector:@selector(hidePageLabel:) withObject:nil afterDelay:1.5];
        //        [self hidePageLabel:nil];
    }];
}

@end
