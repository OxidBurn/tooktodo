//
//  FilterByStatusModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 25.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterByStatusModel : NSObject

// methods
- (void) handleStatusesSelectionForIndexPath: (NSIndexPath*) indexPath;

- (BOOL) getCheckmarkStateForIndexPath: (NSIndexPath*) indexPath;

- (NSArray*) getSelectedStatusesArray;

- (void) selectAll;

- (void) deselectAll;

- (void) fillSelectedStatuses: (NSArray*) statuses;

- (BOOL) checkIfAllSelected;

@end
