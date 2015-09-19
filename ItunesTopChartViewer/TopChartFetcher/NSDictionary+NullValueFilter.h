//
//  NSDictionary+NullValueFilter.h
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSDictionary (NullValueFilter)

- (NSDictionary *__nullable)dictionaryForKey:(NSString *)key;
- (NSString *__nullable)stringForKey:(NSString *)key;

@end
NS_ASSUME_NONNULL_END