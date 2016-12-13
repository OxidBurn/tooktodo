//
//  DataManager+Roles.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

// Classes
#import "ProjectRoles.h"
#import "ProjectInfo+CoreDataClass.h"
#import "NewProjectRoleTypeModel.h"

@interface DataManager (Roles)

// methods

- (void) persistNewDefaultRoles: (NSArray*)              roles
                 withCompletion: (CompletionWithSuccess) completion;

- (void) persistNewRoles: (NSArray*)              roles
          withCompletion: (CompletionWithSuccess) completion;

- (void) persistNewRole: (NewProjectRoleTypeModel*) role
         withCompletion: (CompletionWithSuccess)    completion;

- (NSArray*) getAllRolesInCurrentProject;

- (NSArray*) getAllDefaultRoles;

@end
