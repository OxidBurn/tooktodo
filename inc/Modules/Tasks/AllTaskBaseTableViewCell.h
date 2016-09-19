//
//  AllTaskBaseTableViewCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "ProjectsEnumerations.h"

@interface AllTaskBaseTableViewCell : UITableViewCell

// properties

@property (assign, nonatomic) AllTasksCellType cellType;

// methods

- (void) fillInfoForCell: (id) info;

- (CGFloat) getHeightForCell;

@end
