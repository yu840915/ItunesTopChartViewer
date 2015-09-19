//
//  ImageMeta.m
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import "ImageMeta.h"
#import "NSDictionary+NullValueFilter.h"

@interface ImageMeta () {
    NSURLComponents *_components;
}

@end

@implementation ImageMeta

+ (instancetype)imageMetaWithJSONObject:(NSDictionary *)obj {
    NSDictionary *imageDTO = [[obj arrayForKey:@"im:image"] firstObject];
    NSString *imageURI = [imageDTO stringForKey:@"label"];
    return [[[self class] alloc] initWithExampleImageURI:imageURI];
}

- (instancetype)initWithExampleImageURL:(NSURL *)url {
    NSParameterAssert(url);
    if (self) {
        _components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
        _imagePath = [_components.path stringByDeletingLastPathComponent];
        _components.path = nil;
    }
    return self;
}

- (instancetype)initWithExampleImageURI:(NSString *)uri {
    return [self initWithExampleImageURL:[NSURL URLWithString:uri]];
}

- (NSURL *)imageURLWithLength:(NSInteger)length {
    NSAssert(length > 0, @"Length must be greater than 0.");
    NSURLComponents *components = [_components copy];
    components.path = [self fullPathWithLength:length];
    return components.URL;
}

- (NSString *)fullPathWithLength:(NSInteger)length {
    return [_imagePath stringByAppendingPathComponent:[self createLastComponentPathWithLength:length]];
}

- (NSString *)createLastComponentPathWithLength:(NSInteger)length {
    return [NSString stringWithFormat:@"%@x%@bb-85.jpg", @(length), @(length)];
}

@end
