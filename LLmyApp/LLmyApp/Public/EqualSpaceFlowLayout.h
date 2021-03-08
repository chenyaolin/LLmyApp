//
//  EqualSpaceFlowLayout.h
//  CROnlineConsultation
//
//  Created by chenyaolin on 2017/4/11.
//  Copyright © 2017年 Chenrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EqualSpaceFlowLayout : UICollectionViewFlowLayout
- (instancetype)initWithMinInteritem:(CGFloat)minInteritem minLine:(CGFloat)minLine edgeInsets:(UIEdgeInsets)edgeInsets;
@property (nonatomic, assign) NSInteger lineCount;
@property (nonatomic, assign) BOOL isFirstItemOneLine;
@end
