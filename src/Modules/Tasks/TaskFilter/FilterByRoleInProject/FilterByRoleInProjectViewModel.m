//
//  FilterByRoleInProjectViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByRoleInProjectViewModel.h"

// Classes
#import "FilterByRoleInProjectModel.h"
#import "OSCellWithCheckmark.h"

@interface FilterByRoleInProjectViewModel()

// properties
@property (nonatomic, strong) FilterByRoleInProjectModel* model;

// methods


@end

@implementation FilterByRoleInProjectViewModel


#pragma mark - Properties -

- (FilterByRoleInProjectModel*) model
{
    if (_model == nil)
    {
        _model = [FilterByRoleInProjectModel new];
    }
    
    return _model;
}


#pragma mark - Public -


#pragma mark - Table view datasource metods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    OSCellWithCheckmark* cell = [tableView dequeueReusableCellWithIdentifier: @"checkMarkCellID"];
    
    NSString* title = [self.model getTitleForIndexPath: indexPath];
    
        [cell fillCellWithContent: title
                withSelectedState: YES];
    
    [cell changeCheckmarkState: [self.model getSelectedStateForIndexPath: indexPath]];
    
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
    
    OSCellWithCheckmark* cell = [tableView cellForRowAtIndexPath: indexPath];
    
    [self.model handleCheckmarkForIndexPath: indexPath];
    
    [cell changeCheckmarkState: [self.model getSelectedStateForIndexPath: indexPath]];
}

@end
