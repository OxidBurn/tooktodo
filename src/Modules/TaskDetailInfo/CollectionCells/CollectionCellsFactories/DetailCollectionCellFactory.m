//
//  DetailCollectionCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DetailCollectionCellFactory.h"

// Classes
#import "DetailCollectionCell.h"

@implementation DetailCollectionCellFactory

#pragma mark - Public -

- (ParentCollectionCell*) returnDetailCellWithContent: (TaskCollectionCellsContent*) content
                                    forCollectionView: (UICollectionView*)           collection
                                        withIndexPath: (NSIndexPath*)                indexPath
                                         withDelegate: (id<ParentCollectionCellDelegate>) delegate
{
    DetailCollectionCell* cell = [collection dequeueReusableCellWithReuseIdentifier: content.cellId
                                                                       forIndexPath: indexPath];
    
    [cell fillCellWithContent: content];
    
    cell.delegate = delegate;
    
    return cell;
}

@end
