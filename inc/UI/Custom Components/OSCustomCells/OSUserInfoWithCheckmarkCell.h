//
//  OSUserInfoWithCheckmarkCell.h
//  TookTODO
//
//  Created by Глеб on 22.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "FilledTeamInfo.h"

@interface OSUserInfoWithCheckmarkCell : UITableViewCell

// methods
- (void) fillCellWithFilledMemberInfo: (FilledTeamInfo*) memberInfo;

- (void) changeCheckmarkState: (BOOL) state;

- (BOOL) currentCheckMarkState;

@end
