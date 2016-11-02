//
//  TaskFilterViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskFilterViewModel.h"

// Classes
#import "TaskFilterModel.h"
#import "TaskFilterMainFactory.h"

@interface TaskFilterViewModel()

// properties
@property (strong, nonatomic) TaskFilterModel* model;

// methods


@end

@implementation TaskFilterViewModel

#pragma mark - Properties -

- (TaskFilterModel*) model
{
    if ( _model == nil )
    {
        _model = [TaskFilterModel new];
    }
    
    return _model;
}

#pragma mark - UITableViewDataSource methods -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 4;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model getNumberOfRowsIsSection: section];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    UITableViewCell* cell = [UITableViewCell new];
    
    TaskFilterMainFactory* factory = [TaskFilterMainFactory new];
    
    TaskFilterRowContent* content = [self.model getRowContentForIndexPath: indexPath];
    
    cell = [factory createCellForTableView: tableView
                            withRowContent: content];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    
    if ( section != SectionOne )
    {
        height = 10;
    }
    
    return height;
}

#pragma mark - UITableViewDelegate methods -




@end
