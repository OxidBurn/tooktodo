//
//  FilterByTypesVievModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByTypesViewModel.h"

//Classes
#import "FilterByTypeModel.h"
#import "AddTaskTypeTableViewCell.h"

@interface FilterByTypesViewModel()

// properties

@property (nonatomic, strong) FilterByTypeModel* model;


// methods


@end

@implementation FilterByTypesViewModel


#pragma mark - Properties -

- (FilterByTypeModel*) model
{
    if (_model == nil)
    {
        _model = [FilterByTypeModel new];
    }
    
    return _model;
}


#pragma mark - Public -

- (NSArray*) getSelectedTypesArray
{
    return [self.model getSelectedTypeIndexesArray];
}

- (void) fillSelectedTypesInfoFromConfig: (TaskFilterConfiguration*) filterConfig
{
    [self.model fillSelectedTypesInfoFromConfig: filterConfig];
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

#pragma mark - Table view datasource metods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    AddTaskTypeTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"addTaskTypeCellID"];
    
    [cell setTypeTitle: [self.model getTaskTypeDescription: indexPath.row]
         withTypeColor: [self.model getTaskTypeColor: indexPath.row]];
    
    [self.model handleTypesSelectionForIndexPath: indexPath];
    
    [cell markCellAsSelected: [self.model getCheckmarkStateForIndexPath: indexPath]];

    return cell;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return 4;
}

#pragma mark - Table view delegate metods -

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    AddTaskTypeTableViewCell* cell = [tableView cellForRowAtIndexPath: indexPath];

    [cell markCellAsSelected: [self.model getCheckmarkStateForIndexPath: indexPath]];

}


@end
