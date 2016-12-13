//
//  MenuProjectCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "ProjectInfo+CoreDataClass.h"

@interface MenuProjectCell : UITableViewCell

- (void) fillInfo: (ProjectInfo*) info;

@end
