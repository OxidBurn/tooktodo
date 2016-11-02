//
//  TaskFilterContentManager.h
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "ProjectInfo+CoreDataProperties.h"

@interface TaskFilterContentManager : NSObject

// methods
- (NSArray*) getTableViewContentForProjectInfo: (ProjectInfo*) projectInfo;

@end
