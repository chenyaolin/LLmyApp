//
//  ZoomingScrollView.m
//  PhotoBrowser
//
//  Created by chenyaolin on 16/3/11.
//  Copyright © 2016年 chenyaolin. All rights reserved.
//

#import "ZoomingScrollView.h"

@interface ZoomingScrollView ()

@end
@implementation ZoomingScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)dealloc {
    
}
- (void)commonInit {
    self.delegate = self;
    self.backgroundColor = [UIColor blackColor];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.maximumZoomScale = 3.0;
    self.minimumZoomScale = 1.0;
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (kScreenHeight - 200) / 2, kScreenWidth, 200)];
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:_imageView];

}

- (void)setImageWithString:(NSString *)path {
    
    if ([self isValidHttpUrl:path]) {
//        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:path]];
        if (!_loadingView) {
            _loadingView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((kScreenWidth - 40) / 2, (kScreenHeight - 40) / 2, 40, 40)];
            [_loadingView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
            [_loadingView startAnimating];
            [self addSubview:_loadingView];
        }else{
            [_loadingView startAnimating];
        }
        
        [_loadingView startAnimating];
        
        __weak typeof(self) weakSelf = self;
        [_imageView sd_setImageWithURL:[NSURL URLWithString:path] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error == nil) {
                [weakSelf.imageView setImage:image];
                [weakSelf resizeImageView];
                [weakSelf.loadingView stopAnimating];
            }else{
                [weakSelf.loadingView stopAnimating];
            }
        }];
//        [_imageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"PlaceholderPhoto"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//            [weakSelf.imageView setImage:image];
//            [weakSelf resizeImageView];
//            [weakSelf.loadingView stopAnimating];
//        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//            [weakSelf.loadingView stopAnimating];
//        }];
    }else{
        [_imageView setImage:[UIImage imageWithContentsOfFile:path]];
        [self resizeImageView];
        if (_loadingView) {
            [_loadingView stopAnimating];
        }
    }
}

- (void)setImageWithImage:(UIImage *)image {
    [_imageView setImage:image];
    [self resizeImageView];
}

//重设图片大小
- (void)resizeImageView {
    CGSize size = [self getScaleImageSize];
    [_imageView setFrame:CGRectMake(0, 0, size.width, size.height)];
    _imageView.center = [self getCenterPoint];
//    _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//    _imageView.layer.borderWidth = 5;
}

- (CGSize)getScaleImageSize {
    float w = kScreenWidth;
    float h = kScreenHeight;
    float imageW = _imageView.image.size.width;
    float imageH = _imageView.image.size.height;
    if (imageW/imageH > kScreenWidth/kScreenHeight) {
        if (imageW < kScreenWidth) {
            w = imageW;
            h = imageH>=kScreenHeight?h:imageH;
        }else{
            h = imageH * kScreenWidth / imageW;
        }
    }else{
        if (imageH < kScreenHeight) {
            h = imageH;
            w = imageW>=kScreenWidth?h:imageW;
        }else{
            w = imageW * kScreenHeight / imageH;
        }
    }
    return CGSizeMake(w, h);
}

//获取中心点
- (CGPoint)getCenterPoint {
    CGFloat offsetX = (self.bounds.size.width > self.contentSize.width)?(self.bounds.size.width - self.contentSize.width)/2 : 0.0;
    
    CGFloat offsetY = (self.bounds.size.height > self.contentSize.height)?(self.bounds.size.height - self.contentSize.height)/2 : 0.0;
    
    return CGPointMake(self.contentSize.width/2 + offsetX,self.contentSize.height/2 + offsetY);
}

//设置缩放
- (void)setZoomScale:(CGFloat)zoomScale {
    [super setZoomScale:zoomScale];
    _imageView.center = [self getCenterPoint];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    if (_superView) {
        _superView.oldX = _superView.scrollView.contentOffset.x;
    }
    [UIView animateWithDuration:0.15 animations:^{
        view.center = [self getCenterPoint];
    }];
}

//是否网址
- (BOOL)isValidHttpUrl:(NSString *)url
{
    if (url) {
        NSError *error;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"http+:[^\\s]*" options:0 error:&error];
        NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@"https+:[^\\s]*" options:0 error:&error];
        NSTextCheckingResult *match = [regex firstMatchInString:url options:0 range:NSMakeRange(0, [url length])];
        NSTextCheckingResult *match1 = [regex1 firstMatchInString:url options:0 range:NSMakeRange(0, [url length])];
        if (match != nil || match1 != nil) {
            return YES;
        }
    }
    return NO;
}

@end
