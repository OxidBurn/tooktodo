//
//  TaskViewModel.m
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskViewModel.h"

// Classes
#import "TaskModel.h"
#import "TaskDescriptionCell.h"

@interface TaskViewModel()

// properties
@property (strong, nonatomic) TaskModel* model;

// methods


@end

@implementation TaskViewModel

#pragma mark - Properties -

- (TaskModel*) model
{
    if ( _model == nil )
    {
        _model = [TaskModel new];
    }
    
    return _model;
}

#pragma mark - UITableViewDataSourse methods -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 1;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger) section
{
    return 1;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    TaskDescriptionCell* cell = [tableView dequeueReusableCellWithIdentifier: @"TaskDescriptionCell"];
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate methods -

@end
