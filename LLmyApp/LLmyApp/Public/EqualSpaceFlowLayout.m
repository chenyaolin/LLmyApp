//
//  EqualSpaceFlowLayout.m
//  CROnlineConsultation
//
//  Created by chenyaolin on 2017/4/11.
//  Copyright © 2017年 Chenrui. All rights reserved.
//

#import "EqualSpaceFlowLayout.h"

@interface EqualSpaceFlowLayout()
@property (nonatomic, strong) NSMutableArray *itemAttributes;
@end

@implementation EqualSpaceFlowLayout
- (instancetype)init
{
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumInteritemSpacing = 15;
        self.minimumLineSpacing = 15;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    return self;
}

- (instancetype)initWithMinInteritem:(CGFloat)minInteritem minLine:(CGFloat)minLine edgeInsets:(UIEdgeInsets)edgeInsets
{
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumInteritemSpacing = minInteritem;
        self.minimumLineSpacing = minLine;
        self.sectionInset = edgeInsets;
    }
    
    return self;
}

#pragma mark - Methods to Override
- (void)prepareLayout
{
    [super prepareLayout];
    
    NSInteger itemCount = [[self collectionView] numberOfItemsInSection:0];
    self.itemAttributes = [NSMutableArray arrayWithCapacity:itemCount];

    CGFloat xOffset = self.sectionInset.left;
    CGFloat yOffset = self.sectionInset.top;
    CGFloat xNextOffset = self.sectionInset.left;
    BOOL isGreater = NO;
    
    for (NSInteger idx = 0; idx < itemCount; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        UICollectionViewLayoutAttributes *layoutAttributes = [[self layoutAttributesForItemAtIndexPath:indexPath] copy];
        
        CGSize itemSize = layoutAttributes.frame.size;
        xNextOffset+=(self.minimumInteritemSpacing + itemSize.width);
        
        if (idx == 1 && self.isFirstItemOneLine) {
            xOffset = self.sectionInset.left;
            xNextOffset = (self.sectionInset.left + self.minimumInteritemSpacing + itemSize.width);
            yOffset += (itemSize.height + self.minimumLineSpacing);
        } else {
            
            // 判断下一个是否超出规定范围
            isGreater = (xNextOffset > [self collectionView].bounds.size.width - self.sectionInset.right) && ((xNextOffset - self.minimumInteritemSpacing) > [self collectionView].bounds.size.width - self.sectionInset.right);
            
            if (isGreater == YES) {
                xOffset = self.sectionInset.left;
                xNextOffset = (self.sectionInset.left + self.minimumInteritemSpacing + itemSize.width);
                yOffset += (itemSize.height + self.minimumLineSpacing);
            }
            else
            {
                xOffset = xNextOffset - (self.minimumInteritemSpacing + itemSize.width);
            }
            
        }
        
//        xNextOffset+=(self.minimumInteritemSpacing + itemSize.width);

    
        layoutAttributes.frame = CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height);
        [_itemAttributes addObject:layoutAttributes];
    }
}

//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    [super layoutAttributesForElementsInRect:rect];
//    return [self.itemAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
//        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
//    }]];
//}

- (CGSize)collectionViewContentSize{
    CGSize size = [super collectionViewContentSize];
    
    NSMutableSet *ySet = [NSMutableSet set];
    CGFloat height = 0.0;
    
    if (self.itemAttributes.count > 0) {
        for (UICollectionViewLayoutAttributes *attribute in self.itemAttributes) {
            [ySet addObject:@(attribute.frame.origin.y)];
            height = attribute.frame.size.height;
        }
    }
    
    self.lineCount = ySet.count;
    
    CGSize newSize = CGSizeMake(size.width, (height * ySet.count) + (self.minimumLineSpacing * (ySet.count - 1)) + self.sectionInset.top + self.sectionInset.bottom);
    
    return newSize;
}

@end
