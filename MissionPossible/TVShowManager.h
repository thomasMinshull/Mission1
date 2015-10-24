//
//  TVShowManager.h
//  MissionPossible
//
//  Created by thomas minshull on 2015-10-17.
//  Copyright © 2015 Tom m. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TVShowManagerDelegate <NSObject>

@required

- (void)tvShowsFetched:(NSArray *)tvData;
- (void)reloadFirstPage:(NSArray *)tvData;

@end

@interface TVShowManager : NSObject {
    id <TVShowManagerDelegate> _delegate;
}

@property (nonatomic, strong) id delegate;

- (void)fetchTVShowsByPage:(int)page;

@end
