//
//  OnPlanCollectionCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "TaskCollectionCellsContent.h"
#import "ParentCollectionCell.h"

@interface OnPlanCollectionCell : ParentCollectionCell

// methods
- (void) fillCellWithContent: (TaskCollectionCellsContent*) content;

@end
