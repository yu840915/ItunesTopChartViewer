//
//  NSDictionary+NullValueFilter.m
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import "NSDictionary+NullValueFilter.h"

@implementation NSDictionary (NullValueFilter)

- (NSArray *)arrayForKey:(NSString *)key {
    return [self valueOfClassWithName:NSStringFromClass([NSArray class]) forKey:key];
}

- (NSDictionary *)dictionaryForKey:(NSString *)key {
    return [self valueOfClassWithName:NSStringFromClass([NSDictionary class]) forKey:key];
}

- (NSString *)stringForKey:(NSString *)key {
    return [self valueOfClassWithName:NSStringFromClass([NSString class]) forKey:key];
}

- (id)valueOfClassWithName:(NSString *)className
                forKey:(NSString *)key {
    id value = self[key];
    return [value isKindOfClass:NSClassFromString(className)] ? value : nil;
}

@end
