//
//  AlbumMeta.m
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import "AlbumMeta.h"
#import "NSDictionary+NullValueFilter.h"
#import "ImageMeta.h"

@implementation AlbumMeta

+ (instancetype)albumMetaWithJSONObject:(NSDictionary *)obj {
    return [[[self class] alloc] initWithTitle:[[obj dictionaryForKey:@"im:name"] stringForKey:@"label"]
                                       artists:[[obj dictionaryForKey:@"im:artist"] stringForKey:@"label"]
                                coverImageMeta:[ImageMeta imageMetaWithJSONObject:obj]];
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
        [self setUpIdentifier];
    }
    return self;
}

- (void)setUpArtistsWithDefaultOrInputArtists:(NSString *)artists {
    _artists = artists ? [artists copy] : @"Unknown artists";
}

- (void)setUpIdentifier {
    _identifier = [NSString stringWithFormat:@"%@%@%@", _title, _coverImageMeta.imagePath, _artists];
}

@end
