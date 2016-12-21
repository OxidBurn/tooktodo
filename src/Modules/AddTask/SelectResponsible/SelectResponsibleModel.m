//
//  SelectResponsibleModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 22.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectResponsibleModel.h"

// Classes
#import "DataManager+Tasks.h"
#import "DataManager+ProjectInfo.h"
#import "ProjectInfo+CoreDataClass.h"
#import "ProjectTaskRoleAssignment+CoreDataClass.h"
#import "ProjectTaskRoleAssignments+CoreDataClass.h"

@interface SelectResponsibleModel()

// properties
@property (strong, nonatomic) NSArray* membersArray;

@property (strong, nonatomic) NSArray* selectedResponsibleArray;

@property (strong, nonatomic) NSArray* selectedClaimingArray;

@property (strong, nonatomic) NSArray* selectedObserversArray;

@property (assign, nonatomic) BOOL isSelectedResponsible;

@property (assign, nonatomic) BOOL hasAnySelectedMembers;

@property (assign, nonatomic) ControllerTypeSelection controllerType;

@property (strong, nonatomic) NSIndexPath* previousesSelectedIndexPath;

// methods


@end

@implementation SelectResponsibleModel


#pragma mark - Properties -

- (NSArray*) membersArray
{
    if ( _membersArray == nil )
    {
        _membersArray = [NSArray new];
    }
    
    return _membersArray;
}

#pragma mark - Public -

- (void) fillContollerTypeSelection: (ControllerTypeSelection) controllerType
                  withSelectedUsers: (NSArray*)                selectedUsers
                     withAllMembers: (NSArray*)                allMembers;
{
    self.controllerType = controllerType;
    
    self.membersArray = allMembers;
    
    switch (controllerType)
    {
        case SelectResponsibleController:
        {
            self.selectedResponsibleArray = selectedUsers;
        }
            break;
        case SelectClaimingController:
        {
            self.selectedClaimingArray = selectedUsers;
        }
            break;
        case SelectObserversController:
        {
            self.selectedObserversArray = selectedUsers;
        }
            break;
            
        default:
            break;
    }
    
    [self configurateMembersArray];
}

- (NSUInteger) getNumberOfRows
{
    return self.membersArray.count;
}

