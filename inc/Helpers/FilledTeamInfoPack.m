//
//  FilledTeamInfoPack.m
//  TookTODO
//
//  Created by Lera on 21.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilledTeamInfoPack.h"

@implementation FilledTeamInfoPack

+ (FilledTeamInfo*) convertObjectToTeamMember: (id) object
{
    FilledTeamInfo* selectedTeamMember = [FilledTeamInfo new];
    
    if ([object isKindOfClass: [ProjectTaskAssignee class]])
    {
        ProjectTaskAssignee* assignee = (ProjectTaskAssignee*)object;
        
        [selectedTeamMember convertAssigneeToTeamInfo: assignee];
    }
    
    else if ([object isKindOfClass: [ProjectInviteInfo class]])
    {
        ProjectInviteInfo* invite = (ProjectInviteInfo*)object;
        
        [selectedTeamMember convertInviteToTeamInfo: invite];
    }
    
    else if ([object isKindOfClass:[FilledTeamInfo class]])
    {
        selectedTeamMember = (FilledTeamInfo*)object;
    }
    
    return selectedTeamMember;
    
}

@end
