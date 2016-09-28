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

@property (strong, nonatomic) NSArray* selectedUsersArray;

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
            if ( [indexPath isEqual: self.previousesSelectedIndexPath] == NO )
            {
            [self.membersArray enumerateObjectsUsingBlock: ^(FilledTeamInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                obj.isResponsible = NO;
                
                if ( idx == indexPath.row )
                {
                    obj.isResponsible = YES;
                }
            }];
                
                self.selectedUsersArray = @[ self.membersArray[indexPath.row] ];
            }
            else
            {                
                self.selectedUsersArray = nil;
            }
        }
            
            break;
            
        case SelectClaimingController:
        case SelectObserversController:
            
        {
            FilledTeamInfo* user = self.membersArray[indexPath.row];
            
            user.isResponsible = !user.isResponsible;
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

- (NSArray*) returnSelectedUsersInfo
{
    return self.selectedUsersArray;
}
@end
