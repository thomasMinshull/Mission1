//
//  ViewController.h
//  MissionPossible
//
//  Created by thomas minshull on 2015-10-16.
//  Copyright © 2015 Tom m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVShowManager.h"


@interface TVShowViewControllerWithTableView : UIViewController <TVShowManagerProtocol ,UITableViewDataSource, UITableViewDelegate>
@end

