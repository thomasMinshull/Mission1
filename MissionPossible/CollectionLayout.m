//
//  CollectionLayout.m
//  MissionPossible
//
//  Created by thomas minshull on 2015-10-28.
//  Copyright © 2015 Tom m. All rights reserved.
//

#import "CollectionLayout.h"

@implementation CollectionLayout

-(void)viewDidLoad {
    [super viewDidLoad];
    
    photosForSetup = [[NSArray alloc]initWithObjects:@"angry_birds_cake.jpg", @"egg_benedict.jpg", nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return photosForSetup.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[photosForSetup objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"detailsSegue2" sender:nil];
}

@end
