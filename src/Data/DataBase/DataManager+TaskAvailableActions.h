//
//  DataManager+TaskAvailableActions.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

// Classes
#import "TaskAvailableActionsModel.h"
#import "ProjectTask+CoreDataClass.h"

@interface DataManager (TaskAvailableActions)

- (void) persistTaskAvailableActions: (TaskAvailableActionsModel*) info
                             forTask: (ProjectTask*)               task
                      withCompletion: (CompletionWithSuccess)      compltion;

@end
