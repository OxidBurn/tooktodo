//
//  AddTaskTypeViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/7/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskTypeViewModel.h"

// Classes
#import "AddTaskTypeModel.h"
#import "AddTaskTypeTableViewCell.h"

@interface AddTaskTypeViewModel()

// properties

@property (strong, nonatomic) AddTaskTypeModel* model;

@property (strong, nonatomic) NSIndexPath* selectedTaskTypeCell;

// methods


@end

@implementation AddTaskTypeViewModel

#pragma mark - Properties -

- (AddTaskTypeModel*) model
{
    if ( _model == nil )
    {
        _model = [AddTaskTypeModel new];
    }
    
    return _model;
}

#pragma mark - Public methods -

- (void) fillSavedTaskType: (TaskType) type
{
    self.selectedTaskTypeCell = [NSIndexPath indexPathForRow: type
                                                   inSection: 0];
}

- (void) getSelectedInfo: (GetTaskTypeInfoBlock) completion
{
    NSString* taskTypeDescription = [self.model getTaskTypeDescription: self.selectedTaskTypeCell.row];
    
    if ( completion )
        completion(taskTypeDescription, self.selectedTaskTypeCell.row);
}


#pragma mark - Table view data source -

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return 4;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    AddTaskTypeTableViewCell* cell = (AddTaskTypeTableViewCell*)[tableView dequeueReusableCellWithIdentifier: @"addTaskTypeCellID"];
    
    [cell setTypeTitle: [self.model getTaskTypeDescription: indexPath.row]
         withTypeColor: [self.model getTaskTypeColor: indexPath.row]];
    
    [cell markCellAsSelected: (self.selectedTaskTypeCell == indexPath)];
    
    return cell;
}


#pragma mark - Table view delegate methods -

- (void)       tableView: (UITableView*) tableView
 didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    if ( self.selectedTaskTypeCell )
    {
        AddTaskTypeTableViewCell* prevCell = [tableView cellForRowAtIndexPath: self.selectedTaskTypeCell];
        
        [prevCell markCellAsSelected: NO];
    }
    
    AddTaskTypeTableViewCell* cell = [tableView cellForRowAtIndexPath: indexPath];
    
    [cell markCellAsSelected: YES];
    
    self.selectedTaskTypeCell = indexPath;
}

@end
