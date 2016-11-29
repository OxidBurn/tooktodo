//
//  FilterParametersManager+UpdatingProjectTaskFilter.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterParametersManager+UpdatingProjectTaskFilter.h"

// Classes
#import "DataManager+Filters.h"
#import "ProjectTaskFilterContent+CoreDataClass.h"
#import "DataManager+AllProjectsFilter.h"

@implementation FilterParametersManager (UpdatingProjectTaskFilter)


#pragma mark - Public method -

- (void) deleteFilterParameterWithInfo: (FilterTagParameterInfo*) info
                        withCompletion: (CompletionWithSuccess)   completion
{
    [DataManagerShared deleteProjectTasksFilterItem: info
                                     withCompletion: completion];
}

- (void) deleteAllProjectsFilterParameterWithInfo: (FilterTagParameterInfo*) info
                                   withCompletion: (CompletionWithSuccess)   completion
{
    [DataManagerShared deleteAllProjectsTasksFilterItem: info
                                         withCompletion: completion];
}

@end
