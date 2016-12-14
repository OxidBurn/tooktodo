//
//  TaskStatusDefaultValues.m
//  TookTODO
//
//  Created by Nikolay Chaban on 13.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskStatusDefaultValues.h"

// Classes
#import "ProjectsEnumerations.h"

@interface TaskStatusDefaultValues()

// properties
@property (strong, nonatomic) NSArray* titlesInfoArray;

@property (strong, nonatomic) NSArray* colorsInfoArray;

@property (strong, nonatomic) NSArray* imagesInfoArray;

@property (strong, nonatomic) UIColor* yellowColor;

@property (strong, nonatomic) UIColor* greenColor;

@property (strong, nonatomic) UIColor* redColor;

// methods


@end

@implementation TaskStatusDefaultValues


#pragma mark - Properties -

- (UIColor*) yellowColor
{
    if ( _yellowColor == nil )
    {
        _yellowColor = [UIColor colorWithRed: 248.0/256
                                       green: 216.0/256
                                        blue: 24.0/256
                                       alpha: 1.f];
    }
    
    return _yellowColor;
}

- (UIColor*) greenColor
{
    if ( _greenColor == nil )
    {
        _greenColor = [UIColor colorWithRed: 79.0/256
                                      green: 197.0/256
                                       blue: 45.0/256
                                      alpha: 1.f];
    }
    
    return _greenColor;
}

- (UIColor*) redColor
{
    if ( _redColor == nil )
    {
        _redColor = [UIColor colorWithRed: 255.0/256
                                    green: 70.0/256
                                     blue: 70.0/256
                                    alpha: 1.f];
    }
    
    return _redColor;
}

- (NSArray*) titlesInfoArray
{
    if ( _titlesInfoArray == nil )
    {
        _titlesInfoArray = @[ @"Ожидание",
                              @"В работе",
                              @"Завершена",
                              @"Отменена",
                              @"На утверждении",
                              @"На доработке",
                              @"Запрос на отмену",
                              @"На доработку",
                              @"Возобновить",
                              @"Утвердить"];
    }
    
    return _titlesInfoArray;
}

- (NSArray*) colorsInfoArray
{
    if ( _colorsInfoArray == nil )
    {                                               // values of statuses and descriptions
        _colorsInfoArray = @[ self.yellowColor,     //0 ToPause
                              self.greenColor,      //1 ToInWork
                              self.greenColor,      //2 Complete
                              self.redColor,        //3 Cancel
                              self.yellowColor,     //4 ToOnApproval
                              self.yellowColor,     //5 OnRework
                              self.redColor,        //6 ToCancel
                              self.yellowColor,     //7 ToRework
                              self.greenColor,      //8 Renew
                              self.greenColor];     //9 Approve
    }
    
    return _colorsInfoArray;
}

- (NSArray*) imagesInfoArray
{
    if ( _imagesInfoArray == nil )
    {
        _imagesInfoArray = @[ [UIImage imageNamed: @"TaskStatusWaitingIcon"],
                              [UIImage imageNamed: @"TaskStatusInProgressIcon"],
                              [UIImage imageNamed: @"TaskStatusDone"],
                              [UIImage imageNamed: @"TaskStatusCanceledIcon"],
                              [UIImage imageNamed: @"TaskStatusOnApproveIcon"],
                              [UIImage imageNamed: @"TaskStatusOnCompletion"],
                              [UIImage imageNamed: @"TaskStatusCanceledIcon"],
                              [UIImage imageNamed: @"TaskStatusOnCompletion"],
                              [UIImage imageNamed: @"TaskStatusInProgressIcon"],
                              [UIImage imageNamed: @"TaskStatusOnCompletion"]];
    }
    
    return _imagesInfoArray;
}

#pragma mark - Public -

+ (instancetype) sharedInstance
{
    static TaskStatusDefaultValues* instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [TaskStatusDefaultValues new];
    });
    
    return instance;
}

- (UIColor*) returnColorForTaskStatus: (TaskStatusType) statusType
{
    return self.colorsInfoArray[statusType];
}

- (NSString*) returnTitleForTaskStatus: (TaskStatusType) statusType
{
    return self.titlesInfoArray[statusType];
}

- (UIImage*) returnIconImageForTaskStatus: (TaskStatusType) statusType
{
    return self.imagesInfoArray[statusType];
}

- (UIColor*) returnFontColorForTaskStatus: (TaskStatusType) statusType
{
    switch ( statusType )
    {
        case TaskToPauseStatusType:
        case TaskToOnApprovalStatusType:
        case TaskToReworkStatusType:
        case TaskOnReworkStatusType:
            
            return [UIColor blackColor];
            
            break;
            
        case TaskCancelStatusType:
        case TaskCompleteStatusType:
        case TaskToInWorkStatusType:
        case TaskToCancelStatusType:
        case TaskRenewStatusType:
        case TaskApproveStatusType:
            
            return [UIColor whiteColor];
            
        default:
            break;
    }
    
    return nil;
}

- (UIImage*) returnArrowImageForTaskStatus: (TaskStatusType) statusType
{
    switch ( statusType )
    {
        case TaskToPauseStatusType:
        case TaskToOnApprovalStatusType:
        case TaskToReworkStatusType:
        case TaskOnReworkStatusType:
            
            return [UIImage imageNamed: @"TaskStatusExpandDarkIcon"];
            
            break;
            
        case TaskCancelStatusType:
        case TaskCompleteStatusType:
        case TaskToInWorkStatusType:
        case TaskToCancelStatusType:
        case TaskApproveStatusType:
        case TaskRenewStatusType:
            
            return [UIImage imageNamed: @"TaskStatusExpandWhiteIcon"];
            
        default:
            break;
    }
    
    return nil;
}

- (UIImage*) returnExpandedArrowImageForTaskStatus: (TaskStatusType) statusType
{
    switch ( statusType )
    {
        case TaskToPauseStatusType:
        case TaskToOnApprovalStatusType:
        case TaskToReworkStatusType:
        case TaskOnReworkStatusType:
            
            return [UIImage imageNamed: @"TaskStatusExpandDarkIconTurn"];
            
            break;
            
        case TaskCancelStatusType:
        case TaskCompleteStatusType:
        case TaskToInWorkStatusType:
        case TaskToCancelStatusType:
        case TaskRenewStatusType:
        case TaskApproveStatusType:
            
            return [UIImage imageNamed: @"TaskStatusExpandWhiteIconTurn"];
            
        default:
            break;
    }
    
    return nil;
}

@end
