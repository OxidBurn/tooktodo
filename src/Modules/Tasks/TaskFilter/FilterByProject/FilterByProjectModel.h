//
//  FilterByProjectModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 28.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterByProjectModel : NSObject

// methods
- (NSUInteger) getNumberOfRows;

- (void) handleProjectSelectionForIndexPath: (NSIndexPath*) indexPath;

- (BOOL) getCheckmarkStateForIndexPath: (NSIndexPath*) indexPath;

- (NSArray*) getSelectedProjectsArray;

- (NSArray*) getSelectedProjectsIndexes;

- (NSString*) getCellTitleForIndexPath: (NSIndexPath*) indexPath;

- (void) selectAll;

- (void) deselectAll;

- (void) fillSelectedProjects: (NSArray*) projects
                  withIndexes: (NSArray*) indexes;

- (BOOL) checkIfAllSelected;

@end
