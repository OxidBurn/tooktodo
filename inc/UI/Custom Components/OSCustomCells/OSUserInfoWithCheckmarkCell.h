//
//  OSUserInfoWithCheckmarkCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 22.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "FilledTeamInfo.h"
#import "ProjectTaskAssignee+CoreDataProperties.h"

@interface OSUserInfoWithCheckmarkCell : UITableViewCell

// methods
- (void) fillCellWithFilledMemberInfo: (FilledTeamInfo*) memberInfo
                        withCheckmark: (BOOL)            isSelected;

- (void) changeCheckmarkState: (BOOL) state;

- (BOOL) currentCheckMarkState;

- (void) fillCellWithAssignee: (ProjectTaskAssignee*) assignee
                withCheckMark: (BOOL)                 isSelected;

@end
