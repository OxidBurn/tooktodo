//
//  TemsInfoCollectionCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TermsInfoCollectionCellFactory.h"

// Classes
#import "TermsInfoCollectionCell.h"


@implementation TermsInfoCollectionCellFactory

#pragma mark - Public -

- (ParentCollectionCell*) returnTermsInfoCellWithContent: (TaskCollectionCellsContent*) content
                                       forCollectionView: (UICollectionView*)           collection
                                           withIndexPath: (NSIndexPath*)                indexPath
                                            withDelegate: (id<ParentCollectionCellDelegate>) delegate;
{
    TermsInfoCollectionCell* cell = [collection dequeueReusableCellWithReuseIdentifier: content.cellId
                                                                       forIndexPath: indexPath];
    
    [cell fillCellWithContent: content];
    
    cell.delegate = delegate;
    
    return cell;
}

@end
