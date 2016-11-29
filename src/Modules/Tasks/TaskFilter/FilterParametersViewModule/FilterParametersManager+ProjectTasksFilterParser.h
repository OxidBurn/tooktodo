//
//  FilterParametersManager+ProjectTasksFilterParser.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterParametersManager.h"

@interface FilterParametersManager (ProjectTasksFilterParser)

- (NSArray*) parseContentForProjectTasks;

@end
