//
//  ProjectRoleObject.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ProjectRoleModel : JSONModel

@property (strong, nonatomic) NSNumber * roleID;
@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSNumber * sort;
@property (strong, nonatomic) NSNumber * projectId;
@property (assign, nonatomic) BOOL     hasProjectRoleAssignments;

@end
