//
//  ZoomingScrollView.h
//  PhotoBrowser
//
//  Created by chenyaolin on 16/3/11.
//  Copyright © 2016年 chenyaolin. All rights reserved.
//

#define kScreenWidth      CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight     CGRectGetHeight([UIScreen mainScreen].bounds)
#import <UIKit/UIKit.h>
#import "ImageBrowserView.h"

@interface ZoomingScrollView : UIScrollView <UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, weak) ImageBrowserView *superView;
- (void)setImageWithString:(NSString *)path;
- (void)setImageWithImage:(UIImage *)image;
@end
