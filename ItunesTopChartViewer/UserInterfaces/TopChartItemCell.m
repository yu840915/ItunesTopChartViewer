//
//  TopChartItemCell.m
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import "TopChartItemCell.h"

@implementation TopChartItemCell

- (void)awakeFromNib {
    [self setShadowForView:_titleLabel];
    [self setShadowForView:_subtitleLabel];
}

- (void)setShadowForView:(UIView *)view {
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowOffset = CGSizeZero;
    view.layer.shadowRadius = 3.0f;
    view.layer.shadowOpacity = 1.0f;
}

@end
