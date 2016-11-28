//
//  FilterByTypeModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ProjectsEnumerations.h"
#import "TaskFilterConfiguration.h"

@interface FilterByTypeModel : NSObject

- (NSArray*) getSelectedTypeIndexesArray;

- (void) handleTypesSelectionForIndexPath: (NSIndexPath*) indexPath;

- (BOOL) getCheckmarkStateForIndexPath: (NSIndexPath*) indexPath;

- (UIColor*) getTaskTypeColor: (TaskType) type;

- (NSString*) getTaskTypeDescription: (TaskType) type;

- (void) fillSelectedTypesInfoFromConfig: (TaskFilterConfiguration*) filterConfig;

- (void) selectAll;

- (void) deselectAll;

@end
