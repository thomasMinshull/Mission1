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

- (void)fetchTVShowsByPage:(int)page { // need to implement page
    NSLog(@"fetchTVShowxByPage called");
    
    NSString *urlAsString = [[@"http://api.tvmaze.com/shows/" stringByAppendingString: [NSString stringWithFormat:@"%i",page + 1]] stringByAppendingString: @"/episodes"];
    
    // Fetch from the API
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection
     sendAsynchronousRequest: urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] > 0 && error == nil) {
             NSLog(@"data retreved in TVShowManager completion block");
             NSError *error = nil;
             
             id jsonObject = [NSJSONSerialization
                              JSONObjectWithData: data
                              options: NSJSONReadingAllowFragments
                              error: &error];
             if(jsonObject != nil && error == nil){
                 NSLog(@"sucess JSON Deserialized!");
                 NSLog(@"Deserialized JSON: %@", jsonObject);
                 
                 if([jsonObject isKindOfClass:[NSDictionary class]]){
                     
                     NSLog(@"error jsonObject returned NSDictionary, expecting array, see TVShowManger.m");
                     
                 }
                 else if([jsonObject isKindOfClass:[NSArray class]]){
                     NSMutableArray *tvShows = [[NSMutableArray alloc] init];
                     
                     for (NSDictionary *jsonDictionary in jsonObject) {
                         //TODO Check if jsonObject null and check to
                         TVShow *show = [[TVShow alloc] init];
                         NSString *name = jsonDictionary[@"name"];
                         if (name != (NSString *)[NSNull null]) {
                             show.name = name;
                         } else {
                             show.name = @"";
                         }
                         NSString *description = jsonDictionary[@"summary"];
                         if (description != (NSString *)[NSNull null] && description.length > 0) {
                             show.showDescription = description;
                         } else {
                             show.showDescription = @"";
                         }
                         NSDictionary *imageDictionary = jsonDictionary[@"image"];
                         if (imageDictionary != (NSDictionary *)[NSNull null]) {
                             if (imageDictionary.allKeys.count > 0) {
                                 NSString *imageURL = jsonDictionary[@"image"][@"original"];
                                 if (imageURL != (NSString *)[NSNull null]) {
                                     show.imageURL = imageURL;
                                 } else {
                                     show.imageURL = @"";
                                 }
                                 NSString *thumbnailURL = jsonDictionary[@"image"][@"medium"];
                                 if (thumbnailURL != (NSString *)[NSNull null]) {
                                     show.thumbnailURL = imageURL;
                                 } else {
                                     show.thumbnailURL = @"";
                                 }
                             } else {
                                 show.imageURL = @"";
                                 show.thumbnailURL = @"";
                             }
                         } else {
                             show.imageURL = @"";
                             show.thumbnailURL = @"";
                         }
                         [tvShows addObject:show];
                     }

                        [self.delegate tvShowsFetched:tvShows];
                 }
             }
             else if (error != nil){
                 NSLog(@"An error happened while deserializing the JSON Data");
             }
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Nothing was downloaded.");
         }
         else if (error != nil){
             NSLog(@"Error hapened = %@", error);
         }
     }];
}

@end
