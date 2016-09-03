//
//  TeamInfoModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "TeamMember.h"

// Categories
#import "DataManager+Team.h"

@interface TeamInfoModel : NSObject

- (void) updateTeamInfoWithCompletion: (CompletionWithSuccess) completion;

- (NSUInteger) countOfItems;

- (TeamMember*) teamMemberByIndex: (NSUInteger) index;

@end
