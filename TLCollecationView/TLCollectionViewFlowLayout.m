//
//  TLCollectionViewFlowLayout.m
//  TLCollecationView
//
//  Created by andezhou on 15/7/28.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//

#import "TLCollectionViewFlowLayout.h"
#define  kScreenWidth [UIScreen mainScreen].bounds.size.width
static CGFloat const kMargin = 10;
static NSUInteger const kNumber = 3;

@interface TLCollectionViewFlowLayout ()

@property (nonatomic, assign) CGFloat height;

@end

@implementation TLCollectionViewFlowLayout

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config {
    self.sectionInset = UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
    self.minimumLineSpacing = kMargin;
    self.minimumInteritemSpacing = kMargin;
    self.itemSize = CGSizeMake([self rowWidth], [self rowWidth]);
}

- (CGSize)collectionViewContentSize {
    CGFloat rowWidth = [self rowWidth];
    CGFloat bigWidth = [self bigWidth];
    
    NSInteger item = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat height  = self.sectionInset.top + self.minimumInteritemSpacing + bigWidth;
    
    NSUInteger row = item - 3;
    NSUInteger section = row / 3 + (row % 3 ? 1 : 0);

    height += section * (rowWidth + self.minimumInteritemSpacing);
    return CGSizeMake(kScreenWidth, height);
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];

    NSMutableArray *contains = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *layoutAttributes in array) {
        
        if (CGRectIntersectsRect(layoutAttributes.frame, rect)) {
            [contains addObject:layoutAttributes];
        }
    }
    
    NSMutableArray *attributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *layoutAttributes in contains) {
        NSIndexPath *indexPath = layoutAttributes.indexPath;
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }

    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
                                 withScrollingVelocity:(CGPoint)velocity {
    CGRect targetRect = CGRectMake(0.0f, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
   [self layoutAttributesForElementsInRect:targetRect];
    
    return [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat rowWidth = [self rowWidth];
    CGFloat bigWidth = [self bigWidth];
    
    if (indexPath.item == 0) {
        attributes.size = CGSizeMake(bigWidth, bigWidth);
        attributes.center = CGPointMake(bigWidth/2.0 + self.sectionInset.left, bigWidth/2.0 + self.sectionInset.top);
    }
    else if (indexPath.item < 3){
        attributes.size = CGSizeMake(rowWidth, rowWidth);
        
        NSUInteger row = indexPath.item - 1;
        CGFloat centerX = bigWidth + rowWidth/2.0 + self.minimumLineSpacing + self.sectionInset.left;
        CGFloat centerY = rowWidth/2.0 + (rowWidth + self.minimumInteritemSpacing)*row + self.sectionInset.top;
        
        attributes.center = CGPointMake(centerX, centerY);
    }
    else {
        attributes.size = CGSizeMake(rowWidth, rowWidth);
        
        NSUInteger row = indexPath.item - 3;
        NSUInteger X = row % kNumber;
        NSUInteger Y = row / kNumber;

        CGFloat centerX = self.sectionInset.left + rowWidth/2.0f + (self.minimumLineSpacing + rowWidth) * X;
        CGFloat centerY = self.sectionInset.top + self.minimumInteritemSpacing + bigWidth + rowWidth/2.0f + (self.minimumInteritemSpacing + rowWidth) * Y;

        attributes.center = CGPointMake(centerX, centerY);
    }
    return attributes;
}

- (CGFloat)bigWidth {
    return kScreenWidth - [self rowWidth] - self.minimumLineSpacing - self.sectionInset.left - self.sectionInset.right;
}

- (CGFloat)rowWidth {
    return (kScreenWidth - (kNumber - 1) * self.minimumLineSpacing - self.sectionInset.left - self.sectionInset.right)/kNumber;
}

@end
