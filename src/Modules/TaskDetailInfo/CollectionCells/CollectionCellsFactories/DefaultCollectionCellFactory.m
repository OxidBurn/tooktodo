//
//  DefaultCollectionCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 05.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DefaultCollectionCellFactory.h"

// Classes
#import "DefaultCollectionCell.h"

@implementation DefaultCollectionCellFactory


#pragma mark - Public -

- (ParentCollectionCell*) returnDefaultCellWithContent: (TaskCollectionCellsContent*)      content
                                     forCollectionView: (UICollectionView*)                collection
                                         withIndexPath: (NSIndexPath*)                     indexPath
                                          withDelegate: (id<ParentCollectionCellDelegate>) delegate
{
    DefaultCollectionCell* cell = [collection dequeueReusableCellWithReuseIdentifier: content.cellId
                                                                        forIndexPath: indexPath];
    
    [cell fillCellWithContent: content];
    
    cell.delegate = delegate;
    
    return cell;
}

@end
