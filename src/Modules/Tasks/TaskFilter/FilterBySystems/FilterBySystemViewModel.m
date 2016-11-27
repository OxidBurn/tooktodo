//
//  FilterBySystemViewModel.m
//  TookTODO
//
//  Created by Lera on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterBySystemViewModel.h"

//Classes
#import "FilterBySystemModel.h"
#import "OSCellWithCheckmark.h"

@interface FilterBySystemViewModel()

// properties
@property (nonatomic, strong) FilterBySystemModel* model;

// methods


@end

@implementation FilterBySystemViewModel


#pragma mark - Properties -

- (FilterBySystemModel*) model
{
    if (_model == nil)
    {
        _model = [FilterBySystemModel new];
    }
    
    return _model;
}

#pragma mark - Public -

- (NSArray*) getSelectedSystems
{
    return [self.model getSelectedWorkAreas];
}

- (NSArray*) getSelectedSystemsIndexes
{
    return [self.model getSelectedWorkAreasIndexes];
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

- (void) fillSelectedSystemsInfoFromConfig: (TaskFilterConfiguration*) filterConfig
{
    [self.model fillSelectedWorkAreasInfoFromConfig: filterConfig];
}


#pragma mark - UITableViewDatasource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    OSCellWithCheckmark* cell = [tableView dequeueReusableCellWithIdentifier: @"checkMarkCellID"];
    
    [self.model handleWorkAreaSelectionForIndexPath: indexPath];
    
    [cell fillCellWithContent: [self.model getWorkAreaTitleForIndexPath: indexPath]
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
