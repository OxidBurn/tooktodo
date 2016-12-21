//
//  SelectResponsibleViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 22.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectResponsibleViewModel.h"

// Classes
#import "OSUserInfoWithCheckmarkCell.h"
#import "FilledTeamInfo.h"
#import "SelectResponsibleModel.h"


@interface SelectResponsibleViewModel()

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
    
    ControllerTypeSelection selection = [self returnControllerType];
    
    FilledTeamInfo* user = [self.model returnFilledUserInfoForIndex: indexPath.row];
    
    BOOL isSelected = NO;
    
    switch ( selection )
    {
        case SelectObserversController:
            
            isSelected = user.taskRoleAssinment.integerValue == ObserverRoleType;
            
            break;
            
        case SelectClaimingController:
            
            isSelected = [user.taskRoleAssinment isEqual: @(ClaimingsRoleType)];
            
            break;
            
        case SelectResponsibleController:
            
            isSelected = [user.taskRoleAssinment isEqual: @(ResponsibleRoleType)];
            
            break;
            
        default:
            break;
    }
    
    [cell fillCellWithFilledMemberInfo: user
                         withCheckmark: isSelected];
    
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
            
            if ( [self.model returnPreviousMarkedCellIndexPath] &&
                 [self.model returnPreviousMarkedCellIndexPath] != indexPath )
            {
                OSUserInfoWithCheckmarkCell* prevSelectedCell = [tableView cellForRowAtIndexPath: [self.model returnPreviousMarkedCellIndexPath]];
                
                [prevSelectedCell changeCheckmarkState: NO];
            }
            
            [self.model updatePreviousCellIndexPath: indexPath];
        }
            break;
            
        case SelectClaimingController:
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

- (void) fillContollerTypeSelection: (ControllerTypeSelection) controllerType
                  withSelectedUsers: (NSArray*)                selectedUsers
                     withAllMembers: (NSArray*)                allMembers
{
    [self.model fillContollerTypeSelection: controllerType
                         withSelectedUsers: selectedUsers
                            withAllMembers: allMembers];
}

- (ControllerTypeSelection) returnControllerType
{
    return [self.model returnControllerType];
}

- (NSArray*) returnSelectedResponsibleArray
{
    return [self.model returnSelectedResponsibleArray];
}

- (NSArray*) returnSelectedClaimingArray
{
    return [self.model returnSelectedClaimingArray];
}

- (NSArray*) returnSelectedObserversArray
{
    return [self.model returnSelectedObserversArray];
}

- (NSArray*) returnAllMembersArray
{
    return [self.model returnAllMembersArray];
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
