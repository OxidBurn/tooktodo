//
//  OnPlabCollectionCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OnPlanCollectionCellFactory.h"

// Classes
#import "OnPlanCollectionCell.h"

@implementation OnPlanCollectionCellFactory

#pragma mark - Public -

- (ParentCollectionCell*) returnOnPlanCellWithContent: (TaskCollectionCellsContent*) content
                                    forCollectionView: (UICollectionView*)           collection
                                        withIndexPath: (NSIndexPath*)                indexPath
                                         withDelegate: (id<ParentCollectionCellDelegate>) delegate
{
    OnPlanCollectionCell* cell = [collection dequeueReusableCellWithReuseIdentifier: content.cellId
                                                                       forIndexPath: indexPath];
    
    [cell fillCellWithContent: content];
    
    cell.delegate = delegate;
    
    return cell;
}

@end
