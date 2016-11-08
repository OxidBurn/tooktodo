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
    
    NSUInteger currentCancelType = [self.statusesArray indexOfObject: @(TaskCanceledStatusType)];
    
    if (row == currentCancelType)
    {
        statusType =  [self checkIfUserCanCancelTask];
    }
    
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
    
    __block BOOL canCancelTask = NO;
    
    if (self.availableStatusActions != nil)
    {
        [self.availableStatusActions enumerateObjectsUsingBlock: ^(TaskAvailableStatusAction* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.stautsActionDescription isEqualToString: @"Отменить"])
            {
                 canCancelTask = YES;
                
                *stop = YES;
            }
            
            else canCancelTask = NO;
            
        }];
        
        return canCancelTask ? TaskCanceledStatusType : TaskCancelRequestType;
    }
    
    return TaskCanceledStatusType;
}

- (NSUInteger) returnOnComletionStatusIndex
{
    NSUInteger index = [self.statusesArray indexOfObject: @(TaskOnCompletionStatusType)];
    
    return index;
}

- (NSUInteger) returnCancelRequestStatusIndex
{
    if ([self checkIfUserCanCancelTask] == TaskCancelRequestType)
    {
        NSUInteger index = [self.statusesArray indexOfObject: @(TaskCancelRequestType)];
        
        return index;
    }
    
    return -1;
}

- (void) updateTaskStatusWithNewStatus: (TaskStatusType)        status
                        withCompletion: (CompletionWithSuccess) completion
{
    NSNumber* statusValue = self.statusesArray[status];
    
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
    NSArray* defaultArr = @[@(TaskWaitingStatusType),
                            @(TaskInProgressStatusType),
                            @(TaskOnApprovingStatusType),
                            @(TaskCompletedStatusType),
                            @(TaskCanceledStatusType),
                            @(TaskOnCompletionStatusType)];
    
    NSNumber* currStatus = self.task.status;
    
    NSMutableArray* tmp = defaultArr.mutableCopy;
    
    [tmp exchangeObjectAtIndex: TaskCanceledStatusType
             withObjectAtIndex: TaskOnCompletionStatusType];
    
    [tmp enumerateObjectsUsingBlock: ^(NSNumber* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isEqual: currStatus])
        {
            [tmp exchangeObjectAtIndex: idx
                     withObjectAtIndex: 0];
        }
    }];
    
    return tmp.copy;
}

@end

