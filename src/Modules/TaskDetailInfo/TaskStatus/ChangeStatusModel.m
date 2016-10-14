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

- (NSArray*) statusNames
{
    if (_statusNames == nil)
    {
        _statusNames = @[@"В ожидании",
                         @"В работе",
                         @"Завершена",
                         @"Отменена",
                         @"На утверждении",
                         @"Доработка"];
    }
    
    return _statusNames;
}

- (NSArray*) backgrounds
{
    if (_backgrounds == nil)
    {
        _backgrounds = @[  [UIColor colorWithRed: 255.0/256
                                           green: 228.0/256
                                            blue: 69.0/256
                                           alpha: 1.f],
                           
                           [UIColor colorWithRed: 79.0/256
                                           green: 197.0/256
                                            blue: 45.0/256
                                           alpha: 1.f],
                           
                           [UIColor cyanColor],
                           
                           
                           [UIColor colorWithRed: 255.0/256
                                           green: 70.0/256
                                            blue: 70.0/256
                                           alpha: 1.f],
                           
                           
                           [UIColor colorWithRed: 250.0/256
                                           green: 216.0/256
                                            blue: 64.0/256
                                           alpha: 1.f],
                           
                           [UIColor brownColor]
                           
                           ];
  
    }
    return _backgrounds;
}

- (NSArray*) statusImages
{
    if (_statusImages == nil)
    {
        _statusImages = @[[UIImage imageNamed: @"TaskStatusWaitingIcon"],
                          [UIImage imageNamed: @"TaskStatusInProgressIcon"],
                          [UIImage imageNamed: @"TaskStatusOnApproveIcon"],
                          [UIImage imageNamed: @"TaskStatusCanceledIcon"],
                          [UIImage imageNamed: @"TaskStatusOnApproveIcon"],
                          [UIImage imageNamed: @"TaskStatusOnApproveIcon"]];
    }
    
    return _statusImages;
}

#pragma mark - Public -

- (NSString*) getStatusNameForIndex: (NSUInteger) index
{
    NSNumber* idx = self.statusesArray[index];
    
    return self.statusNames[idx.integerValue];
}

- (UIColor*) getBackgroundColorForIndex: (NSUInteger) index
{
    NSNumber* idx = self.statusesArray[index];

    return self.backgrounds[idx.integerValue];
}

- (UIImage*) getStatusImageForIndex: (NSUInteger) index
{
    NSNumber* idx = self.statusesArray[index];

    return self.statusImages[idx.integerValue];
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

