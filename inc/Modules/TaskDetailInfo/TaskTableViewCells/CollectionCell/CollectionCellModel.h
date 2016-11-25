//
//  CollectionCellModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

#import "ParentCollectionCell.h"

@interface CollectionCellModel : NSObject

// methods
- (UICollectionViewCell*) createCellForCollectionView: (UICollectionView*)                collection
                                         forIndexPath: (NSIndexPath*)                     indexPath
                                         withDelegate: (id<ParentCollectionCellDelegate>) delegate;

- (void) fillParentCollectionCellDelegate: (id<ParentCollectionCellDelegate>) delegate;

- (id<ParentCollectionCellDelegate>) getVarToStoreParentCollectionCellDelegate;

@end
