//
//  AllProjectsModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AllProjectsModel.h"

// Classes
#import "ConfigurationManager.h"
#import "ProjectsService.h"

// Extensions
#import "DataManager+ProjectInfo.h"

@interface AllProjectsModel()

// properties



// methods


@end

@implementation AllProjectsModel

- (RACSignal*) getProjectsContent
{
    RACSignal* fetchAllProjectsSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSArray* projectsArray = [DataManagerShared getAllProjects];
        
        NSArray* sortedArray = [self applyDefaultSorting: projectsArray
                                              isAcceding: [self getProjectsSortAccedingType]];
        
        [subscriber sendNext: sortedArray];
        
        return nil;
    }];
    
    return fetchAllProjectsSignal;
}

- (NSArray*) applyProjectsSortingType: (AllProjectsSortingType)     type
                              toArray: (NSArray*)                   array
                           isAcceding: (ContentAccedingSortingType) isAcceding
{
    [[ConfigurationManager sharedInstance] saveSortingProjectsType: type
                                                  withAccedingType: isAcceding];
    
    return [self applyDefaultSorting: array
                          isAcceding: isAcceding];
}

- (AllProjectsSortingType) getProjectsSortedType
{
    return [[ConfigurationManager sharedInstance] getProjectsSortingType];
}

- (ContentAccedingSortingType) getProjectsSortAccedingType
{
    return [[ConfigurationManager sharedInstance] getAccedingType];
}

- (NSArray*) getProjectsSortedPopoverContent
{
    return @[@"Последнее посещение",
             @"Название",
             @"Адрес",
             @"Дата создания"];
}

- (NSArray*) filteredContentWithSearchText: (NSString*) searchText
                                   inArray: (NSArray*)  array
{
    NSPredicate* filteredPredicate = [NSPredicate predicateWithFormat: @"(SELF.title CONTAINS[c] %@) OR (SELF.address CONTAINS[c] %@)", searchText, searchText];
    
    return [array filteredArrayUsingPredicate: filteredPredicate];
}

- (void) markProjectAsSelected: (ProjectInfo*)          info
                withCompletion: (CompletionWithSuccess) completion
{
    [[ProjectsService sharedInstance] loadProjectData: info];
    
    [DataManagerShared markProjectAsSelected: info
                              withCompletion: completion];
}

#pragma mark - Internal methods -

- (NSArray*) applyDefaultSorting: (NSArray*) array
                      isAcceding: (BOOL)     isAcceding
{
    NSSortDescriptor* sortingDescriptor = [NSSortDescriptor sortDescriptorWithKey: [self getSortingKey]
                                                                        ascending: [self getCorrectAcceding: isAcceding]];
    
    NSArray* sortedArray = [array sortedArrayUsingDescriptors: @[sortingDescriptor]];

    return sortedArray;
}

- (NSString*) getSortingKey
{
    AllProjectsSortingType type = [[ConfigurationManager sharedInstance] getProjectsSortingType];
    
    switch (type)
    {
        case SortingByNameType:
        {
            return @"title";
            break;
        }
        case SortingByLastVisitingType:
        {
            return @"lastVisit";
            break;
        }
        case SortingByAdressType:
        {
            return @"address";
            break;
        }
        case SortingByCreationDateType:
        {
            return @"createdDate";
            break;
        }
    }
}

- (BOOL) getCorrectAcceding: (BOOL) acceding
{
    AllProjectsSortingType type = [[ConfigurationManager sharedInstance] getProjectsSortingType];
    
    switch (type)
    {
        case SortingByNameType:
        {
            return acceding;
            break;
        }
        case SortingByLastVisitingType:
        {
            return !acceding;
            break;
        }
        case SortingByAdressType:
        {
            return acceding;
            break;
        }
        case SortingByCreationDateType:
        {
            return !acceding;
            break;
        }
    }
}

@end
