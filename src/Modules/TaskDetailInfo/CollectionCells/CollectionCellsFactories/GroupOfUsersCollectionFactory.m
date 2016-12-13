//
//  GroupOfUsersCollectionFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "GroupOfUsersCollectionFactory.h"

// Classes
#import "GroupOfUsersCollectionCell.h"

@implementation GroupOfUsersCollectionFactory

#pragma mark - Public -

- (ParentCollectionCell*) returnGroupOfUsersCellWithContent: (TaskCollectionCellsContent*) content
                                          forCollectionView: (UICollectionView*)           collection
                                              withIndexPath: (NSIndexPath*)                indexPath
                                               withDelegate: (id<ParentCollectionCellDelegate>) delegate
{
    GroupOfUsersCollectionCell* cell = [collection dequeueReusableCellWithReuseIdentifier: content.cellId
                                                                             forIndexPath: indexPath];
    
    [cell fillCellWithContent: content];
    
    cell.delegate = delegate;
    
    return cell;
}

@end
