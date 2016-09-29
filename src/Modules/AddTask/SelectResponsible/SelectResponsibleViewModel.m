//
//  SelectResponsibleViewModel.m
//  TookTODO
//
//  Created by Глеб on 22.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectResponsibleViewModel.h"

// Classes
#import "OSUserInfoWithCheckmarkCell.h"
#import "FilledTeamInfo.h"
#import "SelectResponsibleViewController.h"


@interface SelectResponsibleViewModel() <SelectResponsibleViewControllerDelegate>

// properties
@property (strong, nonatomic) SelectResponsibleModel* model;

// methods


@end

@implementation SelectResponsibleViewModel

#pragma mark - Properties -

- (SelectResponsibleModel*) model
{
    if ( _model == nil )
    {
        _model = [SelectResponsibleModel new];
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
    
    [cell fillCellWithFilledMemberInfo: [self.model returnFilledUserInfoForIndex: indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods -

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    ControllerTypeSelection selection = [self.model returnControllerType];
    
    switch ( selection )
    {
        case SelectResponsibleController:
        {
            [tableView deselectRowAtIndexPath: indexPath
                                     animated: YES];
            
            [self.model handleCheckmarkForIndexPath: indexPath];
            
            OSUserInfoWithCheckmarkCell* cell = [tableView cellForRowAtIndexPath: indexPath];
            
            [cell changeCheckmarkState: YES];
            
            if ( [self.model returnPreviousMarkedCellIndexPath] )
            {
                OSUserInfoWithCheckmarkCell* prevSelectedCell = [tableView cellForRowAtIndexPath: [self.model returnPreviousMarkedCellIndexPath]];
                
                [prevSelectedCell changeCheckmarkState: NO];
            }
            
            [self.model updatePreviousCellIndexPath: indexPath];
        }
            break;
            
        case SelectClaimingController:
        {
            [tableView deselectRowAtIndexPath: indexPath
                                     animated: YES];
            
            [self.model handleCheckmarkForIndexPath: indexPath];
            
            OSUserInfoWithCheckmarkCell* cell = [tableView cellForRowAtIndexPath: indexPath];
            
            if ([cell currentCheckMarkState])
                [cell changeCheckmarkState: YES];
            
            else
                [cell changeCheckmarkState: NO];
            
            
            
        }
            break;
            
        case SelectObserversController:
        {
            [tableView deselectRowAtIndexPath: indexPath
                                     animated: YES];
            
            [self.model handleCheckmarkForIndexPath: indexPath];
            
            OSUserInfoWithCheckmarkCell* cell = [tableView cellForRowAtIndexPath: indexPath];
            
            if ([cell currentCheckMarkState])
                [cell changeCheckmarkState: YES];
            
            else
                [cell changeCheckmarkState: NO];
            
            
            
        }
            break;
            
        default:
            break;
    }

}

#pragma mark - Public -

- (void) updateInfoWithCompletion: (CompletionWithSuccess) completion
{
    [self.model updateTeamInfoWithCompletion: completion];
}

- (void) fillContollerTypeSelection: (ControllerTypeSelection) controllerType
{
    [self.model fillContollerTypeSelection: controllerType];
}

- (ControllerTypeSelection) returnControllerType
{
    return [self.model returnControllerType];
}

- (NSArray*) returnSelectedUsersInfo
{
    return [self.model returnSelectedUsersInfo];
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

@end
