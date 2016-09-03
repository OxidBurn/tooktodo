//
//  ProjectsService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "ProjectInfo.h"

typedef void(^GetProjectsCompletion)(NSArray* projectsList);

@interface ProjectsService : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (ProjectsService*) sharedInstance;

- (RACSignal*) getAllProjectsList;

- (RACSignal*) updateAllProjectsListWithServer;

- (void) loadProjectData: (ProjectInfo*) project;

@end
