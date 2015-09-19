//
//  TopChartFlowLayout.m
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import "TopChartFlowLayout.h"

@implementation TopChartFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemSize = [self itemSizeThatFitsScreen];
        self.minimumInteritemSpacing = 0.0f;
        self.minimumLineSpacing = 0.0f;
    }
    return self;
}

- (CGSize)itemSizeThatFitsScreen {
    CGFloat length = [self shorterLengthFromScreenBounds];
    return CGSizeMake(length, length);
}

- (CGFloat)shorterLengthFromScreenBounds {
    CGRect bounds = [UIScreen mainScreen].bounds;
    return MIN(CGRectGetHeight(bounds), CGRectGetWidth(bounds));
}

@end
