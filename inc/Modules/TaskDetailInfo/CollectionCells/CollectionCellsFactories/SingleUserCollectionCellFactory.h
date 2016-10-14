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

@interface SingleUserCollectionCellFactory : NSObject

// methods
- (UICollectionViewCell*) returnSingleUserCellWithContent: (TaskCollectionCellsContent*) content
                                        forCollectionView: (UICollectionView*)           collection
                                            withIndexPath: (NSIndexPath*)                indexPath;

@end
