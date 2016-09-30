//
//  SelectSystemViewModel.m
//  TookTODO
//
//  Created by Lera on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectSystemViewModel.h"

//Classes
#import "SelectSystemModel.h"
#import "OSCellWithCheckmark.h"


@interface SelectSystemViewModel()

@property (nonatomic, strong) SelectSystemModel* model;

@end


@implementation SelectSystemViewModel

#pragma mark - Properties -

- (SelectSystemModel*) model
{
    if (_model == nil)
    {
        _model = [SelectSystemModel new];
    }
    
    return _model;
}

#pragma mark - TableView datasource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    //UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"cellID"];
    OSCellWithCheckmark* cell = (OSCellWithCheckmark*)[tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    
    ProjectSystem* system = [self.model getSystems][indexPath.row];
    
    [cell fillCellWithTitle: system.title];
    
    return cell;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model countOfRows];
}


@end
