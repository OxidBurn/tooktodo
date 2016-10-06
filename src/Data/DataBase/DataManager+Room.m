//
//  DataManager+Room.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+Room.h"

// Entities
#import "ProjectTaskMapContour+CoreDataClass.h"
#import "RoomLevelMap+CoreDataClass.h"

// Models
#import "RoomLevelMapModel.h"

// Classes
#import "DataManager+ProjectInfo.h"

@implementation DataManager (Room)

- (void) persistTaskRoomLevel: (TaskRoomLevelModel*)     info
                      forTask: (ProjectTask*)            task
                    inContext: (NSManagedObjectContext*) context
{
    ProjectTaskRoomLevel* roomLevel = [ProjectTaskRoomLevel MR_findFirstOrCreateByAttribute: @"roomLevel"
                                                                                  withValue: @(info.roomLevelID)
                                                                                  inContext: context];
    
    roomLevel.task      = task;
    roomLevel.project   = task.project;
    roomLevel.roomLevel = @(info.roomLevelID);
    roomLevel.level     = @(info.level);
    
    if ( info.map )
    {
        [self persistMap: info.map
            forRoomLevel: roomLevel
               inContext: context];
    }
}

- (void) persistTaskRoomLevel: (TaskRoomLevelModel*)     info
                   forProject: (ProjectInfo*)            project
                    inContext: (NSManagedObjectContext*) context
{
    ProjectTaskRoomLevel* roomLevel = [ProjectTaskRoomLevel MR_findFirstOrCreateByAttribute: @"roomLevel"
                                                                                  withValue: @(info.roomLevelID)
                                                                                  inContext: context];
    
    roomLevel.project   = project;
    roomLevel.roomLevel = @(info.roomLevelID);
    roomLevel.level     = @(info.level);
    
    if ( info.map )
    {
        [self persistMap: info.map
            forRoomLevel: roomLevel
               inContext: context];
    }
    
    [info.rooms enumerateObjectsUsingBlock: ^(TaskRoomModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self persistRoom: obj
             forRoomLevel: roomLevel
                inContext: context];
        
    }];
    
}

- (void) persistRoom: (TaskRoomModel*)          info
        forRoomLevel: (ProjectTaskRoomLevel*)   roomLevel
           inContext: (NSManagedObjectContext*) context
{
    NSPredicate* existPredicate = [NSPredicate predicateWithFormat: @"roomID == %@ AND roomLevel == %@", @(info.roomID), roomLevel];
    
    ProjectTaskRoom* room = [ProjectTaskRoom MR_findFirstWithPredicate: existPredicate
                                                             inContext: context];
    
    if ( room == nil )
    {
        room = [ProjectTaskRoom MR_createEntityInContext: context];
    }
    
    room.roomLevel = roomLevel;
    room.roomID    = @(info.roomID);
    room.number    = info.number;
    room.title     = info.title;
    
    room.roomLevelId         = info.roomLevelId;
    room.tasksCount          = info.tasksCount;
    room.tasksWithoutMarkers = info.tasksWithoutMarkers;
    
    ProjectTaskMapContour* mapContour = [self persistMapContour: info.mapContour
                                                      inContext: context];
    
    room.mapContour = mapContour;
}

- (void) persistTaskRoom: (TaskRoomModel*)          info
                 forTask: (ProjectTask*)            task
            isSingleRoom: (BOOL)                    isSingle
               inContext: (NSManagedObjectContext*) context
{
    ProjectTaskRoom* room = [ProjectTaskRoom MR_findFirstOrCreateByAttribute: @"roomID"
                                                                   withValue: @(info.roomID)
                                                                   inContext: context];
    
    room.task   = task;
    room.roomID = @(info.roomID);
    room.number = info.number;
    room.title  = info.title;
    
    if ( isSingle == NO )
    {
        room.roomLevelId         = info.roomLevelId;
        room.tasksCount          = info.tasksCount;
        room.tasksWithoutMarkers = info.tasksWithoutMarkers;
    }
    
    ProjectTaskMapContour* mapContour = [self persistMapContour: info.mapContour
                                                      inContext: context];
    
    room.mapContour = mapContour;
    
}

- (ProjectTaskMapContour*) persistMapContour: (TaskMapContourModel*)    info
                                   inContext: (NSManagedObjectContext*) context
{
    ProjectTaskMapContour* mapContour = [ProjectTaskMapContour MR_findFirstOrCreateByAttribute: @"mapContourID"
                                                                                     withValue: @(info.mapContourID)
                                                                                     inContext: context];
    
    mapContour.geoJson      = info.geoJson;
    mapContour.mapContourID = @(info.mapContourID);
    mapContour.previewImage = info.previewImage;
    mapContour.roomId       = @(info.roomId);
    
    return mapContour;
}

- (void) persistMap: (RoomLevelMapModel*)      info
       forRoomLevel: (ProjectTaskRoomLevel*)   roomLevel
          inContext: (NSManagedObjectContext*) context
{
    RoomLevelMap* map = [RoomLevelMap MR_findFirstOrCreateByAttribute: @"mapId"
                                                            withValue: info.mapId
                                                            inContext: context];
    
    map.hasMarkers          = info.hasMarkers;
    map.mapId               = info.mapId;
    map.originalImage       = info.originalImage;
    map.previewImage        = info.previewImage;
    map.originalImageWidth  = info.originalImageWidth;
    map.originalImageHeight = info.originalImageHeight;
    
    [info.mapContours enumerateObjectsUsingBlock: ^(TaskMapContourModel* mapContourInfo, NSUInteger idx, BOOL * _Nonnull stop) {
       
        ProjectTaskMapContour* mapContour = [self persistMapContour: mapContourInfo
                                                          inContext: context];
        
        [map addMapContourObject: mapContour];
        
    }];
}

- (NSArray*) getAllRoomsLevelOfSelectedProject
{
    ProjectInfo* selectedProject = [DataManagerShared getSelectedProjectInfo];
    
    return selectedProject.roomLevel.array;
}

- (void) updateExpandedStateOfLevel: (ProjectTaskRoomLevel*) level
                     withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
            level.isExpanded = @(!level.isExpanded.boolValue);
        }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                        }];
}


- (void) updateSelectedStateOfLevel: (ProjectTaskRoomLevel*) level
                     withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        level.isSelected = @(!level.isSelected.boolValue);
        
        [level.rooms enumerateObjectsUsingBlock: ^(ProjectTaskRoom * _Nonnull obj, BOOL * _Nonnull stop) {
            
            [self updateSelectedStateOfRoom: obj
                             withCompletion: nil];
            
        }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (void) updateSelectedStateOfRoom: (ProjectTaskRoom*)      room
                    withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        
        room.isSelected = @(!room.isSelected.boolValue);
    }
                      completion:^(BOOL contextDidSave, NSError * _Nullable error) {
         
         if ( completion )
             completion(contextDidSave);
     }];
}

@end
