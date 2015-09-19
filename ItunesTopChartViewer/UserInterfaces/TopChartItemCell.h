//
//  TopChartItemCell.h
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopChartItemCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end
