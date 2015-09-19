//
//  TopChartViewController.m
//  ItunesTopChartViewer
//
//  Created by small on 9/19/15.
//  Copyright © 2015 YLS. All rights reserved.
//

#import "TopChartViewController.h"
#import "TopChartFlowLayout.h"
#import "TopChartItemCell.h"
#import "TopChartFetcher.h"
#import "AlbumMeta.h"
#import <AFNetworking/AFNetworking.h>
#import "ImageMeta.h"

@interface TopChartViewController () {
    TopChartFetcher *_topChartFetcher;
    NSArray *_albums;
    NSDictionary *_albumIDIndexPathMap;
    NSURLSession *_session;
}
@property (nonatomic, readonly) UICollectionViewFlowLayout *myFlowLayout;
@end

@implementation TopChartViewController

static NSString * const reuseIdentifier = @"TopChartItemCellID";

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _topChartFetcher = [[TopChartFetcher alloc] init];
        [self registerFetcherNotifications];
        [_topChartFetcher fetchTopChart];
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

- (void)registerFetcherNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleFetcherDidUpdateTopChartAlbumsNotification:)
                                                 name:TopChartFetcherDidUpdateTopAlbumsChartNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleFetcherFailureNotification:)
                                                 name:TopChartFetcherFetchFailureNotification
                                               object:nil];
}

- (void)handleFetcherDidUpdateTopChartAlbumsNotification:(NSNotification *)notification {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self prepareTopChartAlbumsAndUpdateUI];
    }];
}

- (void)prepareTopChartAlbumsAndUpdateUI {
    _albums = [_topChartFetcher.topChartAlbums copy];
    _albumIDIndexPathMap = [self mapAlbumIDToIndexPathForAlbums:_albums];
    [self.collectionView reloadData];
}

- (NSDictionary *)mapAlbumIDToIndexPathForAlbums:(NSArray *)albums {
    NSMutableDictionary *results = [NSMutableDictionary dictionary];
    [albums enumerateObjectsUsingBlock:^(AlbumMeta *album, NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
        results[album.identifier] = indexPath;
    }];
    return [results copy];
}

- (void)handleFetcherFailureNotification:(NSNotification *)notification {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self showAlertForError:notification.userInfo[TopChartFetcherFetchFailureError]];
    }];
}

- (void)showAlertForError:(NSError *)error {
    NSString *reason = error.localizedFailureReason ? error.localizedFailureReason : error.localizedDescription;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice"
                                                    message:reason
                                                   delegate:nil
                                          cancelButtonTitle:@"Dismiss"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.collectionViewLayout = [[TopChartFlowLayout alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return [_albums count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TopChartItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                       forIndexPath:indexPath];
    AlbumMeta *meta = [self albumMetaForIndexPath:indexPath];
    cell.titleLabel.text = meta.title;
    cell.subtitleLabel.text = meta.artists;
    cell.imageView.image = nil;
    [self loadCoverImageForAlbumMeta:meta];
    return cell;
}

- (void)loadCoverImageForAlbumMeta:(AlbumMeta *)meta {
    __weak TopChartViewController *weakSelf = self;
    NSURLSessionTask *task = [_session dataTaskWithURL:[meta.coverImageMeta imageURLWithLength:320]
                                     completionHandler:
                              ^(NSData *data, NSURLResponse *response, NSError * error) {
                                  TopChartViewController *strongSelf = weakSelf;
                                  if (strongSelf) {
                                      [strongSelf setImageData:data forAlbumMeta:meta];
                                  }
                              }];
    [task resume];
}

- (void)setImageData:(NSData *)data
        forAlbumMeta:(AlbumMeta *)meta {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        TopChartItemCell *cell = [self cellForAlbumMeta:meta];
        cell.imageView.image = [UIImage imageWithData:data];
    }];
}

- (TopChartItemCell *)cellForAlbumMeta:(AlbumMeta *)meta {
    return (TopChartItemCell *)[self.collectionView cellForItemAtIndexPath:[self indexPathForAlbumMeta:meta]];
}

- (AlbumMeta *)albumMetaForIndexPath:(NSIndexPath *)indexPath {
    return _albums[indexPath.row];
}

- (NSIndexPath *)indexPathForAlbumMeta:(AlbumMeta *)meta {
    return _albumIDIndexPathMap[meta.identifier];
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView
shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
