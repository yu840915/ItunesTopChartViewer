//
//  AlbumMeta.m
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import "AlbumMeta.h"
#import "NSDictionary+NullValueFilter.h"

@implementation AlbumMeta

+ (instancetype)albumMetaWithJSONObject:(NSDictionary *)obj
                         coverImageMeta:(ImageMeta *)imageMeta {
    return [[[self class] alloc] initWithTitle:[[obj dictionaryForKey:@"im:name"] stringForKey:@"label"]
                                       artists:[[obj dictionaryForKey:@"im:artist"] stringForKey:@"label"]
                                coverImageMeta:imageMeta];
}

- (instancetype)initWithTitle:(NSString *)title
                      artists:(NSString *)artists
               coverImageMeta:(ImageMeta *)imageMeta {
    NSParameterAssert(title);
    NSParameterAssert(imageMeta);
    self = [super init];
    if (self) {
        _title = [title copy];
        _coverImageMeta = imageMeta;
        [self setUpArtistsWithDefaultOrInputArtists:artists];
    }
    return self;
}

- (void)setUpArtistsWithDefaultOrInputArtists:(NSString *)artists {
    _artists = artists ? [artists copy] : @"Unknown artists";
}

@end
