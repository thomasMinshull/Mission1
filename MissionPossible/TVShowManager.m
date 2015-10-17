//
//  TVShowManager.m
//  MissionPossible
//
//  Created by thomas minshull on 2015-10-17.
//  Copyright © 2015 Tom m. All rights reserved.
//

#import "TVShowManager.h"
#import "TVShow.h"

@implementation TVShowManager

- (void)fetchTVShowsByPage:(int)page {
    NSLog(@"fetchTVShowxByPage called");
   
    NSMutableArray *tvShows = [[NSMutableArray alloc] init];
    TVShow *show1 = [[TVShow alloc] init];
    show1.name = @"Kirby Buckets";
    show1.imageURL = @"http://www.tvmaze.com/shows/250/kirby-buckets";
    show1.showDescription = @"The single-camera series that mixes live-action and animation stars Jacob Bertrand as the title character. <strong><em>\"Kirby Buckets\"</em></strong> introduces viewers to the vivid imagination of charismatic 13-year-old Kirby Buckets, who dreams of becoming a famous animator like his idol, Mac MacCallister. With his two best friends, Fish and Eli, by his side, Kirby navigates his eccentric town of Forest Hills where the trio usually find themselves trying to get out of a predicament before Kirby's sister, Dawn, and her best friend, Belinda, catch them. Along the way, Kirby is joined by his animated characters, each with their own vibrant personality that only he and viewers can see.";
    
    TVShow *show2 = [[TVShow alloc] init];
    show2.name = @"Downton Abbey";
    show2.imageURL = @"http://www.tvmaze.com/shows/251/downton-abbey";
    show2.showDescription = @"The Downton Abbey estate stands a splendid example of confidence and mettle, its family enduring for generations and its staff a well-oiled machine of propriety. But change is afoot at Downton — change far surpassing the new electric lights and telephone. A crisis of inheritance threatens to displace the resident Crawley family, in spite of the best efforts of the noble and compassionate Earl, Robert Crawley ; his American heiress wife, Cora his comically implacable, opinionated mother, Violet and his beautiful, eldest daughter, Mary, intent on charting her own course. Reluctantly, the family is forced to welcome its heir apparent, the self-made and proudly modern Matthew Crawley himself none too happy about the new arrangements. As Matthew's bristly relationship with Mary begins to crackle with electricity, hope for the future of Downton's dynasty takes shape. But when petty jealousies and ambitions grow among the family and the staff, scheming and secrets — both delicious and dangerous — threaten to derail the scramble to preserve Downton Abbey. Created and written by Oscar-winner Julian Fellowes, <em>Downton Abbey</em> offers a spot-on portrait of a vanishing way of life.";
    
    [tvShows addObject:show1];
    [tvShows addObject:show2];
     
    [self.delegate tvShowsFetched:tvShows];
    
}

@end
