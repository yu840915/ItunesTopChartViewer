//
//  AlbumCoverImageFetcher.m
//  ItunesTopChartViewer
//
//  Created by small on 9/20/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import "AlbumCoverImageFetcher.h"
#import "AlbumMeta.h"
#import "ImageMeta.h"

@interface AlbumCoverImageFetcher () {
    NSInteger _defaultSize;
    NSURLSession *_urlSession;
}

@end

@implementation AlbumCoverImageFetcher

- (instancetype)initWithPreferedImageSize:(NSInteger)size {
    NSAssert(size > 0, @"Image size should be greater than 0");
    self = [super init];
    if (self) {
        _defaultSize = size;
        [self setUpURLSession];
    }
    return self;
}

- (void)setUpURLSession {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _urlSession = [NSURLSession sessionWithConfiguration:config];
}

- (void)fetchCoverImageForAlbumMeta:(AlbumMeta *)meta
                         completion:(void (^)(NSData *, NSError *))completion {
    [self fetchCoverImageOfSize:_defaultSize forAlbumMeta:meta completion:completion];
}

- (void)fetchCoverImageOfSize:(NSInteger)size
                 forAlbumMeta:(AlbumMeta *)meta
                   completion:(void(^)(NSData *imageData, NSError *error))completion {
    __weak AlbumCoverImageFetcher *weakSelf = self;
    NSURLSessionTask *task =
    [_urlSession dataTaskWithURL:[self imageURLOfSize:size forAlbumMeta:meta]
               completionHandler:
     ^(NSData *data, NSURLResponse *response, NSError * error) {
         AlbumCoverImageFetcher *strongSelf = weakSelf;
         if (strongSelf) {
             [strongSelf handleTaskCompletionWithHTTPResponse:(NSHTTPURLResponse *)response
                                                         data:data
                                                        error:error
                                             clientCompletion:completion];
         }
     }];
    [task resume];
}

- (NSURL *)imageURLOfSize:(NSInteger)size
             forAlbumMeta:(AlbumMeta *)meta {
    return [meta.coverImageMeta imageURLWithLength:size];
}

- (void)handleTaskCompletionWithHTTPResponse:(NSHTTPURLResponse *)response
                                        data:(NSData *)data
                                       error:(NSError *)error
                            clientCompletion:(void (^)(NSData *, NSError *))completion {
    NSError *finalError = error;
    if (response.statusCode != 200) {
        finalError = [self createErrorForFailureHTTPResponse:response];
    }
    if (completion) {
        completion(data, error);
    }
}

- (NSError *)createErrorForFailureHTTPResponse:(NSHTTPURLResponse *)response {
    return [NSError errorWithDomain:@"AppDomain"
                               code:response.statusCode
                           userInfo:@{NSLocalizedDescriptionKey : [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode]}];
}

@end
