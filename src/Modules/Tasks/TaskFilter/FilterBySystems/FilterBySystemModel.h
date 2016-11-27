//
//  FilterBySystemModel.h
//  TookTODO
//
//  Created by Lera on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskFilterConfiguration.h"
#import "ProjectSystem+CoreDataClass.h"

@interface FilterBySystemModel : NSObject

//methods

- (void) handleSystemSelectionForIndexPath: (NSIndexPath*) indexPath;

- (BOOL) getCheckmarkStateForIndexPath: (NSIndexPath*) indexPath;

- (NSArray*) getSelectedSystems;

- (NSArray*) getSelectedSystemsIndexes;

- (void) selectAll;

- (void) deselectAll;

- (void) fillSelectedSystemsInfoFromConfig: (TaskFilterConfiguration*) filterConfig;

- (NSUInteger) getNumberOfRows;

- (NSString*) getSystemTitleForIndexPath: (NSIndexPath*) indexPath;

@end
