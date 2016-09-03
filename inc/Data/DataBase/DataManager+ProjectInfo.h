//
//  DataManager+ProjectInfo.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

// Classes
#import "ProjectInfo.h"
#import "ProjectInfoData.h"

@interface DataManager (ProjectInfo)

- (void) persistNewProjects: (NSArray*)  projects
             withCompletion: (void(^)()) completion;

- (NSArray*) getAllProjects;

- (BOOL) deleteAllProjects;

- (void) markFirstProjectAsSelected;

- (ProjectInfo*) getSelectedProjectInfo;

- (ProjectInfo*) getSelectedProjectInfoInContext: (NSManagedObjectContext*) context;

- (void) markProjectAsSelected: (ProjectInfo*)            project
                withCompletion: (void(^)(BOOL isSuccess)) completion;

@end
