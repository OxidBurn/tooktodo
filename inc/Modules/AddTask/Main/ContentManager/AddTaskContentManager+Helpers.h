//
//  AddTaskContentManager+Helpers.h
//  TookTODO
//
//  Created by Nikolay Chaban on 14.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskContentManager.h"

// Classes
#import "RowContent.h"

@interface AddTaskContentManager (Helpers)

// methods

- (void) updateContentWithRow: (RowContent*) newRow
                    inSection: (NSUInteger)  section
                        inRow: (NSUInteger)  row;

- (NSString*) createTermsLabelTextForStartDate: (NSDate*) startDate
                                withFinishDate: (NSDate*) finishDate
                                  withDuration: (NSUInteger) duration;

- (NSString*) determineCellIdForGroupOfMembers: (NSArray*) membersGroup;

- (AddTaskTableViewCellType) determintCellIndexForCellId: (NSString*) cellId;

- (NSArray*) getCurrentUserInfoArray;

- (BOOL) handleEnabledSwitchStateForContent: (RowContent*)           rowContent
                          forControllerType: (AddTaskControllerType) controllerType;

- (void) disableUserInteractionForStageInController: (AddTaskControllerType) controllerType;

@end
