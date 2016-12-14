//
//  ChangeStatusModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ChangeStatusModel.h"

//CLasses
#import "DataManager+Tasks.h"
#import "ProjectTask+CoreDataClass.h"
#import "ProjectsEnumerations.h"
#import "TaskDetailModel.h"
#import "TaskStatusDefaultValues.h"
#import "TaskAvailableActionsList+CoreDataClass.h"
#import "TaskAvailableStatusAction+CoreDataClass.h"
#import "TaskAvailableAction+CoreDataClass.h"

@interface ChangeStatusModel() <TaskDetailModelDelegate>

// properties
@property (nonatomic, strong) NSArray*       statusesArray;
@property (nonatomic, strong) NSArray*       statusNames;
@property (nonatomic, strong) NSArray*       statusImages;
@property (nonatomic, strong) NSArray*       backgrounds;
@property (nonatomic, assign) TaskStatusType statusType;
@property (nonatomic, strong) ProjectTask*   task;
@property (nonatomic, assign) TaskStatusType currentStatus;
@property (nonatomic, strong) NSArray*       availableStatusActions;

// methods

@end

@implementation ChangeStatusModel


#pragma mark - Properties -

- (NSArray*) statusesArray
{
    if (_statusesArray == nil)
    {
        _statusesArray = [self orderStatusesArray];
    }
    
    return _statusesArray;
}

- (ProjectTask*) task
{
    if ( _task == nil )
    {
        _task = [DataManagerShared getSelectedTask];
    }
    
    return _task;
}


#pragma mark - Public -

- (CGFloat) countTableViewHeight
{
    return self.statusesArray.count * 44.f;
}

- (NSInteger) numberOfRows
{
    return self.statusesArray.count;
}

- (TaskStatusType) getCurrentStatus
{
    return self.task.status.integerValue;
}

- (TaskStatusType) getStatusTypeForRow: (NSUInteger) row
{
    NSNumber* statusNumberValue = self.statusesArray[row];
    
    TaskStatusType statusType = statusNumberValue.integerValue;

    return statusType;
}

//Method for getting available status actions for current user
- (NSArray*) getAvailableStatusActions
{
    self.task = [DataManagerShared getSelectedTask];
    
    TaskAvailableActionsList* availableActions = self.task.availableActions;
    
    self.availableStatusActions = availableActions.statusActions.allObjects;
    
    return  self.availableStatusActions;
}

- (TaskStatusType) checkIfUserCanCancelTask
{
    [self getAvailableStatusActions];

    BOOL canCancelTask = NO;
    
    if ( [self.availableStatusActions containsObject: @(TaskCancelStatusType)] )
        canCancelTask = YES;
    
    return canCancelTask? TaskCancelStatusType : TaskToCancelStatusType;
}

- (NSUInteger) returnOnComletionStatusIndex
{
    NSUInteger index = [self.statusesArray indexOfObject: @(TaskToReworkStatusType)];
    
    return index;
}

- (NSUInteger) returnCancelRequestStatusIndex
{
    if ([self checkIfUserCanCancelTask] == TaskToCancelStatusType)
    {
        NSUInteger index = [self.statusesArray indexOfObject: @(TaskCancelStatusType)];
        
        return index;
    }
    
    return -1;
}

- (void) updateTaskStatusWithNewStatus: (TaskStatusType)        status
                        withCompletion: (CompletionWithSuccess) completion
{
    
    NSNumber* statusValue = @(status);
    
    [DataManagerShared updateStatusType: statusValue
                  withStatusDescription: [[TaskStatusDefaultValues sharedInstance]
                                          returnTitleForTaskStatus: status]
                         withCompletion: completion];
}

- (UIImage*) getExpandedArrowMarkImage
{
    return [[TaskStatusDefaultValues sharedInstance]
            returnExpandedArrowImageForTaskStatus: self.task.status.integerValue];
}

#pragma mark - Internal -

- (NSArray*) orderStatusesArray
{
    // getting all available status actions
    NSArray* availableStatusActions = self.task.availableActions.statusActions.allObjects;
    
    // creating array with IDs of available actions
    NSMutableArray* tmpDefaultArray = [NSMutableArray new];
    
    [availableStatusActions enumerateObjectsUsingBlock: ^(TaskAvailableStatusAction* action, NSUInteger idx, BOOL * _Nonnull stop) {
       
            [tmpDefaultArray addObject: action.statusActionID];
    }];
    
    NSArray* defaultArr = tmpDefaultArray.copy;
    
    // sorting array with statuses ascending
    NSArray* sortedArray = [defaultArr sortedArrayUsingComparator: ^NSComparisonResult(id obj1, id obj2){
                                return [obj1 compare:obj2];
                            }];
    
    defaultArr = sortedArray;
    
    // checking current status for displaying it first in list
    NSNumber* currStatus = self.task.status;
    
    // replacing Cancel action to last position if it exsists
    NSMutableArray* tmp = defaultArr.mutableCopy;
    
    if ( [tmp containsObject: @(TaskCancelStatusType)] )
    {
        NSUInteger indexOfCancel = [tmp indexOfObject: @(TaskCancelStatusType)];
        
        NSUInteger indexOfLastAction = defaultArr.count - 1;
        
        [tmp exchangeObjectAtIndex: indexOfCancel
                 withObjectAtIndex: indexOfLastAction ];
    }
    
    // moving current status to first position
    [tmp enumerateObjectsUsingBlock: ^(NSNumber* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isEqual: currStatus])
        {
            [tmp exchangeObjectAtIndex: idx
                     withObjectAtIndex: 0];
        }
    }];
    
    // checking if array with statuses contains current task status
    // if not adding this status to first position
    
    if ( [tmp containsObject: currStatus] == NO )
    {
        [tmp insertObject: currStatus
                  atIndex: 0];
    }
    
    return tmp.copy;
}

@end

