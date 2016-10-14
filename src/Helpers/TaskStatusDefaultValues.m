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

// methods


@end

@implementation TaskStatusDefaultValues

#pragma mark - Properties -

- (NSArray*) titlesInfoArray
{
    if ( _titlesInfoArray == nil )
    {
        _titlesInfoArray = @[ @"В ожидании",
                              @"В работе",
                              @"Завершена",
                              @"Отменена",
                              @"На утверждении",
                              @"На доработке" ];
    }
    
    return _titlesInfoArray;
}

- (NSArray*) colorsInfoArray
{
    if ( _colorsInfoArray == nil )
    {
        _colorsInfoArray = @[ [UIColor colorWithRed: 255.0/256
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
                              
                              [UIColor brownColor] ];
    }
    
    return _colorsInfoArray;
}

- (NSArray*) imagesInfoArray
{
    if ( _imagesInfoArray == nil )
    {
        _imagesInfoArray = @[ [UIImage imageNamed: @"TaskStatusWaitingIcon"],
                              [UIImage imageNamed: @"TaskStatusInProgressIcon"],
                              [UIImage imageNamed: @"CheckMarkGreen"],
                              [UIImage imageNamed: @"TaskStatusCanceledIcon"],
                              [UIImage imageNamed: @"TaskStatusOnApproveIcon"],
                              [UIImage imageNamed: @"ArrowSend"]];
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

@end
