//
//  FilterBySystemModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskFilterConfiguration.h"

@interface FilterBySystemModel : NSObject

//methods

- (void) handleWorkAreaSelectionForIndexPath: (NSIndexPath*) indexPath;

- (BOOL) getCheckmarkStateForIndexPath: (NSIndexPath*) indexPath;

- (NSArray*) getSelectedWorkAreas;

- (NSArray*) getSelectedWorkAreasIndexes;

- (void) selectAll;

- (void) deselectAll;

- (void) fillSelectedWorkAreasInfoFromConfig: (TaskFilterConfiguration*) filterConfig;

- (NSUInteger) getNumberOfRows;

- (NSString*) getWorkAreaTitleForIndexPath: (NSIndexPath*) indexPath;

- (BOOL) checkIfAllSelected;

@end
