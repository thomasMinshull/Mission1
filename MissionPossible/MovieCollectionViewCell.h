//
//  MovieCollectionViewCell.h
//  MissionPossible
//
//  Created by thomas minshull on 2015-12-03.
//  Copyright © 2015 Tom m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVShow.h"

@interface MovieCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) TVShow *show;
@property (strong, nonatomic) UILabel *label;

-(void)setCellSubviews;
@end
