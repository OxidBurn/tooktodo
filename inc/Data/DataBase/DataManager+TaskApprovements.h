//
//  DataManager+TaskApprovements.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

// Classes
#import "TaskApprovementsModel.h"
#import "ProjectTask+CoreDataClass.h"

@interface DataManager (TaskApprovements)

- (void) persistNewTaskApprovements: (TaskApprovementsModel*)  info
                            forTask: (ProjectTask*)            task
                          inContext: (NSManagedObjectContext*) context;

@end
