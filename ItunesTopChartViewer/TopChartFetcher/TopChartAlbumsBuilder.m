//
//  TopChartAlbumsBuilder.m
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import "TopChartAlbumsBuilder.h"
#import "AlbumMeta.h"
#import "NSDictionary+NullValueFilter.h"

@implementation TopChartAlbumsBuilder

- (instancetype)initWithJSONObjectFromItunes:(NSDictionary *)obj {
    NSParameterAssert(obj);
    self = [super init];
    if (self) {
        _topChartAlbums = [self buildTopChartAlbumsFromJSONObject:obj];
    }
    return self;
}

- (NSArray *)buildTopChartAlbumsFromJSONObject:(NSDictionary *)obj {
    NSArray *albumDTOs = [self extractAlbumsDTOsFromJSONObject:obj];
    return [self buildAlbumsFromAlbumDTOs:albumDTOs];
}

- (NSArray *)extractAlbumsDTOsFromJSONObject:(NSDictionary *)obj {
    return [[obj dictionaryForKey:@"feed"] arrayForKey:@"entry"];
}

- (NSArray *)buildAlbumsFromAlbumDTOs:(NSArray *)albumDTOs {
    NSMutableArray *albums = [NSMutableArray array];
    for (NSDictionary *item in albumDTOs) {
        [albums addObject:[AlbumMeta albumMetaWithJSONObject:item]];
    }
    return [albums copy];
}

@end
