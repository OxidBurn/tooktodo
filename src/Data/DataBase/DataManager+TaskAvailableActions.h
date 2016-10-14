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

- (void) persistTaskAvailableActionsForSelectedTask: (TaskAvailableActionsModel*) info
                                     withCompletion: (CompletionWithSuccess)      compltion;

@end
