//
//  NSObject+Sorting.h
//  TookTODO
//
//  Created by Lera on 04.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigurationManager.h"
#import "ProjectTaskResponsible+CoreDataClass.h"
#import "ProjectTaskStage+CoreDataClass.h"
#import "ProjectsEnumerations.h"

// Categories
#import "DataManager+ProjectInfo.h"
#import "DataManager+Tasks.h"

@interface NSObject (Sorting)

- (NSArray*) getPopoverContent;

- (ContentAccedingSortingType) getTasksSortingAscendingType;

- (TasksSortingType) getTasksSortingType;


- (NSArray*) applyTasksSortingType: (TasksSortingType)           type
                           toArray: (NSArray*)                   array
                        isAcceding: (ContentAccedingSortingType) isAcceding;

@end
