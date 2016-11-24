//
//  DataManager+Filters.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/24/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

typedef NS_ENUM(NSUInteger, ProjectFilterType)
{
    StatusFilterType,
    CreatorsFilterType,
    ResponsiblesFilterType,
    ApprovesFilterType,
    WorkAreasFilterType,
    TypesFilterType,
    ExpiredFilterType,
};

@interface DataManager (Filters)

- (void) persistProjectFilter: (NSDictionary*)         filter
                     withType: (ProjectFilterType)     type
             forProjectWithID: (NSNumber*)             projectID
               withCompletion: (CompletionWithSuccess) completion;

- (NSArray*) getFilterCreatorsListForCurrentProject;

@end
