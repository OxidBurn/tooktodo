//
//  FilterByAssigneeViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 24.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByAssigneeViewModel.h"

// Classes
#import "OSUserInfoWithCheckmarkCell.h"
#import "FilterByAssigneeModel.h"

@interface FilterByAssigneeViewModel()

// properties
@property (strong, nonatomic) FilterByAssigneeModel* model;

@property (assign, nonatomic) BOOL isCanceledSearch;

// methods


@end

@implementation FilterByAssigneeViewModel


#pragma mark - Properties -

- (FilterByAssigneeModel*) model
{
    if ( _model == nil )
    {
        _model = [FilterByAssigneeModel new];
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
    OSUserInfoWithCheckmarkCell* cell = [tableView dequeueReusableCellWithIdentifier: @"UserInfoWithCheckmarkID"];
    
    [cell fillCellWithAssignee: [self.model getAssigneeForIndexPath: indexPath]
                 withCheckMark: [self.model getCheckmarkStateForIndexPath: indexPath]];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods -

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    [self.model handleAssigneeSelectionForIndexPath: indexPath];
    
    OSUserInfoWithCheckmarkCell* cell = [tableView cellForRowAtIndexPath: indexPath];
    
    if ([cell currentCheckMarkState])
        [cell changeCheckmarkState: YES];
    
    else
        [cell changeCheckmarkState: NO];
    
}


#pragma mark - Public -

- (void) fillFilterType: (FilterByAssigneeType) filterType
{
    [self.model fillFilterType: filterType];
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

- (NSArray*) getSelectedAssingeesIndexes
{
    return [self.model getSelectedAssingeesIndexes];
}

- (NSArray*) getSelectedAssignees
{
    return [self.model getSelectedAssignees];
}

- (void) fillSelectedUsersInfoFromConfig: (TaskFilterConfiguration*) filterConfig
{
    [self.model fillSelectedUsersInfoFromConfig: filterConfig];
}

#pragma mark - Search bar delegate methods -

- (void) searchBar: (UISearchBar*) searchBar
     textDidChange: (NSString*)    searchText
{
    if ( self.isCanceledSearch == NO )
    {
        [self.model applyFilteringByText: searchText];
        
        if ( self.reloadTableView )
            self.reloadTableView();
    }
}

- (BOOL) searchBarShouldBeginEditing: (UISearchBar*) searchBar
{
    return !self.isCanceledSearch;
}

- (void) searchBarTextDidBeginEditing: (UISearchBar*) searchBar
{
    [self.model setTableSearchState: TableSearchState];
    
    if ( self.reloadTableView )
        self.reloadTableView();
}

- (void) searchBarTextDidEndEditing: (UISearchBar*) searchBar
{
    [self.model setTableSearchState: TableNormalState];
    
    if ( self.reloadTableView )
        self.reloadTableView();
}

- (void) searchBarClearButtonClicked: (id) sender
{
    if ( self.endSearching )
        self.endSearching();
    
    [self.model setTableSearchState: TableNormalState];
    
    self.isCanceledSearch = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.isCanceledSearch = NO;
        
    });
}

@end
