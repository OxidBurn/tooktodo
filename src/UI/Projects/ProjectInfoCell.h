//
//  ProjectInfoCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "ProjectInfo.h"

@interface ProjectInfoCell : UITableViewCell

// properties

@property (copy, nonatomic) void(^didSelectedProject)(NSNumber* projectID);

// methods

- (void) fillContent: (ProjectInfo*) info;



@end
