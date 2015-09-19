//
//  TopChartFetcher.h
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AlbumMeta;
@interface TopChartFetcher : NSObject

- (void)fetchTopChart;

@property (nonatomic, readonly) NSArray *topChartAlbums;

@end

extern NSString * const TopChartFetcherFetchFailureNotification;
extern NSString * const TopChartFetcherDidUpdateTopAlbumsChartNotification;
extern NSString * const TopChartFetcherFetchFailureError;
