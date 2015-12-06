//
//  MovieCollectionViewCell.m
//  MissionPossible
//
//  Created by thomas minshull on 2015-12-03.
//  Copyright © 2015 Tom m. All rights reserved.
//

#import "MovieCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MovieCollectionViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *movieImage;
@property (strong, nonatomic) IBOutlet UILabel *movieLabel;
@end

@implementation MovieCollectionViewCell

-(void)setShow:(TVShow *)show {
    if (show != nil) {
        _show = show;
        NSURL *url = [NSURL URLWithString:self.show.thumbnailURL];
        [self.movieImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Image"]];
        [self.movieLabel setText:self.show.name];
    }
}


@end
