//
//  DefaultCollectionCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 05.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "TaskCollectionCellsContent.h"
#import "ParentCollectionCell.h"

@interface DefaultCollectionCell : ParentCollectionCell

// methods
- (void) fillCellWithContent: (TaskCollectionCellsContent*) content;

@end
