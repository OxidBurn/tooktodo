//
//  NewProjectRoleTypeModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import <JSONModel/JSONModel.h>

// Classes
#import "ProjectRoleTypeModel.h"
#import "NewProjectRoleTypeModelErrorsModel.h"

@interface NewProjectRoleTypeModel : JSONModel

@property (strong, nonatomic) ProjectRoleTypeModel* data;

@property (strong, nonatomic) NSNumber* isSuccess;

@property (strong, nonatomic) NSArray<NewProjectRoleTypeModelErrorsModel>* modelErrors;

@end
