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

@interface ViewController (){
    NSMutableArray *tableViewData;
    TVShowManager *tvShowManager;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    dataSource = [[NSMutableArray alloc] initWithArray: @[@"first", @"second", @"third"]];
//
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
    [self performSegueWithIdentifier:@"detailsSegue" sender:self];
}


# pragma mark -TVShowDelegate 

- (void)tvShowsFetched:(NSArray *)tvData{
    for (TVShow *show in tvData) {
        NSLog(@"tv show name= %@", show.name);
        [tableViewData addObject:show];
    }
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
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    TVShow *showToDisplay = tableViewData[indexPath.row];
    
//    if (showToDisplay == nil) { //TODO check that perameters arn't nil
//        return nil;
//    }
    
    cell.textLabel.text = showToDisplay.name;
    NSURL *url = [NSURL URLWithString:showToDisplay.imageURL];
    //SD Web image cocoa pod.
    //cell.imageView.image = showToDisplay.imageURL
    
    return cell;
}

@end
