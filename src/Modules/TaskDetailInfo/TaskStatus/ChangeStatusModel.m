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

@property (nonatomic, assign) TaskStatusType statusType;

@property (nonatomic, strong) ProjectTask* task;

@property (nonatomic, assign) TaskStatusType currentStatus;

// methods

@end

@implementation ChangeStatusModel


#pragma mark - Public -

- (NSString*) getStatusName: (TaskStatusType) statusType
{
    
    NSString* statusName = @"";
    
    switch ( statusType )
    {
        case TaskWaitingStatusType:
        {
            
            statusName = @"В ожидании";
            
        }
            break;
            
        case TaskInProgressStatusType:
        {
            statusName = @"В работе";
            
        }
            break;
            
        case TaskCompletedStatusType:
        {
            statusName = @"Завершена";
        }
            break;
            
        case TaskOnApprovingStatusType:
        {
            statusName = @"На утверждении";
        }
            break;
            
        case TaskOnCompletionStatusType:
        {
            statusName = @"Доработка";
        }
            break;
            
        case TaskCanceledStatusType:
        {
            statusName = @"Отменена";
            
        }
            break;
            
        default:
            break;
    }
    
    return statusName;
}

- (UIColor*) getBackgroundColor: (TaskStatusType) statusType
{
    
    UIColor* backgroundColor = [UIColor clearColor];
    
    switch ( statusType )
    {
        case TaskWaitingStatusType:
        {
    
          backgroundColor = [UIColor colorWithRed: 255.0/256
                                            green: 228.0/256
                                             blue: 69.0/256
                                            alpha: 1.f];
            
        }
            break;
            
         
        case TaskCompletedStatusType:
        {
            backgroundColor = [UIColor cyanColor];
        }
            break;
            
        case TaskInProgressStatusType:
        {
            backgroundColor = [UIColor colorWithRed: 79.0/256
                                              green: 197.0/256
                                               blue: 45.0/256
                                              alpha: 1.f];

        }
            break;
            
        case TaskOnApprovingStatusType:
        {
            backgroundColor = [UIColor colorWithRed: 250.0/256
                                              green: 216.0/256
                                               blue: 64.0/256
                                              alpha: 1.f];
        }
            break;
            
        case TaskOnCompletionStatusType:
        {
            backgroundColor = [UIColor brownColor];
        }
            break;
            
        case TaskCanceledStatusType:
        {
            backgroundColor =  [UIColor colorWithRed: 255.0/256
                                               green: 70.0/256
                                                blue: 70.0/256
                                               alpha: 1.f];
        }
            break;
    }
    
    return backgroundColor;
}

- (UIImage*) getStatusImage: (TaskStatusType) statusType
{
    
    UIImage* statusImage = nil;
    
    switch ( statusType )
    {
        case TaskWaitingStatusType:
        {
            statusImage = [UIImage imageNamed: @"TaskStatusWaitingIcon"];
            
        }
            break;
            
        
        case TaskCompletedStatusType:
        {
            statusImage = nil;
        }
            break;
            
        case TaskInProgressStatusType:
        {
            statusImage = [UIImage imageNamed: @"TaskStatusInProgressIcon"];
            
        }
            break;
            
        case TaskOnApprovingStatusType:
        {
            statusImage = [UIImage imageNamed: @"TaskStatusOnApproveIcon"];
        }
            break;
            
        case TaskOnCompletionStatusType:
        {
            
        }
            break;
            
        case TaskCanceledStatusType:
        {
            statusImage = [UIImage imageNamed: @"TaskStatusCanceledIcon"];
        }
            break;
    }
    
    return statusImage;
}

- (NSInteger) numberOfRows
{
    return self.statusesArray.count;
}

- (TaskStatusType) getCurrentStatus
{
    self.task = [DataManagerShared getSelectedTask];
    
    self.currentStatus = self.task.status.integerValue;
    
    return self.currentStatus;
}

@end

