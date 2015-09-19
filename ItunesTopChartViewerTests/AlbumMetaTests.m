//
//  AlbumMetaTests.m
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AlbumMeta.h"
#import "ImageMeta.h"
#import <OCMock/OCMock.h>

@interface AlbumMetaTests : XCTestCase {
    ImageMeta *_imageMetaMock;
    NSDictionary *_jsonAlbumObject;
}

@end

@implementation AlbumMetaTests

- (void)setUp {
    [super setUp];
    _imageMetaMock = OCMClassMock([ImageMeta class]);
    [self setUpJSONAlbumObject];
}

- (void)setUpJSONAlbumObject {
    NSData *data = [[self JSONString] dataUsingEncoding:NSUTF8StringEncoding];
    _jsonAlbumObject = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingAllowFragments
                                                         error:NULL];
}

- (NSString *)JSONString {
    return @"{\"im:name\":{\"label\":\"Chopin: Nocturnes\"}, \"im:image\":[{\"label\":\"http://is5.mzstatic.com/image/thumb/Features/v4/9e/1a/f9/9e1af90f-2d28-4a3f-c082-14027a6e9df5/dj.hbpmuqwc.jpg/55x55bb-85.jpg\", \"attributes\":{\"height\":\"55\"}}, {\"label\":\"http://is1.mzstatic.com/image/thumb/Features/v4/9e/1a/f9/9e1af90f-2d28-4a3f-c082-14027a6e9df5/dj.hbpmuqwc.jpg/60x60bb-85.jpg\", \"attributes\":{\"height\":\"60\"}}, {\"label\":\"http://is2.mzstatic.com/image/thumb/Features/v4/9e/1a/f9/9e1af90f-2d28-4a3f-c082-14027a6e9df5/dj.hbpmuqwc.jpg/170x170bb-85.jpg\", \"attributes\":{\"height\":\"170\"}}], \"im:itemCount\":{\"label\":\"19\"}, \"im:price\":{\"label\":\"NT$ 60\", \"attributes\":{\"amount\":\"60.00000\", \"currency\":\"TWD\"}}, \"im:contentType\":{\"im:contentType\":{\"attributes\":{\"term\":\"Album\", \"label\":\"Album\"}}, \"attributes\":{\"term\":\"Music\", \"label\":\"Music\"}}, \"rights\":{\"label\":\"℗ 1967 Sony Music Entertainment\"}, \"title\":{\"label\":\"Chopin: Nocturnes - Arthur Rubinstein\"}, \"link\":{\"attributes\":{\"rel\":\"alternate\", \"type\":\"text/html\", \"href\":\"https://itunes.apple.com/tw/album/chopin-nocturnes/id594180316?uo=2\"}}, \"id\":{\"label\":\"https://itunes.apple.com/tw/album/chopin-nocturnes/id594180316?uo=2\", \"attributes\":{\"im:id\":\"594180316\"}}, \"im:artist\":{\"label\":\"Arthur Rubinstein\", \"attributes\":{\"href\":\"https://itunes.apple.com/tw/artist/arthur-rubinstein/id79980320?uo=2\"}}, \"category\":{\"attributes\":{\"im:id\":\"5\", \"term\":\"Classical\", \"scheme\":\"https://itunes.apple.com/tw/genre/music-classical/id5?uo=2\", \"label\":\"Classical\"}}, \"im:releaseDate\":{\"label\":\"1966-12-31T16:00:00-07:00\", \"attributes\":{\"label\":\"31 December 1966\"}}}";
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIllegalInit {
    XCTAssertThrows([[AlbumMeta alloc] initWithTitle:nil artists:nil coverImageMeta:nil]);
    XCTAssertThrows([[AlbumMeta alloc] initWithTitle:nil artists:@"my name" coverImageMeta:_imageMetaMock]);
    XCTAssertThrows([[AlbumMeta alloc] initWithTitle:@"my album" artists:@"my name" coverImageMeta:nil]);
}

- (void)testInitWithNoArtists {
    AlbumMeta *meta = [[AlbumMeta alloc] initWithTitle:@"Cool Album" artists:nil coverImageMeta:_imageMetaMock];
    
    XCTAssertEqualObjects(meta.artists, @"Unknown artists");
}

- (void)testIllegalUsageOfFactoryMethod {
    XCTAssertThrows([AlbumMeta albumMetaWithJSONObject:nil coverImageMeta:nil]);
    XCTAssertThrows([AlbumMeta albumMetaWithJSONObject:nil coverImageMeta:_imageMetaMock]);
    XCTAssertThrows([AlbumMeta albumMetaWithJSONObject:_jsonAlbumObject coverImageMeta:nil]);
}

- (void)testCreateFromJSONFactoryMethod {
    AlbumMeta *meta = [AlbumMeta albumMetaWithJSONObject:_jsonAlbumObject coverImageMeta:_imageMetaMock];
    
    XCTAssertEqualObjects(meta.title, @"Chopin: Nocturnes");
    XCTAssertEqualObjects(meta.artists, @"Arthur Rubinstein");
}

@end
