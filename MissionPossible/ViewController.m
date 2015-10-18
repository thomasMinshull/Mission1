//
//  ViewController.m
//  MissionPossible
//
//  Created by thomas minshull on 2015-10-16.
//  Copyright © 2015 Tom m. All rights reserved.
//

#import "ViewController.h"
#import "TVShowManager.h"
#import "TVShow.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DetailsViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController (){
    NSMutableArray *tableViewData;
    TVShowManager *tvShowManager;
    TVShow *aShow;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.tableView.delegate = self;
    tableViewData = [[NSMutableArray alloc] init];
    tvShowManager = [[TVShowManager alloc] init];
    tvShowManager.delegate = self; 
    [tvShowManager fetchTVShowsByPage:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma -tableView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    aShow = tableViewData[indexPath.row];
    [self performSegueWithIdentifier:@"detailsSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DetailsViewController *vc = [segue destinationViewController];
    vc.show = aShow;
}

# pragma mark -TVShowDelegate

- (void)tvShowsFetched:(NSArray *)tvData{
    for (TVShow *show in tvData) {
        NSLog(@"tv show name= %@", show.name);
        [tableViewData addObject:show];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.tableView reloadData];
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
    
    NSLog(@"%@", showToDisplay.thumbnailURL);
    NSURL *url = [NSURL URLWithString:showToDisplay.thumbnailURL];
    [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Image"]];

    if (showToDisplay == nil) { //TODO check that perameters arn't nil
        return nil;
    }
    else {
        if (showToDisplay.name != nil) {
            cell.textLabel.text = showToDisplay.name;
        }
        else {
            cell.textLabel.text = @"Error, showToDisplay.name = nil";
        }
    }
    
    return cell;
}

@end
