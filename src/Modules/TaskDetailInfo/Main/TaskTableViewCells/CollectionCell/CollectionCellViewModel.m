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
#import "ParentCollectionCell.h"

typedef NS_ENUM(NSUInteger, CollectionCellTypes)
{
    TermsCellType       = 0,
    DateCellType        = 1,
    RoomCellType        = 2,
    OnPlaneCellType     = 3,
    CreatorCellType     = 4,
    ResponsibleCellType = 5,
    ApproverCellType    = 6,
    ObserverCellType    = 7,
};

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


#pragma mark - Public -

- (void) fillParentCollectionCellDelegate: (id<ParentCollectionCellDelegate>) delegate
{
    [self.model fillParentCollectionCellDelegate: delegate];
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
                                      forIndexPath: indexPath
                                      withDelegate: [self.model getVarToStoreParentCollectionCellDelegate]];
}

- (void)  collectionView: (UICollectionView*) collectionView
didSelectItemAtIndexPath: (NSIndexPath*)      indexPath
{
    ParentCollectionCell* cell = (ParentCollectionCell*)[collectionView cellForItemAtIndexPath: indexPath];
    
    if ([cell.delegate respondsToSelector: @selector(performSegueToUsersListWithSegueID:)])
    {
        switch (indexPath.row)
        {
            case CreatorCellType:
            {
                //uncomment when segue to creator will be implemented
//                [cell.delegate performSegueToUsersListWithSegueID: @""];
            }
                break;
            case ResponsibleCellType:
            {
                //uncomment when segue to responsible will be implemented
//                [cell.delegate performSegueToUsersListWithSegueID: @""];
            }
                break;
            case ApproverCellType:
            {
                [cell.delegate performSegueToUsersListWithSegueID: @"ShowApprovers"];
            }
                break;
            case ObserverCellType:
            {
                //uncomment when segue to observers will be implemented
//                [cell.delegate performSegueToUsersListWithSegueID: @""];
            }
                break;
            default:
                break;
        }
    
    }
}

- (CGSize) collectionView: (UICollectionView*)       collectionView
                   layout: (UICollectionViewLayout*) collectionViewLayout
   sizeForItemAtIndexPath: (NSIndexPath*)            indexPath
{    
    return CGSizeMake((collectionView.width - 1) / 2, 58);
}

#pragma mark - UICollectionViewDelegate methods -



@end
