//
//  TaskFilterModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "TaskFilterRowContent.h"

@interface TaskFilterModel : NSObject

// methods
- (TaskFilterRowContent*) getRowContentForIndexPath: (NSIndexPath*) indexPath;

- (NSUInteger) getNumberOfRowsIsSection: (NSUInteger) section;

- (CGFloat) getRowHeightForRowAtIndexPath: (NSIndexPath*) indexPath;

- (void) didSelectTermsCellForIndexPath: (NSIndexPath*) indexPath;

- (void) fillFilterType: (TasksFilterType) filterType;

@end
