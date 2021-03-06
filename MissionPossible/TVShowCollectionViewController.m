//
//  CollectionLayout.m
//  MissionPossible
//
//  Created by thomas minshull on 2015-10-28.
//  Copyright © 2015 Tom m. All rights reserved.
//

#import "TVShowCollectionViewController.h"
#import "DetailsViewController.h"
#import "TVShow.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "MovieCollectionViewCell.h"

@implementation TVShowCollectionViewController {
    __block NSMutableArray *collectionViewData;
    TVShowManager *tvShowManagerCollectionView;//needs to be seporated so both tableView and Collection view are using one TVshowManager
    TVShow *aShow;
    __block int page;
}

-(void)viewDidLoad {
    [super viewDidLoad];

    collectionViewData = [[NSMutableArray alloc] init];
    tvShowManagerCollectionView = [[TVShowManager alloc] init];
    page = 0;
    
    // I call MBProgressHud showHudAddedTo here but turn it off in the "- (void)tvShowsFetched:(NSArray *)tvData" method,
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //initial data fetch
    [tvShowManagerCollectionView fetchTVShowsByPage: page withCompletion:^(NSArray *tvData) {
    [self upDataWithNSArray: tvData];
    }];
    
    // Pull to refresh
    [self.collectionView addPullToRefreshWithActionHandler:^{
        page = 0;
        [tvShowManagerCollectionView fetchTVShowsByPage: page withCompletion:^(NSArray *tvData) {
        [self upDataWithNSArray: tvData];
        }];
    }];
    // infinate scroll
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        page++;
        [tvShowManagerCollectionView fetchTVShowsByPage: page withCompletion:^(NSArray *tvData) {
        [self upDataWithNSArray: tvData];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailsViewController *vc = [segue destinationViewController];
    vc.show = aShow;
}


#pragma mark -TVShowDelegate

- (void)tvShowsFetched:(NSArray *)tvData {
    [self upDataWithNSArray: tvData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    aShow = collectionViewData[indexPath.row];
    [self performSegueWithIdentifier:@"detailsSegue2" sender:nil];
}


# pragma mark -datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return collectionViewData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    TVShow *showToDisplay = (TVShow *)collectionViewData[indexPath.row];
    [cell setShow:showToDisplay];
    return cell;
}


# pragma mark -custom methods


- (void)upDataWithNSArray:(NSArray *)tvData {
    if (page == 0) {
        [collectionViewData removeAllObjects];
    }
    for (TVShow *show in tvData) {
        //NSLog(@"tv show name= %@", show.name);
        [collectionViewData addObject:show];
    }
    [self.collectionView reloadData];
    // stop all the animations
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.collectionView.pullToRefreshView stopAnimating];
    [self.collectionView.infiniteScrollingView stopAnimating];
}

@end
