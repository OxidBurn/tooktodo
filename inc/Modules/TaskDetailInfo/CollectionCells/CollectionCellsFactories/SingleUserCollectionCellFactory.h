//
//  SingleUserCollectionCellFactory.h
//  TookTODO
//
//  Created by Nikolay Chaban on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

// Classes
#import "TaskCollectionCellsContent.h"
#import "ParentCollectionCell.h"

@interface SingleUserCollectionCellFactory : NSObject

// methods
- (ParentCollectionCell*) returnSingleUserCellWithContent: (TaskCollectionCellsContent*) content
                                        forCollectionView: (UICollectionView*)           collection
                                            withIndexPath: (NSIndexPath*)                indexPath
                                             withDelegate: (id<ParentCollectionCellDelegate>) delegate;

@end
