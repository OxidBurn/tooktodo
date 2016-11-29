//
//  FilterParametersManager.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/28/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "DataManager+AllProjectsFilter.h"
#import "AllProjectTasksFilterContent+CoreDataClass.h"
#import "FilterParametersViewDataSource.h"
#import "FilterParameterViewDelegate.h"

typedef void(^FilterUpdateCompletion)(NSUInteger parametersCount);

typedef NS_ENUM(NSUInteger, ScreenTypeForFiltering)
{
    ProjectTaskScreenType,
    AllProjectTasksScreenType,
};

@interface FilterParametersManager : NSObject <FilterParametersViewDataSource, FilterParameterViewDelegate>

// properties

@property (copy, nonatomic) void(^didUpdateFilter)(NSUInteger count);

// methods

- (void) updateFilterContentForScreen: (ScreenTypeForFiltering) type
                       withCompletion: (FilterUpdateCompletion) completion;

- (NSUInteger) countOfFilterParameters;

@end
