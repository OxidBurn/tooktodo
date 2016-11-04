//
//  NSObject+Sorting.m
//  TookTODO
//
//  Created by Lera on 04.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "NSObject+Sorting.h"

@implementation NSObject (Sorting)

- (NSArray*) getPopoverContent
{
    NSArray* contentArr = @[@"Название",
                            @"Дата начала",
                            @"Дата завершения",
                            @"Факт. дата начала",
                            @"Факт. дата завершения",
                            @"Ответственный",
                            @"Помещение",
                            @"Система",
                            @"Статус"];
    
    return contentArr;
}

- (TasksSortingType) getTasksSortingType
{
    return [[ConfigurationManager sharedInstance] getTasksSortingType];
}

- (ContentAccedingSortingType) getTasksSortingAscendingType
{
    return [[ConfigurationManager sharedInstance] getAccedingTypeForTasks];
}

- (NSArray*) applyTasksSortingType: (TasksSortingType)           type
                           toArray: (NSArray*)                   array
                        isAcceding: (ContentAccedingSortingType) isAcceding
{
    [[ConfigurationManager sharedInstance] saveSortedTasks: type
                                         withAscendingType: isAcceding];
    
    return [self applyDefaultSorting: array
                         isAcsending: isAcceding];
}

#pragma mark - Internal methods -

- (NSArray*) applyDefaultSorting: (NSArray*) array
                     isAcsending: (BOOL)     isAcceding
{
    NSSortDescriptor* sortingDescriptor = [NSSortDescriptor sortDescriptorWithKey: [self getSortingKey]
                                                                        ascending: isAcceding];
    
    NSArray* sortedArray = [array sortedArrayUsingDescriptors: @[sortingDescriptor]];
    
    return sortedArray;
}

- (NSString*) getSortingKey
{
    TasksSortingType type = [[ConfigurationManager sharedInstance] getTasksSortingType];
    
    switch (type)
    {
        case SortByName:
        {
            return @"title";
            break;
        }
        case SortByStartDay:
        {
            return @"startDay";
            break;
        }
        case SortByEndDay:
        {
            return @"endDate";
            break;
        }
        case SortByFactStartDay:
        {
            return @"startDay";
            break;
        }
        case SortByFactEndDay:
        {
            return @"closedDate";
            break;
        }
        case SortByResponsible:
        {
            
            return @"responsible.lastName";
            break;
        }
        case SortByRoom:
        {
            return @"room.title";
            break;
        }
        case SortBySystem:
        {
            return @"workArea.title";
            break;
        }
        case SortByStatus:
        {
            return @"status";
            break;
        }
    }
}


@end
