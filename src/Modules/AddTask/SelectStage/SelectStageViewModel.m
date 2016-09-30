//
//  SelectStageViewModel.m
//  TookTODO
//
//  Created by Lera on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectStageViewModel.h"

//Classes
#import "SelectStageModel.h"
#import "OSCellWithCheckmark.h"

@interface SelectStageViewModel()

@property (nonatomic, strong) SelectStageModel* model;

@end

@implementation SelectStageViewModel 


#pragma mark - Properties -

- (SelectStageModel*) model
{
    if (_model == nil)
    {
        _model = [SelectStageModel new];
    }
    
    return _model;
}

#pragma mark - TableView datasource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    //UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"cellID"];
    OSCellWithCheckmark* cell = (OSCellWithCheckmark*)[tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    
    ProjectTaskStage* stage = [self.model getStages][indexPath.row];
    
    [cell fillCellWithTitle: stage.title];

    return cell;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model countOfRows];
}


#pragma mark - TableView delegate methods -

@end
