//
//  SortPopoverCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 24.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "ProjectsEnumerations.h"

@interface PopoverCell : UITableViewCell 

//properties

@property (assign, nonatomic) ContentAccedingSortingType sortType;

//methods
- (void) fillCellWithOptionString: (NSString*) option;

@end
