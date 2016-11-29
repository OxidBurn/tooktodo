//
//  FilterParametersManager+ProjectTasksFilterParser.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterParametersManager+ProjectTasksFilterParser.h"

// Classes
#import "ProjectTaskAssignee+CoreDataClass.h"
#import "ProjectTaskResponsible+CoreDataClass.h"
#import "DataManager+Filters.h"
#import "ProjectTaskFilterContent+CoreDataClass.h"
#import "FilterTagParameterInfo.h"
#import "ProjectTaskResponsible+CoreDataClass.h"
#import "ProjectInviteInfo+CoreDataClass.h"
#import "ProjectTaskRoom+CoreDataClass.h"
#import "ProjectTaskWorkArea+CoreDataClass.h"

@implementation FilterParametersManager (ProjectTasksFilterParser)

- (NSArray*) parseContentForProjectTasks
{
    ProjectTaskFilterContent* filterContent = [DataManagerShared getFilterContentForSelectedProject];
    
    __block NSMutableArray* tmpFilterParametersContent = [NSMutableArray array];
    
    // Creators
    NSArray* creators = [self getCreatorsInfo: filterContent
                                      fromTag: tmpFilterParametersContent.count];
    
    [tmpFilterParametersContent addObjectsFromArray: creators];
    
    // Responsibles
    NSArray* responsibles = [self getResponsiblesInfo: filterContent
                                              fromTag: tmpFilterParametersContent.count];
    
    [tmpFilterParametersContent addObjectsFromArray: responsibles];
    
    // Approvements
    NSArray* approvements = [self getApprovementsInfo: filterContent
                                              fromTag: tmpFilterParametersContent.count];
    
    [tmpFilterParametersContent addObjectsFromArray: approvements];
    
    // Statuses
    NSArray* statuses = [self getStatusesInfo: filterContent
                                      fromTag: tmpFilterParametersContent.count];
    
    [tmpFilterParametersContent addObjectsFromArray: statuses];
    
    // Dates
    NSArray* dates = [self getDatesInfo: filterContent
                                fromTag: tmpFilterParametersContent.count];
    
    [tmpFilterParametersContent addObjectsFromArray: dates];
    
    // Rooms
    NSArray* rooms = [self getRoomsInfo: filterContent
                                fromTag: tmpFilterParametersContent.count];
    
    [tmpFilterParametersContent addObjectsFromArray: rooms];
    
    // Work areas
    NSArray* workAreas = [self getWorkAreasInfo: filterContent
                                        fromTag: tmpFilterParametersContent.count];
    
    [tmpFilterParametersContent addObjectsFromArray: workAreas];
    
    // Types
    NSArray* types = [self getTypesInfo: filterContent
                                fromTag: tmpFilterParametersContent.count];
    
    [tmpFilterParametersContent addObjectsFromArray: types];
    
    // Boolean values
    NSArray* booleans = [self getBooleansInfo: filterContent
                                      fromTag: tmpFilterParametersContent.count];
    
    [tmpFilterParametersContent addObjectsFromArray: booleans];
    
    return tmpFilterParametersContent;
}


#pragma mark - Parsed methods -

- (NSArray*) getCreatorsInfo: (ProjectTaskFilterContent*) content
                     fromTag: (NSUInteger)                tag
{
    __block NSMutableArray* creators = [NSMutableArray array];
    
    // Check if user select all creators
    if ( content.creators.count == [[DataManagerShared getFilterCreatorsListForCurrentProject] count] )
    {
        FilterTagParameterInfo* creatorsInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Создатель"
                                                                           withParameterType: CreatorsAllFilterParameter
                                                                            withParameterTag: 0
                                                                                   withValue: nil];
        
        [creators addObject: creatorsInfo];
    }
    else
    {
        [content.creators enumerateObjectsUsingBlock: ^(ProjectTaskAssignee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString* title = [NSString stringWithFormat: @"Соз: %@.%@", [obj.firstName substringToIndex: 1], obj.lastName];
            
            FilterTagParameterInfo* creatorsInfo = [[FilterTagParameterInfo alloc] initWithTitle: title
                                                                               withParameterType: CreatorsFilterParameter
                                                                                withParameterTag: tag + idx
                                                                                       withValue: obj.assigneeID];
            
            [creators addObject: creatorsInfo];
            
        }];
    }
    
    return creators;
}

