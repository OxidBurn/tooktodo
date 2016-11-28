//
//  ApproverModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 25.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FilledTeamInfo.h"

@interface ApproverModel : NSObject

- (NSUInteger) countOfRows;

- (NSArray*) getTaskApprovers;

- (BOOL) isApprovedAssignee: (NSUInteger) index;

- (FilledTeamInfo*) getApproverUserForIndexPath: (NSUInteger) index;

@end
