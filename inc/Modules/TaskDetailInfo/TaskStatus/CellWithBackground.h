//
//  CellWithBackground.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "ProjectsEnumerations.h"

@interface CellWithBackground : UITableViewCell

// mehthds

- (void) fillCellForTaskStatus: (TaskStatusType) statusType;

@end
