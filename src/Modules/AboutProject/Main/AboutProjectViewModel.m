//
//  AboutProjectViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/7/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AboutProjectViewModel.h"

// Classes
#import "ProjectInfo+CoreDataClass.h"

// Categories
#import "DataManager+ProjectInfo.h"


@implementation AboutProjectViewModel


#pragma mark - Public methods -

- (NSString*) getProjectName
{
    return [DataManagerShared getSelectedProjectName];;
}

- (BOOL) isAvailableAddingNewRoleToSelectedProject
{
    ProjectInfo* selectedProject = [DataManagerShared getSelectedProjectInfo];
    
    return selectedProject.projectPermission.integerValue;
}

@end
