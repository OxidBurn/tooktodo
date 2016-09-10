//
//  ProjectTaskRoom+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectTaskRoom.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskRoom (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *roomID;
@property (nullable, nonatomic, retain) NSNumber *number;
@property (nullable, nonatomic, retain) NSNumber *roomLevelId;
@property (nullable, nonatomic, retain) NSNumber *tasksCount;
@property (nullable, nonatomic, retain) NSNumber *tasksWithoutMarkers;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSManagedObject *mapContour;
@property (nullable, nonatomic, retain) ProjectTask *task;

@end

NS_ASSUME_NONNULL_END
