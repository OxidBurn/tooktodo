//
//  FilterByStatusModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 25.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByStatusModel.h"

@interface FilterByStatusModel()

// properties
@property (strong, nonatomic) NSArray* selectedStatusesIndexes;

// methods

@end

@implementation FilterByStatusModel


#pragma mark - Properties -

- (NSArray*) selectedStatusesIndexes
{
    if ( _selectedStatusesIndexes == nil )
    {
        _selectedStatusesIndexes = [NSArray new];
    }
    
    return _selectedStatusesIndexes;
}


#pragma mark - Public -

- (void) handleStatusesSelectionForIndexPath: (NSIndexPath*) indexPath
{
    // adding to array indexes of selected statuses
    NSMutableArray* tmp = self.selectedStatusesIndexes.mutableCopy;
    
    NSNumber* index = @(indexPath.row);
    
    if ( [self.selectedStatusesIndexes containsObject: index] )
    {
        [tmp removeObject: index];
    }
    else
        [tmp addObject: index];
    
    self.selectedStatusesIndexes = tmp.copy;
}

- (BOOL) getCheckmarkStateForIndexPath: (NSIndexPath*) indexPath
{
    BOOL isSelected;
        
    if ( [self.selectedStatusesIndexes containsObject: @(indexPath.row)] )
        isSelected = YES;
    
    return isSelected;
}

- (NSArray*) getSelectedStatusesArray
{
    return self.selectedStatusesIndexes;
}

- (void) selectAll
{
    self.selectedStatusesIndexes = @[ @(0), @(1), @(2), @(3), @(4), @(5) ];
}

- (void) deselectAll
{
    self.selectedStatusesIndexes = nil;
}

- (void) fillSelectedStatuses: (NSArray*) statuses
{
    self.selectedStatusesIndexes = statuses;
}

- (BOOL) checkIfAllSelected
{
    return self.selectedStatusesIndexes.count == 6;
}

@end
