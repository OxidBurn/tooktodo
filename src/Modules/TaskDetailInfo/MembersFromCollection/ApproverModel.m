//
//  ApproverModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 25.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ApproverModel.h"

//Classes
#import "ProjectTask+CoreDataClass.h"
#import "DataManager+Tasks.h"
#import "ProjectTaskRoleAssignments+CoreDataClass.h"
#import "ProjectTaskRoleAssignment+CoreDataClass.h"
#import "TaskApprovments+CoreDataClass.h"

typedef NS_ENUM(NSUInteger, AssignmentRoleType)
{
    ResponsibleType,
    ClaimingsType,
    ObserverType,
};

@interface ApproverModel()

// properties
@property (nonatomic, strong) ProjectTask* task;
@property (nonatomic, strong) NSArray*     approversArray;
@property (nonatomic, strong) NSArray* approversIDsArray;

// methods

@end

@implementation ApproverModel


#pragma mark - Properties -

- (ProjectTask*) task
{
    if (_task == nil)
    {
        _task = [DataManagerShared getSelectedTask];
    }
    
    return _task;
}

- (NSArray*) approversArray
{
    if (_approversArray == nil)
    {
        _approversArray = [self getTaskApprovers];
    }
    
    return _approversArray;
}

- (NSArray*) approversIDsArray
{
    if ( _approversIDsArray == nil )
    {
        NSMutableArray* tmpArr = [NSMutableArray arrayWithCapacity: self.task.approvments.count];
        
        [self.task.approvments enumerateObjectsUsingBlock:^(TaskApprovments * _Nonnull obj, BOOL * _Nonnull stop) {
            
            [tmpArr addObject: obj.approverUserId];
            
        }];
        
        _approversIDsArray = tmpArr.copy;
        
        tmpArr = nil;
    }
    
    return _approversIDsArray;
}


#pragma mark - Public -

- (NSUInteger) countOfRows
{
    return self.approversArray.count;
}

- (NSArray*) getTaskApprovers
{
    NSArray* roleAssignments = self.task.taskRoleAssignments.array;
    
    NSMutableArray* tmpClaimingsArr = [NSMutableArray array];
    
    [roleAssignments enumerateObjectsUsingBlock: ^(ProjectTaskRoleAssignments*  _Nonnull taskRoleAssignments, NSUInteger idx, BOOL * _Nonnull stop) {
        
        switch (taskRoleAssignments.taskRoleType.integerValue)
        {
        case ClaimingsType:
            {
                NSArray* taskRoleAss = taskRoleAssignments.projectRoleAssignment.array;
                
                [taskRoleAss enumerateObjectsUsingBlock:^(ProjectTaskRoleAssignment*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (obj.assignee || obj.invite)
                    {
                        NSArray* assigneeArr = obj.assignee.array;
                        NSArray* inviteArr   = obj.invite.array;
                        
                        [tmpClaimingsArr addObjectsFromArray: assigneeArr];
                        [tmpClaimingsArr addObjectsFromArray: inviteArr];
                    }
                    
                }];
            }
            break;
                
                default:
                break;
        }
    }];

    
    return tmpClaimingsArr.copy;
}

- (FilledTeamInfo*) getApproverUserForIndexPath: (NSUInteger) index
{
    return self.approversArray[index];
}

- (BOOL) isApprovedAssignee: (NSUInteger) index
{
    id assignment          = self.approversArray[index];
    NSNumber* assignmentID = @0;
    
    if ( [assignment isKindOfClass: [ProjectTaskAssignee class]] )
    {
        assignmentID = [(ProjectTaskAssignee*)assignment assigneeID];
    }
    else
    {
        assignmentID = [(ProjectInviteInfo*)assignment inviteID];
    }
    
    return ([self.approversIDsArray containsObject: assignmentID]);
}

@end
