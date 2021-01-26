//
//  LLEqualSpaceFlowLayout.swift
//  LLmyApp
//
//  Created by 陈耀林 on 2021/1/20.
//  Copyright © 2021 ManlyCamera. All rights reserved.
//

import UIKit

class LLEqualSpaceFlowLayout: UICollectionViewFlowLayout {
    
    var itemAttributes = [UICollectionViewLayoutAttributes]()
    
    init(minInteritem: CGFloat, minLine: CGFloat, edgeInsets: UIEdgeInsets) {
        super.init()
        scrollDirection = .vertical
        minimumInteritemSpacing = minInteritem
        minimumLineSpacing = minLine
        sectionInset = edgeInsets
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        guard let itemCount = collectionView?.numberOfItems(inSection: 0) else { return }
        
        var xOffset = sectionInset.left
        var yOffset = sectionInset.top
        var xNextOffset = sectionInset.left
        var isGreater = false
        
        for idx in 0..<itemCount {
            
            let indexPath = IndexPath(item: idx, section: 0)
            let layoutAttributes = layoutAttributesForItem(at: indexPath)
            let itemSize = layoutAttributes?.frame.size
            xNextOffset += minimumInteritemSpacing + (itemSize?.width ?? 0)
            
            let isGreaterA = xNextOffset > (collectionView?.bounds.size.width ?? 0) - sectionInset.right
            let isGreaterB = (xNextOffset - minimumInteritemSpacing) > (collectionView?.bounds.size.width ?? 0) - sectionInset.right
            //            isGreater = isGreaterA && isGreaterB
            isGreater = isGreaterB
            
            if isGreater {
                xOffset = sectionInset.left
                xNextOffset = sectionInset.left + minimumInteritemSpacing + (itemSize?.width ?? 0)
                yOffset += minimumLineSpacing + (itemSize?.height ?? 0)
            } else {
                xOffset = xNextOffset - minimumInteritemSpacing - (itemSize?.width ?? 0)
            }
            
            layoutAttributes?.frame = CGRect(x: xOffset, y: yOffset, width: itemSize?.width ?? 0, height: itemSize?.height ?? 0)
            itemAttributes.append(layoutAttributes ?? UICollectionViewLayoutAttributes())
            
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        super.layoutAttributesForElements(in: rect)
        _ = itemAttributes.map({
            if rect.contains($0.frame) && !itemAttributes.contains($0) {
                itemAttributes.append($0)
            }
        })
        return itemAttributes
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            let size = super.collectionViewContentSize
            
            var ySet: Set<CGFloat> = []
            var height: CGFloat = 0.0
            
            if itemAttributes.count > 0 {
                for attribute in itemAttributes {
                    ySet.insert(attribute.frame.origin.y)
                    height = attribute.frame.size.height
                }
            }
            
            let newSize = CGSize(width: size.width, height: (height * CGFloat(ySet.count)) + (minimumLineSpacing * CGFloat((ySet.count - 1))) + sectionInset.top + sectionInset.bottom)
            
            return newSize
        }
        set {
            self.collectionViewContentSize = newValue
        }
    }
    
}
