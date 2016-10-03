//
//  SelectResponsibleModel.m
//  TookTODO
//
//  Created by Глеб on 22.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectResponsibleModel.h"


// Classes
#import "DataManager+Tasks.h"
#import "DataManager+ProjectInfo.h"
#import "TeamService.h"
#import "ProjectInfo+CoreDataClass.h"


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
{
    self.controllerType = controllerType;
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
            
            if ( [indexPath isEqual: self.previousesSelectedIndexPath] == NO )
            {
            [self.membersArray enumerateObjectsUsingBlock: ^(FilledTeamInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                obj.isResponsible = NO;
                
                if ( idx == indexPath.row )
                {
                    obj.isResponsible = YES;
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
                        
            if ( user.isClaiming == NO )
            {
                user.isClaiming = YES;
                
                if ( self.selectedClaimingArray == nil )
                {
                    self.selectedClaimingArray = [NSArray arrayWithObject: user];
                } else
                {
                    NSMutableArray* selectedArrayCopy = self.selectedClaimingArray.mutableCopy;
                
                    [selectedArrayCopy addObject: user];
                
                    self.selectedClaimingArray = [selectedArrayCopy copy];
                }
                
            } else
                if ( user.isClaiming )
                {
                    user.isClaiming = NO;
                    
                    [self.selectedClaimingArray enumerateObjectsUsingBlock: ^(FilledTeamInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ( [obj.userId isEqual: user.userId] )
                        {
                            NSMutableArray* selectedArrayCopy = self.selectedClaimingArray.mutableCopy;
                            
                            [selectedArrayCopy removeObject: obj];
                            
                            self.selectedClaimingArray = [selectedArrayCopy copy];
                        }
                    }];
                }
        }
            break;
            
        case SelectObserversController:
        {
            FilledTeamInfo* user = self.membersArray[indexPath.row];
            
            if ( user.isObserver == NO )
            {
                user.isObserver = YES;
                
                if ( self.selectedObserversArray == nil )
                {
                    self.selectedObserversArray = [NSArray arrayWithObject: user];
                } else
                {
                    NSMutableArray* selectedArrayCopy = self.selectedObserversArray.mutableCopy;
                    
                    [selectedArrayCopy addObject: user];
                    
                    self.selectedObserversArray = [selectedArrayCopy copy];
                }
                
            } else
                if ( user.isObserver )
                {
                    user.isObserver = NO;
                    
                    [self.selectedObserversArray enumerateObjectsUsingBlock:^(FilledTeamInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ( [obj.userId isEqual: user.userId] )
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

- (BOOL) getStateForMemberAtIndex: (NSUInteger) index
{
    FilledTeamInfo* memberInfo = self.membersArray[index];
    
    return memberInfo.isResponsible;
}

- (void) fillSelectedUsersInfo: (NSArray*) selectedUsers
{
    switch ( self.controllerType )
    {
        case SelectResponsibleController:
            
            self.selectedResponsibleArray = selectedUsers;

            break;
            
        case SelectClaimingController:
            
            self.selectedClaimingArray = selectedUsers;

            break;
            
        case SelectObserversController:
            
            self.selectedObserversArray = selectedUsers;

            break;
            
        default:
            break;
    }
}

- (void) updateTeamInfoWithCompletion: (CompletionWithSuccess) completion
{
    [[[[TeamService sharedInstance] getTeamInfo] subscribeOn: [RACScheduler mainThreadScheduler]]
     subscribeNext: ^(NSArray* teamInfo)
    {
        
         __block NSMutableArray* tmpTeamList = [NSMutableArray array];
         
        [teamInfo enumerateObjectsUsingBlock: ^(ProjectRoleAssignments* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            FilledTeamInfo* teamMemberInfo = [FilledTeamInfo new];
            
            [teamMemberInfo fillTeamInfo: obj];
            
            [tmpTeamList addObject: teamMemberInfo];
            
        }];
         
         self.membersArray = tmpTeamList.copy;
        
        [self updateSelectedUsers];
         
         tmpTeamList = nil;
         
         if ( completion )
             completion (YES);
         
     }
     error: ^(NSError* error) {
         
         if ( completion )
             completion (NO);
     }
     completed: ^{
         
         if ( completion )
             completion (YES);
     }];
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

- (void) selectAll
{
    [self.membersArray enumerateObjectsUsingBlock:^(FilledTeamInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.isObserver = YES;
    }];
    
    self.selectedObserversArray = [NSArray arrayWithArray: self.membersArray];
}

- (void) deselectAll
{
    [self.membersArray enumerateObjectsUsingBlock:^(FilledTeamInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.isObserver = NO;
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
                    
                    if ( [userInList.userId isEqual: selectedUser.userId] )
                    {
                        userInList.isResponsible = selectedUser.isResponsible;
                        
                        NSIndexPath* temp = [NSIndexPath indexPathForRow: idx inSection: 0];
                        
                        self.previousesSelectedIndexPath = temp;
                    }
                }];
                
            }];
        }
            break;
            
        case SelectClaimingController:
        {
            [self.membersArray enumerateObjectsUsingBlock: ^(FilledTeamInfo* userInList, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [self.selectedClaimingArray enumerateObjectsUsingBlock: ^(FilledTeamInfo* selectedUser, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if ( [userInList.userId isEqual: selectedUser.userId] )
                    {
                        userInList.isClaiming = selectedUser.isClaiming;
                    }
                }];
                
            }];
        }
            break;
            
        case SelectObserversController:
        {
            [self.membersArray enumerateObjectsUsingBlock: ^(FilledTeamInfo* userInList, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [self.selectedObserversArray enumerateObjectsUsingBlock: ^(FilledTeamInfo* selectedUser, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if ( [userInList.userId isEqual: selectedUser.userId] )
                    {
                        userInList.isObserver = selectedUser.isObserver;
                    }
                }];
                
            }];
        }
            break;
            
        default:
            break;
    }
}

@end
