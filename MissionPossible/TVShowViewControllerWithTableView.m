//
//  ViewController.m
//  MissionPossible
//
//  Created by thomas minshull on 2015-10-16.
//  Copyright © 2015 Tom m. All rights reserved.
//

#import "TVShowViewControllerWithTableView.h"
#import "DetailsViewController.h"
#import "TVShow.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"

@interface TVShowViewControllerWithTableView (){
    __block NSMutableArray *tableViewData;
    TVShowManager *tvShowManager;
    TVShow *aShow;
    __block int page;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TVShowViewControllerWithTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    tableViewData = [[NSMutableArray alloc] init];
    tvShowManager = [[TVShowManager alloc] init];
    tvShowManager.delegate = self;
    page = 0;

    // I call MBProgressHud showHudAddedTo here but turn it off in the "- (void)tvShowsFetched:(NSArray *)tvData" method,
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *loadingMessage = @"Loading Data";
    hud.labelText = loadingMessage;
    [tvShowManager fetchTVShowsByPage:page];
    
    // Pull to refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        page = 0;
        [tvShowManager fetchTVShowsByPage:page];
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        page++;
        [tvShowManager fetchTVShowsByPage:page];
        [self.tableView.infiniteScrollingView stopAnimating];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark -tableView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    aShow = tableViewData[indexPath.row];
    [self performSegueWithIdentifier:@"detailsSegue" sender:self];
}

# pragma mark -segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailsViewController *vc = [segue destinationViewController];
    vc.show = aShow;
}


# pragma mark -datasource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableViewData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    TVShow *showToDisplay = tableViewData[indexPath.row];
    
    NSURL *url = [NSURL URLWithString:showToDisplay.thumbnailURL];
    [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Image"]];

    if (showToDisplay == nil) { //TODO check that perameters arn't nil
        return nil;
    } else {
        if (showToDisplay.name != nil) {
            cell.textLabel.text = showToDisplay.name;
        } else {
            cell.textLabel.text = @"Error, showToDisplay.name = nil";
        }
    }
    return cell;
}


# pragma mark -Custom Methods
- (void)tvShowsFetched:(NSArray *)tvData {
    if (page == 0) {
        [tableViewData removeAllObjects];
    }
    for (TVShow *show in tvData) {
        [tableViewData addObject:show];
    }
    [self.tableView reloadData];
    // stop all the animations
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.tableView.pullToRefreshView stopAnimating];
    [self.tableView.infiniteScrollingView stopAnimating];
}


@end
