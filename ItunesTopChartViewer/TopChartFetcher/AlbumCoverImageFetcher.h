//
//  AlbumCoverImageFetcher.h
//  ItunesTopChartViewer
//
//  Created by small on 9/20/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AlbumMeta;

NS_ASSUME_NONNULL_BEGIN
@interface AlbumCoverImageFetcher : NSObject

- (instancetype)initWithPreferedImageSize:(NSInteger)size;

- (void)fetchCoverImageForAlbumMeta:(AlbumMeta *)meta completion:(void(^ _Nullable)(NSData * _Nullable imageData, NSError * _Nullable error))completion;

@end
NS_ASSUME_NONNULL_END