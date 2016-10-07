//
//  AddTaskTypeModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/7/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskTypeModel.h"

// Classes
#import "ProjectsEnumerations.h"

@implementation AddTaskTypeModel


#pragma mark - Public methods -

- (UIColor*) getTaskTypeColor: (TaskType) type
{
    UIColor* typeColor = [UIColor clearColor];
    
    switch (type)
    {
        case TaskWorkType:
            typeColor = [UIColor colorWithRed:0.310 green:0.773 blue:0.176 alpha:1.000];
            break;
            
        case TaskAgreementType:
            typeColor = [UIColor colorWithRed:0.424 green:0.663 blue:0.792 alpha:1.000];
            break;
            
        case TaskObservationType:
            typeColor = [UIColor colorWithRed:1.00 green:0.89 blue:0.27 alpha:1.00];
            break;
            
        case TaskRemarkType:
            typeColor = [UIColor colorWithRed:0.961 green:0.651 blue:0.137 alpha:1.000];
            break;
    }
    
    return typeColor;
}

- (NSString*) getTaskTypeDescription: (TaskType) type
{
    NSString* typeDescription = @"";
    
    switch (type)
    {
        case TaskWorkType:
            typeDescription = @"Работа";
            break;
            
        case TaskAgreementType:
            typeDescription = @"Согласование";
            break;
            
        case TaskObservationType:
            typeDescription = @"Наблюдение";
            break;
            
        case TaskRemarkType:
            typeDescription = @"Замечание";
            break;
    }
    
    return typeDescription;
}

@end