- (NSArray*) getResponsiblesInfo: (ProjectTaskFilterContent*) content
                         fromTag: (NSUInteger)                tag
{
    __block NSMutableArray* responsibles = [NSMutableArray array];
    
    // Check if user select all responsibles
    if ( content.responsibles.count == [[DataManagerShared getFilterResponsiblesForCurrentProject] count] )
    {
        FilterTagParameterInfo* responsibleInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Ответственный"
                                                                              withParameterType: ResponsiblesAllFilterParamter
                                                                               withParameterTag: tag
                                                                                      withValue: nil];
        
        [responsibles addObject: responsibleInfo];
    }
    else
    {
        [content.responsibles enumerateObjectsUsingBlock: ^(ProjectTaskAssignee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString* title = [NSString stringWithFormat: @"Отв: %@.%@", [obj.firstName substringToIndex: 1], obj.lastName];
            NSNumber* value = @0;
            
            if ( [obj isKindOfClass: [ProjectTaskAssignee class]] )
            {
                value = obj.assigneeID;
            }
            else
            {
                value = [(ProjectTaskResponsible*)obj responsibleID];
            }
            
            FilterTagParameterInfo* creatorsInfo = [[FilterTagParameterInfo alloc] initWithTitle: title
                                                                               withParameterType: ResponsiblesFilterParamter
                                                                                withParameterTag: tag + idx
                                                                                       withValue: value];
            
            [responsibles addObject: creatorsInfo];
            
        }];
    }
    
    return responsibles;
}

- (NSArray*) getApprovementsInfo: (ProjectTaskFilterContent*) content
                         fromTag: (NSUInteger)                tag
{
    __block NSMutableArray* approvements = [NSMutableArray array];
    
    // Check if user select all responsibles
    NSUInteger count = content.approvementsInvite.count + content.approvementsAssignee.count;
    
    if ( count == [[DataManagerShared getFilterApprovesForCurrentProject] count] )
    {
        FilterTagParameterInfo* approvementsInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Утверждающий"
                                                                               withParameterType: ApprovesAllFilterParameter
                                                                                withParameterTag: tag
                                                                                       withValue: nil];
        
        [approvements addObject: approvementsInfo];
    }
    else
    {
        [content.approvementsAssignee enumerateObjectsUsingBlock: ^(ProjectTaskAssignee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString* title = [NSString stringWithFormat: @"Утв: %@.%@", [obj.firstName substringToIndex: 1], obj.lastName];
            
            FilterTagParameterInfo* approvement = [[FilterTagParameterInfo alloc] initWithTitle: title
                                                                              withParameterType: ApprovesFilterParameter
                                                                               withParameterTag: tag + idx
                                                                                      withValue: obj.assigneeID];
            
            [approvements addObject: approvement];
            
        }];
        
        [content.approvementsInvite enumerateObjectsUsingBlock: ^(ProjectInviteInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString* title = [NSString stringWithFormat: @"Утв: %@.%@", [obj.firstName substringToIndex: 1], obj.lastName];
            
            FilterTagParameterInfo* approvement = [[FilterTagParameterInfo alloc] initWithTitle: title
                                                                              withParameterType: ApprovesFilterParameter
                                                                               withParameterTag: tag + idx
                                                                                      withValue: obj.inviteID];
            
            [approvements addObject: approvement];
            
        }];
    }
    
    return approvements;
}

- (NSArray*) getStatusesInfo: (ProjectTaskFilterContent*) content
                     fromTag: (NSUInteger)                tag
{
    __block NSMutableArray* statuses = [NSMutableArray array];
    NSArray* statusesContentInfo     = [DataManagerShared getFilterStatusesForCurrentProject];
    
    if ( [(NSArray*)content.statuses count] == statusesContentInfo.count )
    {
        FilterTagParameterInfo* statusesInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Статус"
                                                                           withParameterType: StatusesAllFilterParameter
                                                                            withParameterTag: tag
                                                                                   withValue: nil];
        
        [statuses addObject: statusesInfo];
    }
    else
    {
        
        [(NSArray*)content.statuses enumerateObjectsUsingBlock: ^(NSNumber*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSDictionary* statusDicInfo = statusesContentInfo[idx];
            
            FilterTagParameterInfo* statuseInfo = [[FilterTagParameterInfo alloc] initWithTitle: statusDicInfo[@"title"]
                                                                               withParameterType: StatusesFilterParameter
                                                                                withParameterTag: tag + idx
                                                                                       withValue: @(idx)];
            
            [statuses addObject: statuseInfo];
            
        }];
    }
    
    return statuses;
}

- (NSArray*) getDatesInfo: (ProjectTaskFilterContent*) content
                  fromTag: (NSUInteger)                tag
{
    __block NSMutableArray* dates = [NSMutableArray array];
    
    if ( content.startBeginDate || content.startEndDate )
    {
        FilterTagParameterInfo* startDateInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Срок начала"
                                                                            withParameterType: StartDateFilterParameter
                                                                             withParameterTag: tag
                                                                                    withValue: nil];
        
        [dates addObject: startDateInfo];
    }
    
    if ( content.closeBeginDate || content.closeEndDate )
    {
        FilterTagParameterInfo* endDateInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Срок окончания"
                                                                          withParameterType: EndDateFilterParameter
                                                                           withParameterTag: tag + dates.count
                                                                                  withValue: nil];
        
        [dates addObject: endDateInfo];
    }
    
    if ( content.factualStartBeginDate || content.factualStartEndDate )
    {
        FilterTagParameterInfo* factStartDateInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Факт. начало"
                                                                                withParameterType: FactualStartDateFilterParameter
                                                                                 withParameterTag: tag + dates.count
                                                                                        withValue: nil];
        
        [dates addObject: factStartDateInfo];
    }
    
    if ( content.factualCloseBeginDate || content.factualCloseEndDate )
    {
        FilterTagParameterInfo* factEndDateInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Факт. окончание"
                                                                              withParameterType: FactualStartDateFilterParameter
                                                                               withParameterTag: tag + dates.count
                                                                                      withValue: nil];
        
        [dates addObject: factEndDateInfo];
    }
    
    return dates;
}

