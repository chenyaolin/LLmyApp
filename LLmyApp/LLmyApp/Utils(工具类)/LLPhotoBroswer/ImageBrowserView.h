//
//  ImageBrowserView.h
//  PhotoBrowser
//
//  Created by chenyaolin on 16/3/11.
//  Copyright © 2016年 chenyaolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "UIView+WebCache.h"

@interface ImageBrowserView : UIView <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger defaultSelectIndex;
@property (nonatomic, assign) CGFloat oldX;
- (instancetype)initWithImagesArray:(NSArray *)imagePaths defaultSelectIndex:(NSInteger)defaultSelectIndex;
- (void)show;
@end
