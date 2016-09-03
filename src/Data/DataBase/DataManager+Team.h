//
//  DataManager+Team.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

// Classes
#import "TeamMember.h"
#import "ProjectInfo.h"

@interface DataManager (Team)

- (void) persistTeamMemebers: (NSArray*)              teamList
                   inProject: (ProjectInfo*)          project
              withCompletion: (CompletionWithSuccess) completion;

- (NSArray*) getAllTeamInfo;

@end
