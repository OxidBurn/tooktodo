//
//  FilterByRoomViewModel.m
//  TookTODO
//
//  Created by Lera on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByRoomViewModel.h"

//Classes
#import "FilterByRoomModel.h"
#import "OSCellWithCheckmark.h"

@interface FilterByRoomViewModel()

// properties
@property (nonatomic, strong) FilterByRoomModel* model;

// methods


@end

@implementation FilterByRoomViewModel


#pragma mark - Properties -

- (FilterByRoomModel*) model
{
    if (_model == nil)
    {
        _model = [FilterByRoomModel new];
    }
    
    return _model;
}

#pragma mark - Public -

- (NSArray*) getSelectedRooms
{
    return [self.model getSelectedRooms];
}

- (NSArray*) getSelectedRoomIndexes
{
    return [self.model getSelectedRoomIndexes];
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

- (void) fillSelectedRoomsInfoFromConfig: (TaskFilterConfiguration*) filterConfig
{
    [self.model fillSelectedRoomsInfoFromConfig: filterConfig];
}


#pragma mark - UITableViewDatasource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    OSCellWithCheckmark* cell = [tableView dequeueReusableCellWithIdentifier: @"checkMarkCellID"];
    
    [self.model handleRoomSelectionForIndexPath: indexPath];
    
    [cell fillCellWithContent: [self.model getRoomTitleForIndexPath: indexPath]
            withSelectedState: [self.model getCheckmarkStateForIndexPath: indexPath]];
    
    
    
    return cell;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model getNumberOfRows];
}

#pragma mark - UITableViewDelegate methods -

- (void)        tableView: (UITableView*) tableView
  didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    
    OSCellWithCheckmark* cell = [tableView cellForRowAtIndexPath: indexPath];
    
    [cell changeCheckmarkState: [self.model getCheckmarkStateForIndexPath: indexPath]];
}

@end
