//
//  CollectionCellViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CollectionCellViewModel.h"

// Classes
#import "CollectionCellModel.h"

@interface CollectionCellViewModel()

// properties
@property (strong, nonatomic) CollectionCellModel* model;

@property (strong, nonatomic) NSArray* colle;

// methods

@end

@implementation CollectionCellViewModel

#pragma mark - Properties -

- (CollectionCellModel*) model
{
    if ( _model == nil )
    {
        _model = [CollectionCellModel new];
    }
    
    return _model;
}

#pragma mark - UICollectionViewDataSource methods -

- (NSInteger) numberOfSectionsInCollectionView: (UICollectionView*) collectionView
{
    return 1;
}

- (NSInteger) collectionView: (UICollectionView*) collectionView
      numberOfItemsInSection: (NSInteger)         section
{
    return 8;
}

- (UICollectionViewCell*) collectionView: (UICollectionView*) collectionView
                  cellForItemAtIndexPath: (NSIndexPath*)      indexPath
{
    return [self.model createCellForCollectionView: collectionView
                                      forIndexPath: indexPath];
}

- (void)  collectionView: (UICollectionView*) collectionView
didSelectItemAtIndexPath: (NSIndexPath*)      indexPath
{
    
}

- (CGSize) collectionView: (UICollectionView*)       collectionView
                   layout: (UICollectionViewLayout*) collectionViewLayout
   sizeForItemAtIndexPath: (NSIndexPath*)            indexPath
{    
    return CGSizeMake((collectionView.width - 1) / 2, 58);
}

#pragma mark - UICollectionViewDelegate methods -



@end
