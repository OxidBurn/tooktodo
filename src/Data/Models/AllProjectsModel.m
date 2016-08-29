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
        
        [[[ProjectsService sharedInstance] getAllProjectsList] subscribeNext: ^(NSArray* projectsArray) {
            
            NSArray* sortedArray = [self applyDefaultSorting: projectsArray];
            
            [subscriber sendNext: sortedArray];
            
        } completed: ^{
            
            [subscriber sendCompleted];
            
        }];
        
        return nil;
    }];
    
    return fetchAllProjectsSignal;
}

- (NSArray*) applyProjectsSortingType: (AllProjectsSortingType) type
                              toArray: (NSArray*)               array
{
    [[ConfigurationManager sharedInstance] saveSortingProjectsType: type];
    
    return [self applyDefaultSorting: array];
}

- (NSUInteger) getProjectsSortedType
{
    return [[ConfigurationManager sharedInstance] getProjectsSortingType];
}

- (NSArray*) getProjectsSortedPopoverContent
{
    return @[@"Последнее посещение",
             @"Название",
             @"Адрес",
             @"Дата создания"];
}

#pragma mark - Internal methods -

- (NSArray*) applyDefaultSorting: (NSArray*) array
{
    NSSortDescriptor* sortingDescriptor = [NSSortDescriptor sortDescriptorWithKey: [self getSortingKey]
                                                                        ascending: YES];
    
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

@end
