//
//  RolesService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "ProjectInfo+CoreDataClass.h"

@interface RolesService : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (RolesService*) sharedInstance;

- (RACSignal*) loadAllRolesForProject: (ProjectInfo*) project;

- (RACSignal*) loadDefaultListOfRoles;

- (RACSignal*) getRolesOfTheSelectedProject;

- (RACSignal*) getDefaultRoles;

- (RACSignal*) addNewRoleForCurrentProjectWithTitle: (NSString*) roleTitle;

@end
