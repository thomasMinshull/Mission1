//
//  CollectionLayout.h
//  MissionPossible
//
//  Created by thomas minshull on 2015-10-28.
//  Copyright © 2015 Tom m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVShowManager.h"

@interface TVShowCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    NSArray *photosForSetup;
}

@end
