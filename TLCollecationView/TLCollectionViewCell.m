//
//  TLCollectionViewCell.m
//  TLCollecationView
//
//  Created by andezhou on 15/7/28.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//

#import "TLCollectionViewCell.h"

@implementation TLCollectionViewCell

#pragma mark -
#pragma mark init methods
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.textColor = [UIColor redColor];
        _label.backgroundColor = [UIColor orangeColor];
        _label.font = [UIFont boldSystemFontOfSize:28];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.label];
    }
    return self;
}

@end