- (FilledTeamInfo*) returnFilledUserInfoForIndex: (NSUInteger) index
{
    return self.membersArray[index];
}

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) indexPath
{
    switch ( self.controllerType )
    {
        case SelectResponsibleController:
        {
            if ( [indexPath isEqual: self.previousesSelectedIndexPath] )
            {
                self.previousesSelectedIndexPath = nil;
                
            }
            else
                if ( [indexPath isEqual: self.previousesSelectedIndexPath] == NO )
                {
                    [self.membersArray enumerateObjectsUsingBlock: ^(FilledTeamInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                
                if ( idx == indexPath.row )
                {
                    obj.taskRoleAssinment = @(ResponsibleRoleType);
                }
                else
                    if ( [obj.taskRoleAssinment isEqual: @(ResponsibleRoleType)] )
                    {
                        obj.taskRoleAssinment = nil;
                    }
                       
                }];
                
                self.selectedResponsibleArray = @[ self.membersArray[indexPath.row] ];
            }
            else
            {                
                self.selectedResponsibleArray = nil;
            }
        }
            
            break;
            
        case SelectClaimingController:
        {
            FilledTeamInfo* user = self.membersArray[indexPath.row];
                        
            if ( [user.taskRoleAssinment isEqual: @(ClaimingsRoleType)] == NO )
            {
                user.taskRoleAssinment = @(ClaimingsRoleType);
                
                if ( self.selectedClaimingArray == nil || self.selectedClaimingArray.count == 0 )
                {
                    self.selectedClaimingArray = [NSArray arrayWithObject: user];
                }
                else
                {
                    NSMutableArray* selectedArrayCopy = self.selectedClaimingArray.mutableCopy;
                
                    [selectedArrayCopy addObject: user];
                
                    self.selectedClaimingArray = [selectedArrayCopy copy];
                }
                
            } else
                if ( [user.taskRoleAssinment isEqual: @(ClaimingsRoleType)] )
                {
                    user.taskRoleAssinment = nil;
                    
                    [self.selectedClaimingArray enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        FilledTeamInfo* filledUser = [self convertObjectToTeamMember: obj];

                            if ( [filledUser.userId isEqual: user.userId] )
                            {
                                NSMutableArray* selectedArrayCopy = self.selectedClaimingArray.mutableCopy;
                                
                                [selectedArrayCopy removeObject: obj];
                                
                                self.selectedClaimingArray = [selectedArrayCopy copy];
                            }
                    }];
                }
                else
                {
                    self.selectedClaimingArray = nil;
                }
        }
            break;
            
        case SelectObserversController:
        {
            FilledTeamInfo* user = self.membersArray[indexPath.row];
            
            if ( [user.taskRoleAssinment isEqual: @(ObserverRoleType)] == NO )
            {
                user.taskRoleAssinment = @(ObserverRoleType);
                
                if ( self.selectedObserversArray == nil || self.selectedObserversArray.count == 0 )
                {
                    self.selectedObserversArray = [NSArray arrayWithObject: user];
                }
                else
                {
                    NSMutableArray* selectedArrayCopy = self.selectedObserversArray.mutableCopy;
                    
                    [selectedArrayCopy addObject: user];
                    
                    self.selectedObserversArray = [selectedArrayCopy copy];
                }
                
            } else
                if ( [user.taskRoleAssinment isEqual: @(ObserverRoleType)] )
                {
                    user.taskRoleAssinment = nil;
                    
                    [self.selectedObserversArray enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        FilledTeamInfo* filledUser = [self convertObjectToTeamMember: obj];
                        
                            if ( [filledUser.userId isEqual: user.userId] )
                            {
                                NSMutableArray* selectedArrayCopy = self.selectedObserversArray.mutableCopy;
                                
                                [selectedArrayCopy removeObject: obj];
                                
                                self.selectedObserversArray = [selectedArrayCopy copy];
                            }
                    }];
                }
        }
            break;
            
        default:
            break;
    }
    
    if ( self.isSelectedResponsible )
        self.hasAnySelectedMembers = YES;
}

- (NSNumber*) getMemberTaskRoleTypeAtIndex: (NSUInteger) index
{
    FilledTeamInfo* memberInfo = self.membersArray[index];
    
    return memberInfo.taskRoleAssinment;
}

- (ControllerTypeSelection) returnControllerType
{
    return self.controllerType;
}

- (BOOL) checkIfButtonIsEnabled
{
    return self.hasAnySelectedMembers;
}

- (NSIndexPath*) returnPreviousMarkedCellIndexPath
{
    return self.previousesSelectedIndexPath;
}

- (void) updatePreviousCellIndexPath: (NSIndexPath*) indexPath
{
    self.previousesSelectedIndexPath = indexPath;
}

- (NSArray*) returnSelectedResponsibleArray
{
    return self.selectedResponsibleArray;
}

- (NSArray*) returnSelectedClaimingArray
{
    return self.selectedClaimingArray;
}

- (NSArray*) returnSelectedObserversArray
{
    return self.selectedObserversArray;
}

- (NSArray*) returnAllMembersArray
{
    return self.membersArray;
}

- (void) selectAll
{
    [self.membersArray enumerateObjectsUsingBlock:^(FilledTeamInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.taskRoleAssinment = @(ObserverRoleType);
    }];
    
    self.selectedObserversArray = [NSArray arrayWithArray: self.membersArray];
}

- (void) deselectAll
{
    [self.membersArray enumerateObjectsUsingBlock:^(FilledTeamInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.taskRoleAssinment = nil;
    }];
    
    self.selectedObserversArray = nil;
}

