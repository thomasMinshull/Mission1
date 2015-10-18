//
//  DetailsViewController.m
//  MissionPossible
//
//  Created by thomas minshull on 2015-10-17.
//  Copyright © 2015 Tom m. All rights reserved.
//

#import "DetailsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailsViewController ()

@property (strong, nonatomic) IBOutlet UILabel *showName;
@property (strong, nonatomic) IBOutlet UIImageView *showImage;
@property (strong, nonatomic) IBOutlet UITextView *showDiscription;

- (NSString *)cleanedString:(NSString *)dirtyString;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showName.text = _show.name;
    self.showDiscription.text = [self cleanedString: self.show.showDescription];
    NSURL *url = [NSURL URLWithString:self.show.thumbnailURL];
    [self.showImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Meow"]];
    
}

- (NSString *)cleanedString:(NSString *)dirtyString {
   // NSString *mutableString = [[NSString alloc] initWithString:dirtyString];
    dirtyString = [dirtyString stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    dirtyString = [dirtyString stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    return dirtyString;
}
@end
