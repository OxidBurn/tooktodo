//
//  FilledTeamInfoPack.h
//  TookTODO
//
//  Created by Nikolay Chaban on 21.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FilledTeamInfo.h"
#import "ProjectTaskRoleAssignment+CoreDataClass.h"

@interface FilledTeamInfoPack : NSObject

+ (FilledTeamInfo*) convertObjectToTeamMember: (id) object;

+ (NSMutableArray*) adductAssignmentsToFilledTeamInfoInArray: (NSArray*) assignments;

@end
