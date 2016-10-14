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

@interface ChangeStatusModel() <TaskDetailModelDelegate>

// properties
@property (nonatomic, strong) NSArray* statusesArray;
@property (nonatomic, strong) NSArray* statusNames;
@property (nonatomic, strong) NSArray* statusImages;
@property (nonatomic, strong) NSArray* backgrounds;
@property (nonatomic, assign) TaskStatusType statusType;
@property (nonatomic, strong) ProjectTask* task;
@property (nonatomic, assign) TaskStatusType currentStatus;


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


#pragma mark - Public -

- (NSString*) getStatusNameForIndex: (NSUInteger) index
{
    NSNumber* idx = self.statusesArray[index];
    
    return [[TaskStatusDefaultValues sharedInstance] returnTitleForTaskStatus: idx.integerValue];
}

- (UIColor*) getBackgroundColorForIndex: (NSUInteger) index
{
    NSNumber* idx = self.statusesArray[index];
    
    return [[TaskStatusDefaultValues sharedInstance] returnColorForTaskStatus: idx.integerValue];
}

- (UIImage*) getStatusImageForIndex: (NSUInteger) index
{
    NSNumber* idx = self.statusesArray[index];

    return [[TaskStatusDefaultValues sharedInstance] returnIconImageForTaskStatus: idx.integerValue];
}

- (NSInteger) numberOfRows
{
    return self.statusesArray.count;
}

- (TaskStatusType) getCurrentStatus
{
    self.task = [DataManagerShared getSelectedTask];
    
    return self.task.status.integerValue;
}

- (NSUInteger) returnOnComletionStatusIndex
{
    NSUInteger index = [self.statusesArray indexOfObject: @(5)];
    
    return index;
}

#pragma mark - Internal -

- (NSArray*) orderStatusesArray
{
    NSArray* defaultArr = @[@(TaskWaitingStatusType),
                            @(TaskInProgressStatusType),
                            @(TaskCompletedStatusType),
                            @(TaskCanceledStatusType),
                            @(TaskOnApprovingStatusType),
                            @(TaskOnCompletionStatusType)];
    
    NSNumber* currStatus = @([self getCurrentStatus]);
    
    NSMutableArray* tmp = defaultArr.mutableCopy;
    
    [tmp exchangeObjectAtIndex: TaskCanceledStatusType
             withObjectAtIndex: TaskOnCompletionStatusType];
    
    [defaultArr enumerateObjectsUsingBlock:^(NSNumber* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isEqual: currStatus])
        {
            [tmp exchangeObjectAtIndex: idx
                     withObjectAtIndex: 0];
            
            
        }
    }];
    
    return tmp.copy;
}

@end

