//
//  ImageMetaTests.m
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ImageMeta.h"

@interface ImageMetaTests : XCTestCase {
}

@end

@implementation ImageMetaTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIllegalInit {
    XCTAssertThrows([[ImageMeta alloc] initWithExampleImageURI:nil]);
    XCTAssertThrows([[ImageMeta alloc] initWithExampleImageURL:nil]);
}

- (void)testInitWithIllegalURI {
    XCTAssertThrows([[ImageMeta alloc] initWithExampleImageURI:@"Hello world!"]);
    XCTAssertThrows([[ImageMeta alloc] initWithExampleImageURI:@"http://is5.mzstatic.com/image/thumb/Features/v4/9e/1a/f9/9e1af90f-2d28-4a3f-c082-14027a6e9df5/dj.hbpmuqwc.jpg/55x55bb 85.jpg"]);
}

- (void)testImagePath {
    ImageMeta *meta = [[ImageMeta alloc] initWithExampleImageURI:@"http://is5.mzstatic.com/image/thumb/Features/v4/9e/1a/f9/9e1af90f-2d28-4a3f-c082-14027a6e9df5/dj.hbpmuqwc.jpg/55x55bb-85.jpg"];
    
    XCTAssertEqualObjects(meta.imagePath, @"/image/thumb/Features/v4/9e/1a/f9/9e1af90f-2d28-4a3f-c082-14027a6e9df5/dj.hbpmuqwc.jpg");
}

- (void)testURLCreation {
    ImageMeta *meta = [[ImageMeta alloc] initWithExampleImageURI:@"http://is5.mzstatic.com/image/thumb/Features/v4/9e/1a/f9/9e1af90f-2d28-4a3f-c082-14027a6e9df5/dj.hbpmuqwc.jpg/55x55bb-85.jpg"];
    
    NSURL *url55 = [meta imageURLWithLength:55];
    NSURL *url640 = [meta imageURLWithLength:640];
    XCTAssertEqualObjects(url55.absoluteString, @"http://is5.mzstatic.com/image/thumb/Features/v4/9e/1a/f9/9e1af90f-2d28-4a3f-c082-14027a6e9df5/dj.hbpmuqwc.jpg/55x55bb-85.jpg");
    XCTAssertEqualObjects(url640.absoluteString, @"http://is5.mzstatic.com/image/thumb/Features/v4/9e/1a/f9/9e1af90f-2d28-4a3f-c082-14027a6e9df5/dj.hbpmuqwc.jpg/640x640bb-85.jpg");
}

- (void)testURLCreationWithIllegalArg {
    ImageMeta *meta = [[ImageMeta alloc] initWithExampleImageURI:@"http://is5.mzstatic.com/image/thumb/Features/v4/9e/1a/f9/9e1af90f-2d28-4a3f-c082-14027a6e9df5/dj.hbpmuqwc.jpg/55x55bb-85.jpg"];
    
    XCTAssertThrows([meta imageURLWithLength:0]);
    XCTAssertThrows([meta imageURLWithLength:-1]);
}

- (void)testFactoryMethodWithIllegalArg {
    XCTAssertThrows([ImageMeta imageMetaWithJSONObject:nil]);
}

- (void)testFactoryMethod {
    ImageMeta *meta = [ImageMeta imageMetaWithJSONObject:[self JSONAlbumObject]];
    
    XCTAssertNotNil(meta);
    XCTAssertEqualObjects(meta.imagePath, @"/image/thumb/Features/v4/9e/1a/f9/9e1af90f-2d28-4a3f-c082-14027a6e9df5/dj.hbpmuqwc.jpg");
}

- (id)JSONAlbumObject {
    NSData *data = [[self JSONString] dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data
                                           options:NSJSONReadingAllowFragments
                                             error:NULL];
}

- (NSString *)JSONString {
    return @"{\"im:name\":{\"label\":\"Chopin: Nocturnes\"}, \"im:image\":[{\"label\":\"http://is5.mzstatic.com/image/thumb/Features/v4/9e/1a/f9/9e1af90f-2d28-4a3f-c082-14027a6e9df5/dj.hbpmuqwc.jpg/55x55bb-85.jpg\", \"attributes\":{\"height\":\"55\"}}, {\"label\":\"http://is1.mzstatic.com/image/thumb/Features/v4/9e/1a/f9/9e1af90f-2d28-4a3f-c082-14027a6e9df5/dj.hbpmuqwc.jpg/60x60bb-85.jpg\", \"attributes\":{\"height\":\"60\"}}, {\"label\":\"http://is2.mzstatic.com/image/thumb/Features/v4/9e/1a/f9/9e1af90f-2d28-4a3f-c082-14027a6e9df5/dj.hbpmuqwc.jpg/170x170bb-85.jpg\", \"attributes\":{\"height\":\"170\"}}], \"im:itemCount\":{\"label\":\"19\"}, \"im:price\":{\"label\":\"NT$ 60\", \"attributes\":{\"amount\":\"60.00000\", \"currency\":\"TWD\"}}, \"im:contentType\":{\"im:contentType\":{\"attributes\":{\"term\":\"Album\", \"label\":\"Album\"}}, \"attributes\":{\"term\":\"Music\", \"label\":\"Music\"}}, \"rights\":{\"label\":\"℗ 1967 Sony Music Entertainment\"}, \"title\":{\"label\":\"Chopin: Nocturnes - Arthur Rubinstein\"}, \"link\":{\"attributes\":{\"rel\":\"alternate\", \"type\":\"text/html\", \"href\":\"https://itunes.apple.com/tw/album/chopin-nocturnes/id594180316?uo=2\"}}, \"id\":{\"label\":\"https://itunes.apple.com/tw/album/chopin-nocturnes/id594180316?uo=2\", \"attributes\":{\"im:id\":\"594180316\"}}, \"im:artist\":{\"label\":\"Arthur Rubinstein\", \"attributes\":{\"href\":\"https://itunes.apple.com/tw/artist/arthur-rubinstein/id79980320?uo=2\"}}, \"category\":{\"attributes\":{\"im:id\":\"5\", \"term\":\"Classical\", \"scheme\":\"https://itunes.apple.com/tw/genre/music-classical/id5?uo=2\", \"label\":\"Classical\"}}, \"im:releaseDate\":{\"label\":\"1966-12-31T16:00:00-07:00\", \"attributes\":{\"label\":\"31 December 1966\"}}}";
}


@end
