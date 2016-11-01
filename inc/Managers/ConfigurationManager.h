//
//  ConfigurationManager.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/24/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "ProjectsEnumerations.h"

@interface ConfigurationManager : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (ConfigurationManager*) sharedInstance;

/**
 *  Save sorting type of the projects
 *
 *  @param type sorting type
 */
- (void) saveSortingProjectsType: (AllProjectsSortingType)     type
                withAccedingType: (ContentAccedingSortingType) acceding;

- (AllProjectsSortingType) getProjectsSortingType;

- (ContentAccedingSortingType) getAccedingType;

- (void) saveSortedTasks: (TasksSortingType)           tasksType
       withAscendingType: (ContentAccedingSortingType) ascending;

- (TasksSortingType) getTasksSortingType;

- (ContentAccedingSortingType) getAccedingTypeForTasks;

@end
