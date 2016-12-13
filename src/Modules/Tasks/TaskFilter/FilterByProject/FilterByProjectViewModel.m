//
//  FilterByProjectViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 28.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByProjectViewModel.h"

// Classes
#import "FilterByProjectModel.h"
#import "OSCellWithCheckmark.h"

@interface FilterByProjectViewModel()

// properties
@property (strong, nonatomic) FilterByProjectModel* model;

// methods


@end

@implementation FilterByProjectViewModel


#pragma mark - Properties -

- (FilterByProjectModel*) model
{
    if ( _model == nil )
    {
        _model = [FilterByProjectModel new];
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
    return [self.model getNumberOfRows];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    OSCellWithCheckmark* cell = [tableView dequeueReusableCellWithIdentifier: @"checkMarkCellID"];
    
    NSString* title = [self.model getCellTitleForIndexPath: indexPath];
    
    [cell fillCellWithContent: title
            withSelectedState: [self.model getCheckmarkStateForIndexPath: indexPath]];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods -

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    [self.model handleProjectSelectionForIndexPath: indexPath];
    
    OSCellWithCheckmark* cell = [tableView cellForRowAtIndexPath: indexPath];
    
    if ([cell currentCheckMarkState])
        [cell changeCheckmarkState: YES];
    
    else
        [cell changeCheckmarkState: NO];
    
}


#pragma mark - Public -

- (NSArray*) getSelectedProjectsArray
{
    return [self.model getSelectedProjectsArray];
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

- (BOOL) checkIfAllSelected
{
    return [self.model checkIfAllSelected];
}

- (NSArray*) getSelectedProjectsIndexes
{
    return [self.model getSelectedProjectsIndexes];
}

- (void) fillSelectedProjects: (NSArray*) projects
                  withIndexes: (NSArray*) indexes
{
    [self.model fillSelectedProjects: projects
                         withIndexes: indexes];
}


@end