- (NSArray*) getRoomsInfo: (ProjectTaskFilterContent*) content
                  fromTag: (NSUInteger)                tag
{
    __block NSMutableArray* rooms = [NSMutableArray array];
    
    if ( content.rooms.count == [[DataManagerShared getFilterRoomsForCurrentProject] count] )
    {
        FilterTagParameterInfo* allRoomsInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Помещение"
                                                                           withParameterType: RoomsAllFilterParameter
                                                                            withParameterTag: tag
                                                                                   withValue: nil];
        
        [rooms addObject: allRoomsInfo];
    }
    else
    {
        [content.rooms enumerateObjectsUsingBlock: ^(ProjectTaskRoom * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString* title = [NSString stringWithFormat: @"Пом: %@", obj.title];
            
            FilterTagParameterInfo* roomInfo = [[FilterTagParameterInfo alloc] initWithTitle: title
                                                                           withParameterType: RoomsFilterParameter
                                                                            withParameterTag: tag + idx
                                                                                   withValue: obj.roomID];
            
            [rooms addObject: roomInfo];
            
        }];
    }
    
    return rooms;
}

- (NSArray*) getWorkAreasInfo: (ProjectTaskFilterContent*) content
                      fromTag: (NSUInteger)                tag
{
    __block NSMutableArray* workAreas = [NSMutableArray array];
    
    if ( content.workAreas.count == [[DataManagerShared getFilterWorkAreasForCurrentProject] count] )
    {
        FilterTagParameterInfo* workAreasInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Система"
                                                                            withParameterType: WorkAreasAllFilterParameter
                                                                             withParameterTag: tag
                                                                                    withValue: nil];
        
        [workAreas addObject: workAreasInfo];
    }
    else
    {
        [content.workAreas enumerateObjectsUsingBlock: ^(ProjectTaskWorkArea * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            NSString* title = [NSString stringWithFormat: @"Сис: %@", obj.title];
            
            FilterTagParameterInfo* workAreaInfo = [[FilterTagParameterInfo alloc] initWithTitle: title
                                                                               withParameterType: WorkAreasFilterParameter
                                                                                withParameterTag: tag + idx
                                                                                       withValue: obj.workAreaID];
            
            [workAreas addObject: workAreaInfo];
            
        }];
    }
    
    return workAreas;
}

- (NSArray*) getTypesInfo: (ProjectTaskFilterContent*) content
                  fromTag: (NSUInteger)                tag
{
    __block NSMutableArray* types = [NSMutableArray array];
    NSArray* typesContentInfo     = [DataManagerShared getFilterTypesForCurrentProject];
    
    if ( [(NSArray*)content.types count] == typesContentInfo.count )
    {
        FilterTagParameterInfo* typesInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Тип задачи"
                                                                        withParameterType: TypeAllFilterParameter
                                                                         withParameterTag: tag
                                                                                withValue: nil];
        
        [types addObject: typesInfo];
    }
    else
    {
        
        [(NSArray*)content.types enumerateObjectsUsingBlock: ^(NSNumber*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSDictionary* typeDicInfo = typesContentInfo[idx];
            
            FilterTagParameterInfo* typeInfo = [[FilterTagParameterInfo alloc] initWithTitle: typeDicInfo[@"title"]
                                                                           withParameterType: TypeFilterParameter
                                                                            withParameterTag: tag + idx
                                                                                   withValue: @(idx)];
            
            [types addObject: typeInfo];
            
        }];
    }
    
    return types;
}

- (NSArray*) getBooleansInfo: (ProjectTaskFilterContent*) content
                     fromTag: (NSUInteger)                tag
{
    __block NSMutableArray* booleanValues = [NSMutableArray array];
    
    if ( content.isDone )
    {
        FilterTagParameterInfo* doneInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Выполненные"
                                                                       withParameterType: DoneFilterParameter
                                                                        withParameterTag: tag
                                                                               withValue: nil];
        
        [booleanValues addObject: doneInfo];
    }
    
    if ( content.isExpired )
    {
        FilterTagParameterInfo* expiredInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Только просроченные"
                                                                          withParameterType: ExpiredFilterParameter
                                                                           withParameterTag: tag + booleanValues.count
                                                                                  withValue: nil];
        
        [booleanValues addObject: expiredInfo];
    }
    
    if ( content.isCanceled )
    {
        FilterTagParameterInfo* canceledInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Отмененные"
                                                                           withParameterType: CanceledFilterParameter
                                                                            withParameterTag: tag + booleanValues.count
                                                                                   withValue: nil];
        
        [booleanValues addObject: canceledInfo];
    }
    
    return booleanValues;
}

@end
