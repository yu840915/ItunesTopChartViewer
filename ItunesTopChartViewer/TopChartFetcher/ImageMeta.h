//
//  ImageMeta.h
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface ImageMeta : NSObject

+ (instancetype)imageMetaWithJSONObject:(NSDictionary *)obj;

- (instancetype)initWithExampleImageURI:(NSString *)uri;
- (instancetype)initWithExampleImageURL:(NSURL *)url;

@property (nonatomic, readonly) NSString *imagePath;
- (NSURL *)imageURLWithLength:(NSInteger)length;

@end
NS_ASSUME_NONNULL_END