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

- (UICollectionViewCell*) returnSingleUserCellWithContent: (TaskCollectionCellsContent*) content
                                        forCollectionView: (UICollectionView*)           collection
                                            withIndexPath: (NSIndexPath*)                indexPath
{
    SingleUserCollectionCell* cell = [collection dequeueReusableCellWithReuseIdentifier: content.cellId
                                                                       forIndexPath: indexPath];
    
    [cell fillCellWithContent: content];
    
    return cell;
}

@end
