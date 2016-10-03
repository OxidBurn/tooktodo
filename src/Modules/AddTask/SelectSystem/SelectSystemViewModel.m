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

#pragma mark - Public -

- (ProjectSystem*) getSelectedSystem
{
    return [self.model getSelectedSystem];
}

#pragma mark - TableView datasource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    //UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"cellID"];
    OSCellWithCheckmark* cell = (OSCellWithCheckmark*)[tableView dequeueReusableCellWithIdentifier:@"cellID"];

    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"Не выбрано";
        UIFont* customFont  = [UIFont fontWithName: @"SFUIText-Regular"
                                                        size: 15.0f];
        cell.textLabel.font = customFont;
    }
    else
    {
        ProjectSystem* system = [self.model getSystems][indexPath.row - 1];
    
        [cell fillCellWithContent: system];
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
    
    if ( [self.model getLastIndexPath] )
    {
        OSCellWithCheckmark* prevSelectedCell = [tableView cellForRowAtIndexPath: [self.model getLastIndexPath]];
        
        [prevSelectedCell changeCheckmarkState: NO];
    }
    
    [self.model updateLastIndexPath: indexPath];
   
    
}


@end
