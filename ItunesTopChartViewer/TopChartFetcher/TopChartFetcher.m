//
//  TopChartFetcher.m
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import "TopChartFetcher.h"
#import <AFNetworking/AFNetworking.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "TopChartAlbumsBuilder.h"

#if DEBUG
static DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

@interface TopChartFetcher () {
}

@end

@implementation TopChartFetcher

NSString * const TopChartFetcherFetchFailureNotification = @"TopChartFetcherFetchFailureNotification";
NSString * const TopChartFetcherDidUpdateTopAlbumsChartNotification = @"TopChartFetcherDidUpdateTopAlbumsChartNotification";
NSString * const TopChartFetcherFetchFailureError = @"TopChartFetcherFetchFailureError";

- (void)fetchTopChart {
    [self fetchTopChartWithLimit:20];
}

- (void)fetchTopChartWithLimit:(NSInteger)limit {
    __weak TopChartFetcher *weakSelf = self;
    [[AFHTTPRequestOperationManager manager]
     GET:[self topChartFetingURIWithLimit:limit]
     parameters:nil
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         TopChartFetcher *strongSelf = weakSelf;
         if (strongSelf) {
             [strongSelf handleSuccessForFetchOperation:operation responseBody:responseObject];
         }
     }
     failure:^(AFHTTPRequestOperation *operation, NSError * error) {
         TopChartFetcher *strongSelf = weakSelf;
         if (strongSelf) {
             [strongSelf handleFailureForFetchOperation:operation error:error];
         }
     }];
}

- (NSString *)topChartFetingURIWithLimit:(NSInteger)limit {
    return [NSString stringWithFormat:@"https://itunes.apple.com/tw/rss/topalbums/limit=%@/json", @(limit)];
}

- (void)handleSuccessForFetchOperation:(AFHTTPRequestOperation *)op
                          responseBody:(id)obj {
    TopChartAlbumsBuilder *buildr = [[TopChartAlbumsBuilder alloc] initWithJSONObjectFromItunes:obj];
    _topChartAlbums = buildr.topChartAlbums;
    [[NSNotificationCenter defaultCenter] postNotificationName:TopChartFetcherDidUpdateTopAlbumsChartNotification object:self];
}

- (void)handleFailureForFetchOperation:(AFHTTPRequestOperation *)op
                                 error:(NSError *)error {
    DDLogWarn(@"%@", error);
    [[NSNotificationCenter defaultCenter] postNotificationName:TopChartFetcherFetchFailureNotification
                                                        object:self
                                                      userInfo:@{TopChartFetcherFetchFailureError : error}];
}

@end
