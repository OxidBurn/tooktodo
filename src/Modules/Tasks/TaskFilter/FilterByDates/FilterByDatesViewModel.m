//
//  FilterByDatesViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 03.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByDatesViewModel.h"

// Classes
#import "FilterByDatesModel.h"

@interface FilterByDatesViewModel()

// properties
@property (strong, nonatomic) FilterByDatesModel* model;

// methods


@end

@implementation FilterByDatesViewModel


#pragma mark - Properties -

- (FilterByDatesModel*) model
{
    if ( _model == nil )
    {
        _model = [FilterByDatesModel new];
    }
    
    return _model;
}


#pragma mark - UITableView data sourse methods-

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 1;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return 2;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    UITableViewCell* cell = [UITableViewCell new];
    
    return cell;
}

#pragma mark - UITableView delegate methods -



@end
