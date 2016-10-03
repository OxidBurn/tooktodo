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


#pragma mark - Public -

- (ProjectTaskStage*) getSelectedStage
{
    return [self.model getSelectedStage];
}

- (void) fillSelectedStage: (ProjectTaskStage*) stage
{
    [self.model fillSelectedStage: stage];
}

#pragma mark - TableView datasource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    OSCellWithCheckmark* cell = (OSCellWithCheckmark*)[tableView dequeueReusableCellWithIdentifier: @"cellID"];
    
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"Не выбрано";
        UIFont* customFont  = [UIFont fontWithName: @"SFUIText-Regular"
                                              size: 15.0f];
        cell.textLabel.font = customFont;
    }
    
    else
    {
        ProjectTaskStage* stage = [self.model getStages][indexPath.row - 1];
    
        [cell fillCellWithContent: stage.title
                withSelectedState: stage.isSelected];
        
        [self.model updateSelectedUsers];
    }


    return cell;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model countOfRows];
}


#pragma mark - TableView delegate methods -

- (void)        tableView: (UITableView*) tableView
  didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    [self.model handleCheckmarkForIndexPath: indexPath];
    
    OSCellWithCheckmark* cell = [tableView cellForRowAtIndexPath: indexPath];
    

    [cell changeCheckmarkState: YES];
    
    if ( [self.model getLastIndexPath] && [self.model getLastIndexPath] != indexPath )
    {
        OSCellWithCheckmark* prevSelectedCell = [tableView cellForRowAtIndexPath: [self.model getLastIndexPath]];
        
        [prevSelectedCell changeCheckmarkState: NO];
    }
    
    [self.model updateLastIndexPath: indexPath];
    
}


@end
