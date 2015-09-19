//
//  TopChartAlbumsBuilder.h
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopChartAlbumsBuilder : NSObject

- (instancetype)initWithJSONObjectFromItunes:(NSDictionary *)obj;

@property (nonatomic, readonly) NSArray *topChartAlbums;

@end
