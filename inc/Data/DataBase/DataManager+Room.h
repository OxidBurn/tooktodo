//
//  DataManager+Room.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

// Models
#import "TaskRoomLevelModel.h"
#import "TaskRoomModel.h"
#import "TaskMapContourModel.h"

// Entities
#import "ProjectTaskRoomLevel+CoreDataClass.h"
#import "ProjectTask+CoreDataClass.h"
#import "ProjectTaskRoom+CoreDataClass.h"
#import "ProjectInfo+CoreDataClass.h"

@interface DataManager (Room)

// methods

- (void) persistTaskRoomLevel: (TaskRoomLevelModel*)     info
                      forTask: (ProjectTask*)            task
                    inContext: (NSManagedObjectContext*) context;

- (void) persistTaskRoomLevel: (TaskRoomLevelModel*)     info
                   forProject: (ProjectInfo*)            project
                    inContext: (NSManagedObjectContext*) context;

- (void) persistTaskRoom: (TaskRoomModel*)          info
                 forTask: (ProjectTask*)            task
            isSingleRoom: (BOOL)                    isSingle
               inContext: (NSManagedObjectContext*) context;

- (ProjectTaskMapContour*) persistMapContour: (TaskMapContourModel*)    info
                                   inContext: (NSManagedObjectContext*) context;

- (NSArray*) getAllRoomsLevelOfSelectedProject;

- (void) updateExpandedStateOfLevel: (ProjectTaskRoomLevel*) level
                     withCompletion: (CompletionWithSuccess) completion;

@end
