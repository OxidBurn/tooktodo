//
//  ProjectTaskMarker+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectTaskMarker.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskMarker (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *mapId;
@property (nullable, nonatomic, retain) NSNumber *markerID;
@property (nullable, nonatomic, retain) NSNumber *roomLevelId;
@property (nullable, nonatomic, retain) NSNumber *x;
@property (nullable, nonatomic, retain) NSNumber *y;
@property (nullable, nonatomic, retain) NSManagedObject *task;

@end

NS_ASSUME_NONNULL_END
