//
//  TVShowManager.h
//  MissionPossible
//
//  Created by thomas minshull on 2015-10-17.
//  Copyright © 2015 Tom m. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TVShowManagerProtocol <NSObject>

@required

- (void)tvShowsFetched:(NSArray *)tvData;

@end

@interface TVShowManager : NSObject {
    id <TVShowManagerProtocol> _delegate;
}

@property (nonatomic, strong) id delegate;

- (void)fetchTVShowsByPage:(int)page;
- (void)fetchTVShowsByPage:(int)page withCompletion: (void(^)(NSArray *))quebecois; 
- (NSMutableArray *)cleanSerializedJsonObject: (NSObject *) jsonObject;
@end
