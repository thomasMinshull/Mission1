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
         if ([data length] >0 && error == nil) {
             NSLog(@"data retreved in TVShowManager completion block");
             NSError *error = nil;
             
             id jsonObject = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:NSJSONReadingAllowFragments
                              error:&error];
             if(jsonObject != nil && error == nil){
                 NSLog(@"sucess JSON Deserialized!");
                 NSLog(@"Deserialized JSON: %@", jsonObject);
                 
                 if([jsonObject isKindOfClass:[NSDictionary class]]){
                     
                     NSLog(@"error jsonObject returned NSDictionary, expecting array, see TVShowManger.m");
                     
                 }
                 else if([jsonObject isKindOfClass:[NSArray class]]){
                     
                     //TODO create a type (object) TVshow, and iterate over this array adding these objects to the array used to store data in the app (aka arrayOfDictionaryDetails.)
                     NSMutableArray *tvShows = [[NSMutableArray alloc] init];
                     
                     for (NSDictionary *jsonDictionary in jsonObject) {
                         TVShow *show = [[TVShow alloc] init];
                         show.name = jsonDictionary[@"name"];
                         show.showDescription = jsonDictionary[@"summary"];
                         show.imageURL = jsonDictionary[@"image"][@"original"];
                         show.thumbnailURL = jsonDictionary[@"image"][@"medium"];
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
