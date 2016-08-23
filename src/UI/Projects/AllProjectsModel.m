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

// Extensions
#import "DataManager+ProjectInfo.h"

@interface AllProjectsModel()

// properties



// methods


@end

@implementation AllProjectsModel

- (NSArray*) getProjectsContent
{
    return [self applyDefaultSorting: [DataManagerShared getAllProjects]];
}

- (NSArray*) applyProjectsSortingType: (AllProjectsSortingType) type
                              toArray: (NSArray*)               array
{
    [[ConfigurationManager sharedInstance] saveSortingProjectsType: type];
    
    return [self applyDefaultSorting: array];
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
