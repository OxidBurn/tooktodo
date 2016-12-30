//
//  FilledTeamInfoPack.m
//  TookTODO
//
//  Created by Nikolay Chaban on 21.12.16.
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

+ (NSArray*) convertMembersToFilledTeamInfoFromArray: (NSArray*) array
{
    __block  FilledTeamInfo* convertedUser = nil;
    __block NSMutableArray* arrWithConvertedUsers = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock: ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        convertedUser = [self convertObjectToTeamMember: obj];
        
        [arrWithConvertedUsers addObject: convertedUser];
        
    }];
    
    return arrWithConvertedUsers;
}

@end
