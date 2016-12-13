//
//  SingleUserCollectionCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SingleUserCollectionCellFactory.h"

// Classes
#import "SingleUserCollectionCell.h"

@implementation SingleUserCollectionCellFactory

#pragma mark - Public -

- (ParentCollectionCell*) returnSingleUserCellWithContent: (TaskCollectionCellsContent*) content
                                        forCollectionView: (UICollectionView*)           collection
                                            withIndexPath: (NSIndexPath*)                indexPath
                                             withDelegate: (id<ParentCollectionCellDelegate>) delegate
{
    SingleUserCollectionCell* cell = [collection dequeueReusableCellWithReuseIdentifier: content.cellId
                                                                       forIndexPath: indexPath];
    
    [cell fillCellWithContent: content];
    
    cell.delegate = delegate;
    
    return cell;
}

@end
