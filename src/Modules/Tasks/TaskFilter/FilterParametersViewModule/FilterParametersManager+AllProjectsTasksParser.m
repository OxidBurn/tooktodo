//
//  FilterParametersManager+AllProjectsTasksParser.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterParametersManager+AllProjectsTasksParser.h"

// Classes
#import "FilterTagParameterInfo.h"
#import "DataManager+AllProjectsFilter.h"
#import "AllProjectTasksFilterContent+CoreDataClass.h"
#import "DataManager+Filters.h"
#import "DataManager+ProjectInfo.h"


// Categories
#import "FilterParametersManager+ProjectTasksFilterParser.h"

@implementation FilterParametersManager (AllProjectsTasksParser)

- (NSArray*) parseContentForAllProjectsTasks
{
    AllProjectTasksFilterContent* filterContent = [DataManagerShared getAllProjectsTaskFilterContent];
    
    NSMutableArray* tmpFilterParametersContent = [NSMutableArray array];
    
    // Role in project
    NSArray* role = [self getRoleInProjectInfo: filterContent];
    
    [tmpFilterParametersContent addObjectsFromArray: role];
    
    // Dates
    NSArray* dates = [self getAllDatesInfo: filterContent
                                   fromTag: tmpFilterParametersContent.count];
    
    [tmpFilterParametersContent addObjectsFromArray: dates];
    
    // Projects
    NSArray* projects = [self getAllProjectInfo: filterContent
                                        fromTag: tmpFilterParametersContent.count];
    
    [tmpFilterParametersContent addObjectsFromArray: projects];
    
    // Statuses
    NSArray* statuses = [self getAllStatusesInfo: filterContent
                                         fromTag: tmpFilterParametersContent.count];
    
    [tmpFilterParametersContent addObjectsFromArray: statuses];
    
    // Types
    NSArray* types = [self getAllTypesInfo: filterContent
                                   fromTag: tmpFilterParametersContent.count];
    
    [tmpFilterParametersContent addObjectsFromArray: types];
    
    // Boolean values
    NSArray* booleans = [self getAllBooleansInfo: filterContent
                                         fromTag: tmpFilterParametersContent.count];
    
    [tmpFilterParametersContent addObjectsFromArray: booleans];
    
    return tmpFilterParametersContent;
}


#pragma mark - Internal methods -

- (NSArray*) getRoleInProjectInfo: (AllProjectTasksFilterContent*) content
{
    NSArray* rolesTitlesArray = @[ @"Я участник",
                                   @"Я ответственный",
                                   @"Я утверждающий",
                                   @"Я создатель" ];
    
    NSString* title = rolesTitlesArray[content.rolesInProject.integerValue];
    
    FilterTagParameterInfo* roleInProjectParameter = [[FilterTagParameterInfo alloc] initWithTitle: title
                                                                                 withParameterType: ProjectRoleFilterParameter
                                                                                  withParameterTag: 0
                                                                                         withValue: content.rolesInProject];
    
    return @[roleInProjectParameter];
}

- (NSArray*) getAllDatesInfo: (AllProjectTasksFilterContent*) content
                     fromTag: (NSUInteger)                    tag
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
                                                                              withParameterType: FactualEndDateFilterParameter
                                                                               withParameterTag: tag + dates.count
                                                                                      withValue: nil];
        
        [dates addObject: factEndDateInfo];
    }
    
    return dates;
}

- (NSArray*) getAllProjectInfo: (AllProjectTasksFilterContent*) content
                       fromTag: (NSUInteger)                    tag
{
    __block NSMutableArray* projects = [NSMutableArray array];
    NSArray* allProjectsInfo         = [DataManagerShared getAllProjects];
    
    if ( content.projects.count == allProjectsInfo.count )
    {
        FilterTagParameterInfo* projectsInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Проекты"
                                                                           withParameterType: ProjectsAllFilterParameter
                                                                            withParameterTag: tag
                                                                                   withValue: nil];
        
        [projects addObject: projectsInfo];
    }
    else
    {
        [content.projects enumerateObjectsUsingBlock: ^(ProjectInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            FilterTagParameterInfo* projectInfo = [[FilterTagParameterInfo alloc] initWithTitle: obj.title
                                                                              withParameterType: ProjectsFilterParameter
                                                                               withParameterTag: tag + idx
                                                                                      withValue: obj.projectID];
            
            [projects addObject: projectInfo];
            
        }];
    }
    
    return projects;
}

- (NSArray*) getAllTypesInfo: (AllProjectTasksFilterContent*) content
                     fromTag: (NSUInteger)                    tag
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
                                                                                   withValue: obj];
            
            [types addObject: typeInfo];
            
        }];
    }
    
    return types;
}

- (NSArray*) getAllStatusesInfo: (AllProjectTasksFilterContent*) content
                        fromTag: (NSUInteger)                    tag
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
                                                                                      withValue: obj];
            
            [statuses addObject: statuseInfo];
            
        }];
    }
    
    return statuses;
}

- (NSArray*) getAllBooleansInfo: (AllProjectTasksFilterContent*) content
                        fromTag: (NSUInteger)                tag
{
    __block NSMutableArray* booleanValues = [NSMutableArray array];
    
    if ( content.isDone.boolValue )
    {
        FilterTagParameterInfo* doneInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Выполненные"
                                                                       withParameterType: DoneFilterParameter
                                                                        withParameterTag: tag
                                                                               withValue: nil];
        
        [booleanValues addObject: doneInfo];
    }
    
    if ( content.isExpired.boolValue )
    {
        FilterTagParameterInfo* expiredInfo = [[FilterTagParameterInfo alloc] initWithTitle: @"Только просроченные"
                                                                          withParameterType: ExpiredFilterParameter
                                                                           withParameterTag: tag + booleanValues.count
                                                                                  withValue: nil];
        
        [booleanValues addObject: expiredInfo];
    }
    
    if ( content.isCanceled.boolValue )
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
