//
//  FilterByStatusViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 25.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByStatusViewModel.h"

// Classes
#import "FilterByStatusModel.h"
#import "SelectStatusCell.h"

@interface FilterByStatusViewModel()

// properties
@property (strong, nonatomic) FilterByStatusModel* model;

// methods


@end

@implementation FilterByStatusViewModel


#pragma mark - Properties -

- (FilterByStatusModel*) model
{
    if ( _model == nil )
    {
        _model = [FilterByStatusModel new];
    }
    
    return _model;
}




#pragma mark - UITableViewDataSourse methods -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 1;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return 6;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    SelectStatusCell* cell = [tableView dequeueReusableCellWithIdentifier: @"StatusCellID"];
    
    [cell fillCellForIndexPath: indexPath
             withSelectedState: [self.model getCheckmarkStateForIndexPath: indexPath]];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods -

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    [self.model handleStatusesSelectionForIndexPath: indexPath];
    
    SelectStatusCell* cell = [tableView cellForRowAtIndexPath: indexPath];
    
    if ([cell currentCheckMarkState])
        [cell changeCheckmarkState: YES];
    
    else
        [cell changeCheckmarkState: NO];
    
}


#pragma mark - Public -

- (NSArray*) getSelectedStatusesArray
{
    return [self.model getSelectedStatusesArray];
}

- (void) selectAll
{
    [self.model selectAll];
    if (self.reloadTableView)
        self.reloadTableView();
}

- (void) deselectAll
{
    [self.model deselectAll];
    if (self.reloadTableView)
        self.reloadTableView();
}

- (void) fillSelectedStatuses: (NSArray*) statuses
{
    [self.model fillSelectedStatuses: statuses];
}

- (BOOL) checkIfAllSelected
{
    return [self.model checkIfAllSelected];
}

@end
