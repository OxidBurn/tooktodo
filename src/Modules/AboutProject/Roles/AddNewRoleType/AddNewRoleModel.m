//
//  AddNewRoleModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddNewRoleModel.h"

// Classes
#import "RolesService.h"

@implementation AddNewRoleModel

#pragma mark - Public methods -

- (RACSignal*) createRoleWithTitle: (NSString*) title
{
    return [[RolesService sharedInstance] addNewRoleForCurrentProjectWithTitle: title];
}

@end