- (void) updateSelectedUsers
{
    switch ( self.controllerType )
    {
        case SelectResponsibleController:
        {
            [self.membersArray enumerateObjectsUsingBlock: ^(FilledTeamInfo* userInList, NSUInteger idx, BOOL * _Nonnull stop) {
                                
                [self.selectedResponsibleArray enumerateObjectsUsingBlock: ^(FilledTeamInfo* selectedUser, NSUInteger idx2, BOOL * _Nonnull stop) {
                        
                        FilledTeamInfo* selectedTeamMember = [self convertObjectToTeamMember: selectedUser];

                        if ( [userInList.userId isEqual: selectedTeamMember.userId] )
                        {
                            userInList.taskRoleAssinment = selectedTeamMember.taskRoleAssinment;
                            
                            NSIndexPath* temp = [NSIndexPath indexPathForRow: idx inSection: 0];
                            
                            self.previousesSelectedIndexPath = temp;
                        }
                }];
                
            }];
        }
            break;
            
        case SelectClaimingController:
        {
            [self fillTaskRolesForSelectedMembers: self.selectedClaimingArray];
        }
            break;
            
        case SelectObserversController:
        {
            [self fillTaskRolesForSelectedMembers: self.selectedObserversArray];
        }
            break;
            
        default:
            break;
    }
}

- (void) fillTaskRolesForSelectedMembers: (NSArray*) selectedMembers
{
    [self.membersArray enumerateObjectsUsingBlock: ^(FilledTeamInfo* userInList, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [selectedMembers enumerateObjectsUsingBlock: ^(id selectedUser, NSUInteger idx, BOOL * _Nonnull stop) {
            
                FilledTeamInfo* selectedTeamMember = [self convertObjectToTeamMember: selectedUser];
                
                if ( [userInList.userId isEqual: selectedTeamMember.userId] )
                {
                    userInList.taskRoleAssinment = selectedTeamMember.taskRoleAssinment;
                }
        }];
        
    }];
}

- (void) excludeInvitedUsers
{
    __block NSMutableArray* tmpMembersArray = self.membersArray.mutableCopy;
    
    [self.membersArray enumerateObjectsUsingBlock: ^(FilledTeamInfo* member, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ( member.assignments.assignee == nil )
        {
            [tmpMembersArray removeObject: member];
        }
        
    }];
    
    self.membersArray = tmpMembersArray.copy;
}

- (void) sortContentAccordingToType
{
    __block NSMutableArray* tmpMembersArray = [NSMutableArray new];
    
    switch ( self.controllerType )
    {
        case SelectResponsibleController:
        {
            [self.membersArray enumerateObjectsUsingBlock: ^(FilledTeamInfo* member, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ( ([member.taskRoleAssinment isEqual: @(ResponsibleRoleType)]) || member.taskRoleAssinment == nil )
                {
                    [tmpMembersArray addObject: member];
                }
                
            }];
        }
            break;
            
        case SelectClaimingController:
        {
            [self.membersArray enumerateObjectsUsingBlock: ^(FilledTeamInfo* member, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ( ([member.taskRoleAssinment isEqual: @(ClaimingsRoleType)]) || member.taskRoleAssinment == nil )
                {
                    [tmpMembersArray addObject: member];
                }
                
            }];
        }
            break;
            
        case SelectObserversController:
        {
            [self.membersArray enumerateObjectsUsingBlock: ^(FilledTeamInfo* member, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ( ([member.taskRoleAssinment isEqual: @(ObserverRoleType)]) || member.taskRoleAssinment == nil )
                {
                    [tmpMembersArray addObject: member];
                }
                
            }];
        }
            break;
            
        default:
            break;
    }
    
    self.membersArray = tmpMembersArray.copy;
}

- (void) configurateMembersArray
{    
    [self sortContentAccordingToType];
    
    [self updateSelectedUsers];
}

- (FilledTeamInfo*) convertObjectToTeamMember: (id) object
{
    FilledTeamInfo* selectedTeamMember = [FilledTeamInfo new];
    
    if ([object isKindOfClass: [ProjectTaskAssignee class]])
    {
        ProjectTaskAssignee* assignee = (ProjectTaskAssignee*)object;
        
        [selectedTeamMember convertAssigneeToTeamInfo: assignee];
    }
    
    else if ([object isKindOfClass: [ProjectInviteInfo class]])
    {
        ProjectInviteInfo* invite = (ProjectInviteInfo*)object;
        
        [selectedTeamMember convertInviteToTeamInfo: invite];
    }
    
    else if ([object isKindOfClass:[FilledTeamInfo class]])
    {
        selectedTeamMember = (FilledTeamInfo*)object;
    }
    
    return selectedTeamMember;
    
}


@end
