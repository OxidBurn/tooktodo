//
//  GroupOfUsersCollectionFactory.m
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "GroupOfUsersCollectionFactory.h"

// Classes
#import "GroupOfUsersCollectionCell.h"

@implementation GroupOfUsersCollectionFactory

#pragma mark - Public -

- (UICollectionViewCell*) returnGroupOfUsersCellWithContent: (TaskCollectionCellsContent*) content
                                          forCollectionView: (UICollectionView*)           collection
                                              withIndexPath: (NSIndexPath*)                indexPath
{
    GroupOfUsersCollectionCell* cell = [collection dequeueReusableCellWithReuseIdentifier: content.cellId
                                                                       forIndexPath: indexPath];
    
    [cell fillCellWithContent: content];
    
    return cell;
}

@end
