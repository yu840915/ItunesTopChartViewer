//
//  AlbumMeta.h
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImageMeta;

NS_ASSUME_NONNULL_BEGIN
@interface AlbumMeta : NSObject

+ (instancetype)albumMetaWithJSONObject:(NSDictionary *)obj;

- (instancetype)initWithTitle:(NSString *)title artists:(NSString *__nullable)artists coverImageMeta:(ImageMeta *)imageMeta;

@property (nonatomic, readonly) ImageMeta *coverImageMeta;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *artists;

@end
NS_ASSUME_NONNULL_END