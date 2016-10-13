//
//  TemsInfoCollectionCellFactory.m
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TermsInfoCollectionCellFactory.h"

// Classes
#import "TermsInfoCollectionCell.h"

@implementation TermsInfoCollectionCellFactory

#pragma mark - Public -

- (UICollectionViewCell*) returnTermsInfoCellWithContent: (TaskCollectionCellsContent*) content
                                       forCollectionView: (UICollectionView*)           collection
                                           withIndexPath: (NSIndexPath*)                indexPath
{
    TermsInfoCollectionCell* cell = [collection dequeueReusableCellWithReuseIdentifier: content.cellId
                                                                       forIndexPath: indexPath];
    
    [cell fillCellWithContent: content];
    
    return cell;
}

@end
