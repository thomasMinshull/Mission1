//
//  MovieCollectionViewCell.m
//  MissionPossible
//
//  Created by thomas minshull on 2015-12-03.
//  Copyright © 2015 Tom m. All rights reserved.
//

#import "MovieCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MovieCollectionViewCell

-(void)setCellSubviews {
    NSURL *url = [NSURL URLWithString:self.show.thumbnailURL];
    UIImageView *cellImageView = (UIImageView *)[self viewWithTag:100];
    [cellImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Image"]];
    self.backgroundView = cellImageView;
    self.label = (UILabel *)[self viewWithTag:101];
    [self.label setText:self.show.name];

}
@end
